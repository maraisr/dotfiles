use std::alloc::Allocator;
use std::alloc::Layout;
use std::ptr;

use bumpalo::Bump;

use lexer::Kind;
use lexer::Lexer;

use crate::diagnostics::Result;
use crate::lexer::Span;
use crate::lexer::Token;
use crate::report;

// type BoxNode<'a, T> = Box<Node<'a, T>, &'a Arena>;
type List<'a, T> = Vec<T, &'a Bump>;

#[derive(Debug)]
pub struct Node<'a, T: 'a> {
	pub span: Span,
	item: &'a T
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
	Task(Box<TaskDefinition<'a>, &'a Bump>)
}

#[derive(Debug)]
pub struct TaskDefinition<'a> {
	pub name: Literal<'a>
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
	}}
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
	fn node<T>(&mut self, item: T, span: Span) -> Node<'a, T>
	{
		let item = self.arena.alloc(item);
		Node { item, span }
	}

	pub fn parse(mut self) -> Result<List<'a, DefinitionNode<'a>>> {
		let mut ast: List<'a, DefinitionNode<'a>> = Vec::new_in(self.arena);

		while self.peek().kind != Kind::End {
			let def = self.parse_definition()?;
			ast.push(def);
		}

		Ok(ast)
	}

	#[inline]
	fn parse_definition(&mut self) -> Result<DefinitionNode<'a>> {
		match self.peek().kind {
			Kind::Task => self.parse_task(),
			_ => report!("Unexpected token", self.current.span.clone()),
		}
	}

	#[inline]
	fn parse_task(&mut self) -> Result<DefinitionNode<'a>> {
		let token = self.expect(Kind::Task)?;
		let span = token.span.clone();

		let name = self.parse_string_literal()?;

		let end = span.merge(&self.current.span);
		let task = Box::new_in(TaskDefinition { name }, self.arena);

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
}

// TODO: move this to a util
#[inline]
pub fn read_span<'a>(source: &'a str, span: &Span) -> &'a str {
	&source[span.start..span.end]
}
