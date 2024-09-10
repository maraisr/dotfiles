#include "lexer.h"

#include <assert.h>
#include <complex.h>
#include <ctype.h>
#include <stdbool.h>
#include <stdio.h>
#include <string.h>

void lexer_advance(Lexer *l, size_t s) {
	assert(s >= 0);
	while (s-- > 0 && l->cursor < l->content_len) l->cursor += 1;
}

void lexer_trim_left(Lexer *l) {
  while (isspace(l->content[l->cursor])) lexer_advance(l, 1);
}

bool lexer_starts_with(Lexer *l, const char *prefix) {
  size_t prefix_len = strlen(prefix);

  if (prefix_len == 0) return true;
  if (l->cursor + prefix_len - 1 >= l->content_len) return false;

  for (size_t i = 0; i < prefix_len; ++i) {
    if (prefix[i] != l->content[l->cursor + i]) {
      return false;
    }
  }
  return true;
}

Token lexer_token_literal(Lexer *l) {
	Token token = {.kind = TOKEN_SYMBOL, .text = &l->content[l->cursor], .text_len = 1};
	lexer_advance(l, 1);
	return token;
}

Lexer lexer_new(const char *content) {
  Lexer l = {.content = content, .content_len = strlen(content)};
  return l;
}

Token lexer_next_token(Lexer *l) {
  lexer_trim_left(l);

  // Commnets
  if (lexer_starts_with(l, "//")) {
	while(l->content[l->cursor] != '\n') lexer_advance(l, 1);
	lexer_trim_left(l);
  }

  Token token = {.text = &l->content[l->cursor]};

  if (l->cursor >= l->content_len) return token;

  // Strings
  if (l->content[l->cursor] == '"') {
    lexer_advance(l, 1);
    token.kind = TOKEN_STRING;

    while (l->cursor < l->content_len && l->content[l->cursor] != '"' &&
           l->content[l->cursor] != '\n') {
      lexer_advance(l, 1);
    }
    if (l->cursor < l->content_len) lexer_advance(l, 1);

    token.text_len = &l->content[l->cursor] - token.text;
    return token;
  }

  // Literals
  switch(l->content[l->cursor]) {
  	case '=': return lexer_token_literal(l);
   	case ',': return lexer_token_literal(l);
    case '{': return lexer_token_literal(l);
    case '}': return lexer_token_literal(l);
    case '|': return lexer_token_literal(l);
  }

  // Fence
  if (lexer_starts_with(l, "```")) {
	token.kind = TOKEN_FENCE;

	lexer_advance(l, 3);
	token.text_len += 3;

	while (l->cursor < l->content_len && !lexer_starts_with(l, "```")) {
		lexer_advance(l, 1);
      	token.text_len += 1;
	}

	lexer_advance(l, 3);
	token.text_len += 3;

	return token;
  }

  // Symbol
  if (isalpha(l->content[l->cursor])) {
    token.kind = TOKEN_SYMBOL;

    while (l->cursor < l->content_len && isalpha(l->content[l->cursor])) {
      lexer_advance(l, 1);
      token.text_len += 1;
    }

    return token;
  }

  lexer_advance(l, 1);
  token.kind = TOKEN_INVALID;
  token.text_len = 1;
  return token;
}
