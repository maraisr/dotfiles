pub type Result<T> = miette::Result<T, Errors>;

use miette::Diagnostic;
use miette::SourceSpan;
use thiserror::Error;

use crate::lexer::Token;

#[derive(Debug, Diagnostic, Error)]
pub enum Errors {
	#[diagnostic()]
	#[error("Parsing error")]
	ParsingError {
		#[source_code]
		src: String,
		#[label("Unexpected {token}")]
		span: SourceSpan,
		token: Token
	},
}
