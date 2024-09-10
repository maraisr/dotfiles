#include "lexer.h"

#include <ctype.h>
#include <stdbool.h>
#include <stdio.h>
#include <string.h>

typedef struct {
  TokenKind kind;
  const char *text;
} Literal_Token;

Literal_Token literal_tokens[] = {
    {.text = "(", .kind = TOKEN_OPEN_PAREN},
    {.text = ")", .kind = TOKEN_CLOSE_PAREN},
    {.text = "{", .kind = TOKEN_OPEN_CURLY},
    {.text = "}", .kind = TOKEN_CLOSE_CURLY},
    {.text = "|", .kind = TOKEN_PIPE},
};
#define literal_tokens_count                                                   \
  (sizeof(literal_tokens) / sizeof(literal_tokens[0]))

const char *keywords[] = {"setup", "provides", "command"};
#define keywords_count (sizeof(keywords) / sizeof(keywords[0]))

void lexer_trim_left(Lexer *l) {
  while (l->cursor < l->content_len && isspace(l->content[l->cursor])) {
    l->cursor += 1;
  }
}

bool lexer_starts_with(Lexer *l, const char *prefix) {
  size_t prefix_len = strlen(prefix);
  if (prefix_len == 0) {
    return true;
  }
  if (l->cursor + prefix_len - 1 >= l->content_len) {
    return false;
  }
  for (size_t i = 0; i < prefix_len; ++i) {
    if (prefix[i] != l->content[l->cursor + i]) {
      return false;
    }
  }
  return true;
}

Lexer lexer_new(const char *content) {
  Lexer l = {.content = content, .content_len = strlen(content)};
  return l;
}

Token lexer_next(Lexer *l) {
  lexer_trim_left(l);

  Token token = {.text = &l->content[l->cursor]};

  if (l->cursor >= l->content_len)
    return token;

  if (l->content[l->cursor] == '"') {
    l->cursor += 1;
    token.kind = TOKEN_STRING;

    while (l->cursor < l->content_len && l->content[l->cursor] != '"' &&
           l->content[l->cursor] != '\n') {
      l->cursor += 1;
    }
    if (l->cursor < l->content_len) {
      l->cursor += 1;
    }

    token.text_len = &l->content[l->cursor] - token.text;
    return token;
  }

  for (size_t i = 0; i < literal_tokens_count; ++i) {
    if (lexer_starts_with(l, literal_tokens[i].text)) {
      size_t text_len = strlen(literal_tokens[i].text);
      token.kind = literal_tokens[i].kind;
      token.text_len = text_len;
      l->cursor += text_len;
      return token;
    }
  }

  if (isalpha(l->content[l->cursor])) {
    token.kind = TOKEN_SYMBOL;

    while (l->cursor < l->content_len && isalpha(l->content[l->cursor])) {
      l->cursor += 1;
      token.text_len += 1;
    }

    for (size_t i = 0; i < keywords_count; ++i) {
      size_t keyword_len = strlen(keywords[i]);
      if (keyword_len == token.text_len &&
          memcmp(keywords[i], token.text, keyword_len) == 0) {
        token.kind = TOKEN_KEYWORD;
        break;
      }
    }

    return token;
  }

  l->cursor += 1;
  token.kind = TOKEN_INVALID;
  token.text_len = 1;
  return token;
}
