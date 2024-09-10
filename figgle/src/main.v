import os

fn main() {
	content := os.read_file("./fixtures/script.fig")!

	lexer := Lexer { content: content, cursor: 0  }
}

struct Lexer {
	content string
mut:
	cursor int
}
