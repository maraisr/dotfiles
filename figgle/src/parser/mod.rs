use lexer::Kind;
use lexer::Lexer;

use crate::error::Result;
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
	// TODO: can we do something like an Error factory? and enhance with source later?
	source: String,
	// arena: &'a mut bumpalo::Bump,
}

macro_rules! report {
	($source:expr, $token:expr) => {{
		let span = $token.span.clone();
		let source = $source.clone();
		Err(crate::error::Errors::ParsingError {
			src: source,
			token: $token,
			span: span.into(),
		})
	}};
}

impl<'a> Parser<'a> {
	pub fn new(source: &'a str) -> Self {
		let lexer = Lexer::new(source);
		Self {
			lexer,
			source: String::from(source),
		}
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
			// TODO: Yep no panic
			panic!("test");
		};
		if token.kind != kind {
			panic!("test");
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
				return report!(self.source, token);
			}
		}
	}
}
