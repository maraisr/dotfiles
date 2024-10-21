use std::borrow::Cow;

use crate::syntax::Span;

pub type Result<T> = std::result::Result<T, Diagnostic>;

pub struct Diagnostic(Box<Diag>);

impl Diagnostic {
	pub fn new<T>(message: Cow<'static, str>, spans: T) -> Self
	where
		T: IntoIterator<Item = Span>,
	{
		let spans = spans.into_iter().map(Into::into).collect();
		Self(Box::new(Diag { message, spans }))
	}
}

impl std::error::Error for Diagnostic {}

impl std::fmt::Display for Diagnostic {
	fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
		write!(f, "{}", &self.message)
	}
}

impl std::ops::Deref for Diagnostic {
	type Target = Box<Diag>;

	fn deref(&self) -> &Self::Target {
		&self.0
	}
}

impl std::fmt::Debug for Diagnostic {
	fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
		self.0.fmt(f)
	}
}

#[derive(Debug)]
pub struct Diag {
	pub message: Cow<'static, str>,
	// TODO: probs this is a vector of LabeledSpans
	pub spans: Vec<Span>,
}

#[macro_export]
macro_rules! report {
	($msg:expr) => {
		{
			use crate::diagnostics::Diagnostic;
			Err(Diagnostic::new($msg.into(), vec![]))?
		}
	};
	($msg:expr, $($label:expr),*) => {
		{
			use crate::diagnostics::Diagnostic;
			Err(Diagnostic::new($msg.into(), vec![$($label.into()),*]))?
		}
	};
}
