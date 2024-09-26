use anyhow::Result;
use lexer::Kind;
use lexer::Lexer;

use crate::lexer::Token;

pub type AST = Vec<Definition>;

#[derive(Debug)]
pub enum Definition {
	TaskDefinition(Box<TaskDefinition>),
	Noop,
}

#[derive(Debug)]
pub struct TaskDefinition {}

pub struct Parser<'a> {
	lexer: Lexer<'a>,
	// arena: &'a mut bumpalo::Bump,
}

impl<'a> Parser<'a> {
	pub fn new(source: &'a str) -> Self {
		let lexer = Lexer::new(source);
		Self { lexer }
	}

	#[inline]
	fn peek(&mut self) -> Option<&Token> {
		self.lexer.peek()
	}

	#[inline]
	fn next(&mut self) -> Option<Token> {
		self.lexer.next()
	}

	fn expect(&mut self, kind: Kind) -> Result<Token> {
		let Some(token) = self.lexer.next() else {
			bail!("Expected token");
		};
		if token.kind != kind {
			bail!("Expected kind {kind:?} got {:?}", token.kind);
		}
		Ok(token)
	}

	pub fn parse(mut self) -> Result<AST> {
		let mut ast = Vec::new();

		loop {
			if self.peek().is_none() {
				break;
			}
			if let Ok(def) = self.definition() {
				ast.push(def);
			}
		}

		Ok(ast)
	}

	fn definition(&mut self) -> Result<Definition> {
		match self.peek().unwrap().kind {
			Kind::Symbol => {
				self.next();
				let task = TaskDefinition {};
				let def = Box::new(task);
				Ok(Definition::TaskDefinition(def))
			}
			_ => {
				self.next();
				bail!("TODO")
			}
		}
	}
}
