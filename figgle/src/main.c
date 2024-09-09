#include <stdio.h>
#include <stdlib.h>

#include "lexer.h"

char* read_file(char* path) {
	FILE* f = fopen(path, "r");

	char *buffer;
	long size;
	fseek(f, 0, SEEK_END);
	size = ftell(f);
	rewind(f);
	buffer = calloc(1, size);
	fread(buffer, size, 1, f);
	fclose(f);

	return buffer;
}

int main() {
	char* content = read_file("../facet/brew/brew.figgle");
	Lexer lx = lexer_new(content);

	Token t;
	while ((t = lexer_next(&lx)).kind != TOKEN_END) {
		if (t.kind == TOKEN_KEYWORD) {
			printf("Token kind: %d, Token text: ", t.kind);
			for (size_t i = 0; i < t.text_len; i++) {
				putchar(t.text[i]);
			}
			printf("\n");
		}
	}
}
