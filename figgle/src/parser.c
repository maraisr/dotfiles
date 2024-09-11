#include "parser.h"

#include "ast.h"
#include "common.h"
#include "lexer.h"
#include "stdio.h"
#include <stdbool.h>
#include <stdio.h>
#include <string.h>

typedef struct {
  Lexer *lexer;
  Token current;
} Parser;

#define DEBUG_CURRENT(p)                                                       \
  printf("Current: %d '%.*s'\n", p->current.kind, (int)p->current.text_len,    \
         p->current.text)

void advance(Parser *p) { p->current = lexer_next_token(p->lexer); }
bool check(Parser *p, TokenKind kind) { return p->current.kind == kind; }

bool advance_if(Parser *p, TokenKind kind) {
  advance(p);
  if (!check(p, kind))
    return false;
  return true;
}

bool advance_if_value(Parser *p, TokenKind kind, const char *value) {
  if (!advance_if(p, kind))
    return false;
  if (strncmp(p->current.text, value, p->current.text_len) != 0)
    return false;
  return true;
}

Node *make_node(ASTKind kind) {
  Node *node = (Node *)malloc(sizeof(Node));
  node->kind = kind;
  return node;
}
Node *make_identifier_from_token(Token token) {
  Node *node = make_node(AST_IDENTIFIER);
  node->item.literal.value = (char *)malloc(token.text_len);
  strncpy(node->item.literal.value, token.text, token.text_len);
  node->item.literal.value[token.text_len] = '\0';
  return node;
}
Node *make_literal_from_token(Token token) {
  Node *node = make_node(AST_LITERAL);
  return node;
}

// ---

Node *declaration(Parser *p);
Node *statement(Parser *p);
Node *expression(Parser *p);

Node *declaration(Parser *p) {
  if (check(p, TOKEN_SYMBOL)) {
    Node *decl = make_node(AST_VARIABLE);

    decl->item.variable.left = make_identifier_from_token(p->current);
    if (!advance_if_value(p, TOKEN_SYMBOL, "="))
      exit(1);
    decl->item.variable.right = expression(p);
    return decl;
  };

  advance(p);
  return NULL;
}

Node *expression(Parser *p) {
  if (!advance_if(p, TOKEN_STRING))
    exit(1);
  Token token = p->current;
  Node *node = make_literal_from_token(token);
  node->item.literal.value = (char *)malloc(token.text_len);
  strncpy(node->item.literal.value, token.text, token.text_len);
  node->item.literal.value[token.text_len] = '\0';
  return node;
}

Node *statement(Parser *p) {
  advance(p);
  return NULL;
}

// ---

Node parse(const char *content) {
  Lexer l = lexer_new(content);
  Parser p = {.lexer = &l};
  Node *program = make_node(AST_PROGRAM);

  while (!advance_if(&p, TOKEN_END)) {
    Node *decl = declaration(&p);
    if (decl != NULL)
      da_append(&program->item.program.body, *decl);
  };

  return *program;
}

// ---

void print_node(Node *node, int indent) {
  printf("%*s", indent, "");
  switch (node->kind) {
  case AST_PROGRAM:
    for (int i = 0; i < node->item.program.body.count; i++) {
      print_node(&node->item.program.body.items[i], 0);
    }
    break;
  case AST_VARIABLE:
    printf("{Variable\n %*sleft:\n", indent, "");
    print_node(node->item.variable.left, indent + 2);
    printf("\n right:\n");
    print_node(node->item.variable.right, indent + 2);
    printf("}");
    break;
  case AST_IDENTIFIER:
    printf("[Ident:%s]", node->item.literal.value);
    break;
  case AST_LITERAL:
    printf("[Literal:'%s']", node->item.literal.value);
    break;
  default:
    printf("[Unknown:%d]", node->kind);
  }
}
