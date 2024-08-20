use super::{Kind, Lexer};

pub(super) unsafe fn byte_handler(byte: u8, lexer: &mut Lexer) -> Kind {
    BYTE_HANDLERS[byte as usize](lexer)
}

type ByteHandler = unsafe fn(&mut Lexer<'_>) -> Kind;

/// Lookup table mapping any incoming byte to a handler function defined below.
/// <https://github.com/oxc-project/oxc/blob/c6d97e936639b2e1e58f4fd9fa82f65e29298af2/crates/oxc_parser/src/lexer/byte_handlers.rs>
#[rustfmt::skip]
static BYTE_HANDLERS: [ByteHandler; 256] = [
//  0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F    //
	EOF, ERR, ERR, ERR, ERR, ERR, ERR, ERR, ERR, ERR, SKP, ERR, ERR, SKP, ERR, ERR, // 0
    ERR, ERR, ERR, ERR, ERR, ERR, ERR, ERR, ERR, ERR, ERR, ERR, ERR, ERR, ERR, ERR, // 1
	SKP, SKP, QOD, SKP, SKP, SKP, SKP, SKP, SKP, SKP, SKP, SKP, SKP, SKP, SKP, SLH, // 2
	DIG, DIG, DIG, DIG, DIG, DIG, DIG, DIG, DIG, DIG, SKP, SKP, SKP, EQL, SKP, SKP, // 3
	SKP, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, // 4
    IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, SKP, SKP, SKP, SKP, SKP, // 5
	SKP, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, // 6
	IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, IDT, BRC, PIP, BRC, SKP, ERR, // 7
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
            fn $id($lex: &mut Lexer) -> Kind {
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
            fn $id(l: &mut Lexer) -> Kind {
                l.source.bump();
                $kind
            }
            $id
        };
    };
}

consume_into!(EOF, Kind::End);
consume_into!(ERR, Kind::Invalid);
consume_into!(SKP, Kind::Skip);
consume_into!(PIP, Kind::Pipe);
consume_into!(EQL, Kind::Eq);

// "
byte_handler!(QOD(lexer) {
    lexer.source.bump();
    loop {
        match lexer.source.peek() {
            Some('"') => {
                lexer.source.bump();
                return Kind::String
            },
            _ => lexer.source.bump()
        }
    }
});

// 0..9
byte_handler!(DIG(lexer) {
    loop {
        match lexer.source.peek() {
            Some('0'..='9') => {lexer.source.bump();},
            Some('.') => {lexer.source.bump();},
            _ => return Kind::Number
        }
    }
});

// /
byte_handler!(SLH(lexer) {
    lexer.source.bump();
    while let Some(c) = lexer.source.peek() {
        lexer.source.bump();
        if c == '\n' {
            break;
        }
    }
    Kind::Skip
});

// { }
byte_handler!(BRC(lexer) {
    match lexer.source.next() {
        Some('{') => Kind::LBrace,
        _ => Kind::RBrace
    }
});

byte_handler!(IDT(lexer) {
	// TODO: can it be https://github.com/ratel-rust/ratel-core/blob/e55a1310ba69a3f5ce2a9a6eef643feced02ac08/ratel/src/lexer/util.rs#L2
    loop {
        match lexer.source.peek() {
			Some(c) => {
				if c.is_alphanumeric() {
					lexer.source.bump();
				} else {
					return Kind::Symbol
				}
			},
			_ => return Kind::Symbol
		}
    }
});

byte_handler!(UER(_lexer) {
    unreachable!();
});
