// TODO
// - Capturing the start and end of a token, can probably be nicer than mutating an `end`
// - When we SKIP, can we still hoist the token, but ignore it in the parser?
// - To check the symbol is a keyword, we need to read the char, can we just capture the start/end
//   and read from source, than build a new string?
// - This file should ideally just be calling methods on a Lexer, and not doing the work itself

use std::iter::Peekable;
use std::str::CharIndices;

use super::Kind;
use super::Token;

type Source<'a> = Peekable<CharIndices<'a>>;

pub(super) unsafe fn byte_handler(byte: u8, source: &mut Source<'_>) -> Option<Token> {
	BYTE_HANDLERS[byte as usize](source)
}

type ByteHandler = unsafe fn(&mut Source<'_>) -> Option<Token>;

/// Lookup table mapping any incoming byte to a handler function defined below.
/// <https://github.com/oxc-project/oxc/blob/c6d97e936639b2e1e58f4fd9fa82f65e29298af2/crates/oxc_parser/src/source/byte_handlers.rs>
#[rustfmt::skip]
static BYTE_HANDLERS: [ByteHandler; 256] = [
//  0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F    //
	EOF, ERR, ERR, ERR, ERR, ERR, ERR, ERR, ERR, ERR, SKP, ERR, ERR, SKP, ERR, ERR, // 0
    ERR, ERR, ERR, ERR, ERR, ERR, ERR, ERR, ERR, ERR, ERR, ERR, ERR, ERR, ERR, ERR, // 1
	SKP, SKP, QOD, SKP, SKP, SKP, SKP, SKP, SKP, SKP, SKP, SKP, COM, SKP, SKP, SLH, // 2
	DIG, DIG, DIG, DIG, DIG, DIG, DIG, DIG, DIG, DIG, SKP, SKP, SKP, EQL, SKP, SKP, // 3
	SKP, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, // 4
    IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, SKP, SKP, SKP, SKP, SKP, // 5
	SKP, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, // 6
	IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, BCL, PIP, BCR, SKP, ERR, // 7
	UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, // 8
	UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, // 9
	UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, // A
	UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, // B
	UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, // C
	UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, // D
	UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, // E
	UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, UER, // F
];

macro_rules! byte_handler {
	($id:ident($lex:ident) $body:expr) => {
		const $id: ByteHandler = {
			#[allow(non_snake_case)]
			fn $id($lex: &mut Source<'_>) -> Option<Token> {
				$body
			}
			$id
		};
	};
}

macro_rules! consume_into {
	($id:ident, $kind:expr) => {
		const $id: ByteHandler = {
			#[allow(non_snake_case)]
			fn $id(l: &mut Source<'_>) -> Option<Token> {
				let (i, _) = l.next()?;
				if $kind == Kind::Skip {
					// TODO: Should we "skip" this token from appearing,
					// or return it and handle it in the parser?
					return None;
				}
				Some(Token {
					kind: $kind,
					span: (i..i + 1).into(),
				})
			}
			$id
		};
	};
}

consume_into!(EOF, Kind::End);
consume_into!(ERR, Kind::Invalid);
consume_into!(SKP, Kind::Skip);

consume_into!(PIP, Kind::Pipe); // |
consume_into!(EQL, Kind::Eq); // =
consume_into!(BCL, Kind::LBrace); // {
consume_into!(BCR, Kind::RBrace); // }
consume_into!(COM, Kind::Comma); // ,

// "
byte_handler!(QOD(source) {
	let (start, _) = source.next()?;
	// TODO: Can this end things be better?
	let mut end = start;
	while let Some((i, c)) = source.next() {
		if c == '"' {
			end = i;
			break;
		}
	}

	Some(Token { kind: Kind::String, span: (start..end+1).into()})
});

// 0..9
byte_handler!(DIG(source) {
	let (start, _) = source.next()?;
	let mut end = start;
	loop {
		match source.peek() {
			Some((i, c)) => {
				if c.is_digit(10) || c == &'.' {
					end = *i;
				} else {
					break;
				}
			}
			_ => break,
		}
		source.next();
	}

	Some(Token { kind: Kind::Number, span: (start..end+1).into()})
});

// /
byte_handler!(SLH(source) {
	source.next()?;
	while let Some((_, c)) = source.peek() {
		if c == &'\n' {
			break;
		}
		source.next()?;
	}
	None
});

byte_handler!(IDT(source) {
	let (start, c) = source.next()?;
	let mut end = start;
	// TODO: maybe we should pass the original source down, instead of allocating a new word.
	let mut word = c.to_string();
	while let Some((i, c)) = source.peek() {
		if !c.is_alphanumeric() {
			break;
		}
		end = *i;
		word.push(*c);
		source.next()?;
	}

	// TODO: maybe move this stuff into other files
	let kind = match word.as_str() {
		"task" => Kind::Task,
		"var" => Kind::Var,
		_ => Kind::Symbol
	};

	Some(Token { kind, span: (start..end+1).into()})
});

byte_handler!(UER(_source) {
	unreachable!();
});
