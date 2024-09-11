#include <stdio.h>
#include <stdlib.h>

#include "ast.h"
#include "common.h"
#include "lexer.h"
#include "parser.h"

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

int main(int argc, char **argv) {
  if (argc > 1) {
    char *content = read_file(argv[1]);
    Node a = parse(content);
    print_node(&a, 0);
  } else {
    while (1) {
      printf("\n~> ");

      char buffer[1000];
      if (fgets(buffer, sizeof(buffer), stdin) != NULL) {
        Node a = parse(buffer);
        printf("==\n");
        print_node(&a, 0);
        printf("\n==\n");
      } else {
        break;
      }
    }
  }

  return 0;
}
