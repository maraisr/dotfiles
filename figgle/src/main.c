#include <stdio.h>
#include <stdlib.h>

#include "common.h"
#include "lexer.h"
#include "ast.h"

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

int main() {
  char *content = read_file("./fixtures/script.fig");

  parse(content);

  return 0;
}
