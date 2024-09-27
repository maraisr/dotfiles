mod byte_handler;

use std::collections::VecDeque;
use std::iter::Peekable;
use std::str::CharIndices;

use crate::syntax::{Kind, Span, Token};

use self::byte_handler::byte_handler;

pub struct Lexer<'a> {
	chars: Peekable<CharIndices<'a>>,
	lookahead: VecDeque<Token>,
}

impl<'a> Lexer<'a> {
	pub fn new(source: &'a str) -> Self {
		Self {
			chars: source.char_indices().peekable(),
			lookahead: VecDeque::with_capacity(2),
		}
	}

	pub fn peek(&mut self) -> &Token {
		if self.lookahead.is_empty() {
			let token = self.next();
			self.lookahead.push_front(token);
		}
		self.lookahead.front().unwrap()
	}

	pub fn next(&mut self) -> Token {
		if let Some(token) = self.lookahead.pop_front() {
			return token;
		}

		loop {
			let Some((_, c)) = self.chars.peek() else {
				return Token {
					kind: Kind::End,
					span: Span::default(),
				};
			};

			let token = unsafe { byte_handler(*c as u8, &mut self.chars) };
			match token {
				Some(token) => return token,
				_ => continue,
			}
		}
	}
}

#[cfg(test)]
mod test {
	use super::*;

	fn assert_lex<T>(source: &str, kinds: T)
	where
		T: AsRef<[(Kind, &'static str)]>,
	{
		let mut lex = Lexer::new(source);

		for &(ref kind, slice) in kinds.as_ref() {
			let t = lex.next();
			assert_eq!(t.kind, *kind);
			assert_eq!(source[t.span.start..t.span.end], *slice);
		}

		assert_eq!(lex.next().kind, Kind::End);
	}

	#[test]
	fn empty_lexer() {
		assert_lex("   ", []);
	}

	#[test]
	fn line_comment() {
		assert_lex(" // foo", []);
		assert_lex("// foo\n123", [(Kind::Number, "123")]);
	}

	#[test]
	fn identifier() {
		assert_lex("foo", [(Kind::Symbol, "foo")]);
		assert_lex("foo bar", [(Kind::Symbol, "foo"), (Kind::Symbol, "bar")]);
	}

	#[test]
	fn string() {
		assert_lex("\"foo\"", [(Kind::String, "\"foo\"")]);
		assert_lex("\"foo bar\"", [(Kind::String, "\"foo bar\"")]);
	}

	#[test]
	fn number() {
		assert_lex("123", [(Kind::Number, "123")]);
		assert_lex("123 456", [(Kind::Number, "123"), (Kind::Number, "456")]);
		assert_lex("123.456", [(Kind::Number, "123.456")]);
	}

	#[test]
	fn keywords() {
		assert_lex("task var", &[(Kind::Task, "task"), (Kind::Var, "var")][..])
	}

	#[test]
	fn operators() {
		assert_lex(
			"= | { }",
			&[
				(Kind::Eq, "="),
				(Kind::Pipe, "|"),
				(Kind::LBrace, "{"),
				(Kind::RBrace, "}"),
			][..],
		)
	}
}
