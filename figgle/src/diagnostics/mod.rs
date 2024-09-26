use std::borrow::Cow;

use miette::LabeledSpan;
use miette::SourceCode;

pub type Result<T> = std::result::Result<T, Diagnostic>;

pub struct Diagnostic(Box<Diag>);

impl Diagnostic {
	pub fn new<T>(message: Cow<'static, str>, labels: T) -> Self
	where
		T: IntoIterator<Item = LabeledSpan>,
	{
		let labels = labels.into_iter().map(Into::into).collect();
		Self(Box::new(Diag { message, labels }))
	}

	pub fn with_source_code<T: SourceCode + Send + Sync + 'static>(self, code: T) -> miette::Error {
		miette::Error::from(self).with_source_code(code)
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

impl miette::Diagnostic for Diagnostic {
	fn labels(&self) -> Option<Box<dyn Iterator<Item = LabeledSpan> + '_>> {
		Some(Box::new(self.labels.iter().cloned()))
	}
}

#[derive(Debug)]
pub struct Diag {
	pub message: Cow<'static, str>,
	pub labels: Vec<LabeledSpan>,
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
