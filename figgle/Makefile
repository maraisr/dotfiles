SRC = $(wildcard src/*.c)

build: figgle

clean:
	@rm -f figgle
.PHONY: clean

run: figgle
	@./figgle
.PHONY: run

figgle: $(SRC)
	cc -Wall -Wextra -std=c11 \
		-o $@ $^
	@echo "============================================"
	@echo "            Build successful!               "
	@echo "============================================\n"
