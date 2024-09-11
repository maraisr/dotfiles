#ifndef PARSER_H
#define PARSER_H

#include "ast.h"

Node parse(const char *content);

void print_node(Node *node, int indent);

#endif // PARSER_H
