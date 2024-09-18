mod byte_handler;
mod source;

use std::collections::VecDeque;
use std::fmt::Debug;

use self::{byte_handler::byte_handler, source::Source};

pub struct Lexer<'a> {
    source: Source<'a>,
    lookahead: VecDeque<Token>,
}

impl<'a> Lexer<'a> {
    pub fn new(source: &'a str) -> Self {
        Self {
            source: Source::new(source),
            lookahead: VecDeque::with_capacity(2),
        }
    }

    pub fn peek(&mut self) -> Option<&Token> {
        if self.lookahead.is_empty() {
            let token = self.next()?;
            self.lookahead.push_front(token);
        }
        Some(self.lookahead.front().unwrap())
    }

    pub fn next(&mut self) -> Option<Token> {
        if let Some(token) = self.lookahead.pop_front() {
            return Some(token);
        }

        loop {
            let Some(b) = self.source.peek() else {
                return None;
            };

            let start = self.source.offset();
            let kind = unsafe { byte_handler(b, &mut self.source) };
            if kind == Kind::Skip {
                continue;
            }

            return Some(Token {
                kind,
                span: (start..self.source.offset()).into(),
            });
        }
    }
}

impl Iterator for Lexer<'_> {
    type Item = Token;

    fn next(&mut self) -> Option<Self::Item> {
        self.next()
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
            let t = lex.next().unwrap();
            assert_eq!(t.kind, *kind);
            assert_eq!(source[t.span.start..t.span.end], *slice);
        }

        assert!(lex.next().is_none());
    }

    #[test]
    fn empty_lexer() {
        assert_lex("   ", []);
    }

    #[test]
    fn line_comment() {
        assert_lex(" // foo", []);
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

    #[ignore]
    #[test]
    fn keywords() {
        assert_lex(
            "
                task var
            ",
            &[(Kind::Task, "task"), (Kind::Var, "var")][..],
        )
    }

    #[test]
    fn operators() {
        assert_lex(
            "
                = | { }
            ",
            &[
                (Kind::Eq, "="),
                (Kind::Pipe, "|"),
                (Kind::LBrace, "{"),
                (Kind::RBrace, "}"),
            ][..],
        )
    }
}

// ---

#[derive(Default)]
pub struct Span {
    pub start: usize,
    pub end: usize,
}

use std::ops::Range;
impl From<Range<usize>> for Span {
    fn from(range: Range<usize>) -> Self {
        Self {
            start: range.start,
            end: range.end,
        }
    }
}

impl Debug for Span {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{}..{}", self.start, self.end)
    }
}

#[derive(Default)]
pub struct Token {
    pub kind: Kind,
    pub span: Span,
}

impl Debug for Token {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_tuple("Token")
            .field(&self.kind)
            .field(&self.span)
            .finish()
    }
}

#[derive(Debug, Default, PartialEq, Eq)]
pub enum Kind {
    Invalid,
    #[default]
    End,
    Skip,
    String,
    Number,
    Symbol,
    // Fence,
    // Punctor
    // Comma,
    Eq,
    LBrace,
    RBrace,
    Pipe,
    // Keywords
    Task,
    Var,
}
