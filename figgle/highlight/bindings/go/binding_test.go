package tree_sitter_highlight_test

import (
	"testing"

	tree_sitter "github.com/tree-sitter/go-tree-sitter"
	tree_sitter_highlight "github.com/tree-sitter/tree-sitter-highlight/bindings/go"
)

func TestCanLoadGrammar(t *testing.T) {
	language := tree_sitter.NewLanguage(tree_sitter_highlight.Language())
	if language == nil {
		t.Errorf("Error loading Highlight grammar")
	}
}
