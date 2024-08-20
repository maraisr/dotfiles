#include <stdio.h>
#include <stdlib.h>

FILE* open_file(char* path) {
	FILE* f = fopen(path, "r");
	if (f == NULL) {
		printf("Error opening file\n");
		exit(1);
	}

	return f;
}

int main() {
	FILE* f = open_file("../facet/brew/brew.figgle");

	char c;
	while ((c = fgetc(f)) != EOF) {
		printf("%c", c);
	}
}
