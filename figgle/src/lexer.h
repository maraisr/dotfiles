#include <stddef.h>

typedef enum {
    TOKEN_END = 0,
    TOKEN_INVALID,
    TOKEN_OPEN_PAREN,
    TOKEN_CLOSE_PAREN,
    TOKEN_OPEN_CURLY,
    TOKEN_CLOSE_CURLY,
    TOKEN_PIPE,
    TOKEN_SYMBOL,
    TOKEN_KEYWORD,
    TOKEN_STRING,
} TokenKind;

typedef struct {
  TokenKind kind;
  const char *text;
  size_t text_len;
} Token;

typedef struct {
    const char *content;
    size_t content_len;
    size_t cursor;
} Lexer;

Lexer lexer_new(const char *content);
Token lexer_next(Lexer *l);

#ifndef PRINT_TOKEN
#define PRINT_TOKEN(token) do { \
    printf("KIND: %d Token: %.*s\n", token.kind, (int)token.text_len, token.text); \
} while(0);
#endif
