use lexer::Kind;
use lexer::Lexer;

use crate::diagnostics::Result;
use crate::lexer::Span;
use crate::lexer::Token;
use crate::report;

#[derive(Debug)]
pub enum Definition<'a> {
	TaskDefinition(Box<TaskDefinition<'a>>),
}

#[derive(Debug)]
pub struct TaskDefinition<'a> {
	name: Literal<'a>,
}

#[derive(Debug)]
pub struct Literal<'a> {
	span: Span,
	value: &'a str,
}

pub struct Parser<'a> {
	source: &'a str,
	lexer: Lexer<'a>,

	current: Token,

	arena: &'a bumpalo::Bump,
}

impl<'a> Parser<'a> {
	pub fn new(source: &'a str, arena: &'a bumpalo::Bump) -> Self {
		let lexer = Lexer::new(source);
		Self {
			lexer,
			source,
			arena,
			current: Token::default(),
		}
	}

	#[inline]
	fn peek(&mut self) -> &Token {
		self.lexer.peek()
	}

	#[inline]
	fn next(&mut self) -> &Token {
		self.current = self.lexer.next();
		&self.current
	}

	#[inline]
	fn expect(&mut self, kind: Kind) -> Result<&Token> {
		let token = self.next();
		if token.kind != kind {
			let msg = format!("Expected {kind:?} got {:?}", token.kind);
			report!(msg, token.span.clone());
		}
		Ok(token)
	}

	pub fn parse(mut self) -> Result<Vec<Definition<'a>, &'a bumpalo::Bump>> {
		let mut ast = Vec::<Definition<'a>, &bumpalo::Bump>::new_in(self.arena);

		while self.peek().kind != Kind::End {
			let def = self.parse_definition()?;
			ast.push(def);
		}

		Ok(ast)
	}

	#[inline]
	pub fn parse_definition(&mut self) -> Result<Definition<'a>> {
		match self.peek().kind {
			Kind::Task => self.parse_task(),
			_ => report!("Unexpected token", self.current.span.clone()),
		}
	}

	#[inline]
	fn parse_task(&mut self) -> Result<Definition<'a>> {
		self.expect(Kind::Task)?;
		let name = self.parse_string_literal()?;

		let b = Box::new(TaskDefinition { name });
		return Ok(Definition::TaskDefinition(b));
	}

	#[inline]
	fn parse_string_literal(&mut self) -> Result<Literal<'a>> {
		let s = self.source; // WTF?? Why does this need to exist before the expect?
		let token = self.expect(Kind::String)?;
		let raw = read_span(&s, &token.span);
		// Trim the quote marks.
		let value = &raw[1..raw.len() - 1];
		Ok(Literal {
			value,
			span: token.span.clone(),
		})
	}
}

#[inline]
fn read_span<'a>(source: &'a str, span: &Span) -> &'a str {
	&source[span.start..span.end]
}
