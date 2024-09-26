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
	fn peek(&mut self) -> Option<&Token> {
		self.lexer.peek()
	}

	#[inline]
	fn next(&mut self) -> &Token {
		self.current = self.lexer.next();
		&self.current
	}

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

		println!("{:?}", self.current);

		while self.current.kind != Kind::End {
			let def = self.parse_definition()?;
			ast.push(def);
		}

		Ok(ast)
	}

	#[inline]
	pub fn parse_definition(&mut self) -> Result<Definition<'a>> {
		match self.next().kind {
			Kind::Task => self.parse_task(),
			_ => report!("Unexpected token", self.current.span.clone()),
		}
	}
}

// Task parser
impl<'a> Parser<'a> {
	fn parse_task(&mut self) -> Result<Definition<'a>> {
		let token = self.expect(Kind::Task)?;
		let name = self.parse_string_literal()?;

		let b = Box::new(TaskDefinition { name });
		return Ok(Definition::TaskDefinition(b));
	}
}

// Helpers
impl<'a> Parser<'a> {
	fn parse_string_literal(&mut self) -> Result<Literal<'a>> {
		report!("test")
		// let t = self.expect(Kind::String)?;
		// let raw = read_span(&self.source, &t.span);
		// let value = &raw[1..raw.len() - 1];
		// Ok(Literal { value, span: t.span.clone() })
	}
}

#[inline]
fn read_span<'a>(source: &'a str, span: &Span) -> &'a str {
	&source[span.start..span.end]
}
