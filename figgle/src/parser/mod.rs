// TODO: Remove bumpalo fro this file directly, instead can we "teach it about an Allocator"

use bumpalo::Bump;

use crate::diagnostics::Result;
use crate::report;
use crate::lexer::Lexer;
use crate::syntax::Kind;
use crate::syntax::Span;
use crate::syntax::Token;

type List<'a, T> = Vec<T, &'a Bump>;
type Box<'a, T> = std::boxed::Box<T, &'a Bump>;

#[derive(Debug)]
pub struct AST<'a>(List<'a, DefinitionNode<'a>>);

#[derive(Debug)]
pub struct Node<'a, T: 'a> {
	pub span: Span,
	item: &'a T,
}

impl<'a, T> std::ops::Deref for Node<'a, T> {
	type Target = T;

	#[inline]
	fn deref(&self) -> &Self::Target {
		&self.item
	}
}

#[derive(Debug)]
pub enum Definition<'a> {
	Task(Box<'a, TaskDefinition<'a>>),
}

#[derive(Debug)]
pub struct TaskDefinition<'a> {
	pub name: Literal<'a>,
	// TODO: List of conditionals? Expressions?
	pub args: List<'a, (Literal<'a>, Literal<'a>)>,
}

type Literal<'a> = Node<'a, &'a str>;
type DefinitionNode<'a> = Node<'a, Definition<'a>>;

pub struct Parser<'a> {
	source: &'a str,
	lexer: Lexer<'a>,

	current: Token,

	arena: &'a Bump,
}

// TODO: Should this exist?
macro_rules! expect {
	($self:ident, $kind:expr) => {{
		$self.expect($kind)?;
		&$self.current
	}};
}

impl<'a> Parser<'a> {
	pub fn new(source: &'a str, arena: &'a Bump) -> Self {
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

	#[inline]
	fn node<T>(&mut self, item: T, span: Span) -> Node<'a, T> {
		let item = self.arena.alloc(item);
		Node { item, span }
	}

	pub fn parse(mut self) -> Result<AST<'a>> {
		let mut ast: List<'a, DefinitionNode<'a>> = Vec::new_in(self.arena);

		while self.peek().kind != Kind::End {
			let def = self.parse_definition()?;
			ast.push(def);
		}

		Ok(AST(ast))
	}

	#[inline]
	fn parse_definition(&mut self) -> Result<DefinitionNode<'a>> {
		let token = self.peek();
		match token.kind {
			Kind::Task => self.parse_task(),
			_ => report!("Unexpected token", token.span.clone()),
		}
	}

	#[inline]
	fn parse_task(&mut self) -> Result<DefinitionNode<'a>> {
		let start = self.current.span.clone();
		self.expect(Kind::Task)?;
		let name = self.parse_string_literal()?;
		let mut args = Vec::new_in(self.arena);

		loop {
			match &self.peek().kind {
				Kind::Symbol => {
					let name = self.parse_literal()?;
					self.expect(Kind::Eq)?;
					let value = self.parse_string_literal()?;
					args.push((name, value));
					if self.peek().kind == Kind::Comma {
						self.next();
					}
				}
				_ => { break; }
			}
		}

		let end = start.merge(&self.current.span);
		let task = Box::new_in(TaskDefinition { name, args }, self.arena);
		Ok(self.node(Definition::Task(task), end))
	}

	#[inline]
	fn parse_string_literal(&mut self) -> Result<Literal<'a>> {
		let s = self.source; // WTF?? Why does this need to exist before the expect?
		let token = expect!(self, Kind::String);
		let raw = read_span(&s, &token.span);
		// Trim the quote marks.
		let value = &raw[1..raw.len() - 1];
		Ok(self.node(value, token.span.clone()))
	}

	// TODO: Validate this
	#[inline]
	fn parse_literal(&mut self) -> Result<Literal<'a>> {
		let s = self.source; // WTF?? Why does this need to exist before the expect?
		let token = expect!(self, Kind::Symbol);
		let raw = read_span(&s, &token.span);
		Ok(self.node(raw, token.span.clone()))
	}
}

// TODO: move this to a util
#[inline]
pub fn read_span<'a>(source: &'a str, span: &Span) -> &'a str {
	&source[span.start..span.end]
}
