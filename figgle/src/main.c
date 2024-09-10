#include <stdio.h>
#include <stdlib.h>

#include "lexer.h"

#define DA(T, name)                                                            \
  typedef struct {                                                             \
    T *items;                                                                  \
    size_t count;                                                              \
    size_t capacity;                                                           \
  } name;

#define da_append(da, item)                                                    \
  do {                                                                         \
    if ((da)->count >= (da)->capacity) {                                       \
      (da)->capacity = (da)->capacity == 0 ? 256 : (da)->capacity * 2;         \
      (da)->items =                                                            \
          realloc((da)->items, (da)->capacity * sizeof(*(da)->items));         \
    }                                                                          \
                                                                               \
    (da)->items[(da)->count++] = (item);                                       \
  } while (0)

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

DA(Token, Tokens);

int main() {
  char *content = read_file("../facet/brew/brew.figgle");
  Lexer lx = lexer_new(content);

  Tokens tokens = {};

  Token t;
  while ((t = lexer_next(&lx)).kind != TOKEN_END) {
    PRINT_TOKEN(t);
    da_append(&tokens, t);
  }
}
