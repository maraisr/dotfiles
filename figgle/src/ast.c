#include "ast.h"

#include "common.h"
#include "lexer.h"
#include <stdio.h>
#include <stdlib.h>

typedef struct {
	enum {
		NT_PROGRAM = 0,
	} type;
	void** item;
	DA* children;
} Node;

void parse(const char *content) {


  // DA tokens = {};
  // Token t;
  // while ((t = lexer_next_token(&l)).kind != TOKEN_END) da_append(&tokens, &t);

  Lexer l = lexer_new(content);

  Node root = { .type = NT_PROGRAM };

  // for (int i = 0; i < tokens.count; i++) {
  //   Token t = tokens.items[i];
  //   printf("%d :: '%.*s'\n", t.kind, (int)t.text_len, t.text);
  // }
}
