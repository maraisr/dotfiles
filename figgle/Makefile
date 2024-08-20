SRC = $(wildcard src/*.c)
OBJ = $(patsubst src/%.c,out/%.o,$(SRC))

build: figgle

run: figgle
	@./figgle
.PHONY: run

figgle: $(OBJ)
	gcc -o $@ $^

out/%.o: src/%.c | out
	gcc -c -o $@ $<

out:
	mkdir out
