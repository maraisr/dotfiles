use lexer::Kind;
use lexer::Lexer;

use crate::report;
use crate::diagnostics::Result;
use crate::lexer::Token;

pub type AST = Vec<Definition>;

#[derive(Debug)]
pub enum Definition {
	TaskDefinition(Box<TaskDefinition>),
	Var(Token),
}

#[derive(Debug)]
pub struct TaskDefinition {
	name: Token,
}

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
			return Err(report!("Unexpected end of file"));
		};
		if token.kind != kind {
			let msg = format!("Expected {kind:?} got {:?}", token.kind);
			return Err(report!(msg, token.span));
		}
		Ok(token)
	}

	pub fn parse(mut self) -> Result<AST> {
		let mut ast = Vec::new();

		loop {
			if self.peek().is_none() {
				break;
			}

			let def = self.definition()?;
			ast.push(def);
		}

		Ok(ast)
	}

	fn definition(&mut self) -> Result<Definition> {
		let token = self.peek().unwrap().clone();

		// TODO: None of this is correct
		match token.kind {
			Kind::Task => {
				self.next();
				let name = self.expect(Kind::String)?;
				let task = TaskDefinition { name };
				let b = Box::new(task);
				return Ok(Definition::TaskDefinition(b));
			}
			// Kind::Symbol => {
			// 	self.next();
			// 	self.expect(Kind::Eq)?;
			// 	return Ok(Definition::Var(self.expect(Kind::String)?));
			// }
			_ => {
				report!("Unexpected definition", token.span)
			}
		}
	}
}
