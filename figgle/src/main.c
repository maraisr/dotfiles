#include <stdio.h>
#include <stdlib.h>

#include "common.h"
#include "lexer.h"

char *read_file(char *path) {
  FILE *f = fopen(path, "r");

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

da(Token, Tokens);

int main() {
  char *content = read_file("./fixtures/script.fig");
  Lexer lx = lexer_new(content);

  Tokens tokens = {};

  Token t;
  while ((t = lexer_next_token(&lx)).kind != TOKEN_END)
    da_append(&tokens, t);

  for (int i = 0; i < tokens.count; i++) {
    Token t = tokens.items[i];
    printf("%d :: '%.*s'\n", t.kind, (int)t.text_len, t.text);
  }

  return 0;
}
