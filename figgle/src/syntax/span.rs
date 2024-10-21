#[derive(Default, Clone)]
pub struct Span {
	pub start: usize,
	pub end: usize,
}

impl Span {
	pub fn merge(self, other: &Span) -> Span {
		use std::cmp::max;
		use std::cmp::min;
		let start = min(self.start, other.start);
		let end = max(self.end, other.end);
		(start..end).into()
	}
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

impl std::fmt::Debug for Span {
	fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
		write!(f, "{}..{}", self.start, self.end)
	}
}
