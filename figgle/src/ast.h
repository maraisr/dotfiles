#ifndef AST_H
#define AST_H

#include "common.h"
#include "lexer.h"
#include <stdio.h>

typedef enum {
  AST_PROGRAM = 0,
  // AST_BLOCK,
  // AST_STATEMENT,
  // AST_EXPRESSION,
  AST_IDENTIFIER,
  AST_VARIABLE,
  AST_LITERAL,
  // AST_OPERATOR,
  // AST_CALL,
  // AST_ASSIGN,
  // AST_DECLARATION,
  // AST_ERROR
} ASTKind;

typedef struct Node Node;
struct Node {
  ASTKind kind;
  // Token token;
  union {
    struct {
      DA(Node) body;
    } program;
    struct {
      Node *left;
      Node *right;
    } variable;
    struct {
      char *value;
    } literal;
  } item;
};

#endif // AST_H
