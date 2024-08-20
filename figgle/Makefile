SRC = $(wildcard src/*.c)

build: figgle

clean:
	@rm -f figgle
.PHONY: clean

run: figgle
	@./figgle
.PHONY: run

figgle: $(SRC)
	gcc -o $@ $^
	@echo "============================================"
	@echo "            Build successful!               "
	@echo "============================================\n"
