use super::Span;

// TODO: remove this clone
#[derive(Default, Clone)]
pub struct Token {
	pub kind: Kind,
	pub span: Span,
}

impl std::fmt::Debug for Token {
	fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
		f.debug_tuple("Token").field(&self.kind).field(&self.span).finish()
	}
}

impl std::fmt::Display for Token {
	fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
		write!(f, "{:?}", self.kind)
	}
}

#[derive(Debug, Default, PartialEq, Eq, Clone)]
pub enum Kind {
	#[default]
	Invalid,
	End,
	Skip,
	String,
	Number,
	Symbol,
	Eq,
	LBrace,
	RBrace,
	Pipe,
	Task,
	Var,
}
