#include <stddef.h>

typedef enum {
    TOKEN_END = 0,
    TOKEN_INVALID,
    TOKEN_SYMBOL,
    TOKEN_KEYWORD,
    TOKEN_OPEN_PAREN,
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
