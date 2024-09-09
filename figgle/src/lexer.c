#include "lexer.h"

#include <ctype.h>
#include <stdio.h>
#include <string.h>

const char *keywords[] = {
    "setup", "provides", "command"
};
#define keywords_count (sizeof(keywords)/sizeof(keywords[0]))

void lexer_chop(Lexer *l, size_t len) {
	l->cursor += len;
}

void lexer_trim(Lexer *l) {
	while (l->cursor < l->content_len && isspace(l->content[l->cursor])) {
        lexer_chop(l, 1);
    }
}

Lexer lexer_new(const char *content) {
  Lexer l = {.content = content, .content_len = strlen(content)};
  return l;
}

Token lexer_next(Lexer *l) {
	lexer_trim(l);

	Token token = {
		.text = &l->content[l->cursor]
	};

	if (l->cursor >= l->content_len) return token;

	if (isalpha(l->content[l->cursor])) {
		token.kind = TOKEN_SYMBOL;
        while (l->cursor < l->content_len && isalpha(l->content[l->cursor])) {
            lexer_chop(l, 1);
            token.text_len += 1;
        }

        for (size_t i = 0; i < keywords_count; ++i) {
	        size_t keyword_len = strlen(keywords[i]);
	        if (keyword_len == token.text_len && memcmp(keywords[i], token.text, keyword_len) == 0) {
	            token.kind = TOKEN_KEYWORD;
	            break;
	        }
	    }

        return token;
	}

	lexer_chop(l, 1);
    token.kind = TOKEN_INVALID;
    token.text_len = 1;
	return token;
}
