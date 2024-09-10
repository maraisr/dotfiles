src = $(wildcard src/*.c)

build: figgle

figgle: $(src)
	cc -Wall -Wextra -std=c11 -o $@ $^
	@echo "============================================"
	@echo "            Build successful!               "
	@echo "============================================\n"

# ---
clean:
	@rm -f figgle
	@rm -f src/*.o
.PHONY: clean

run: figgle
	@./figgle
.PHONY: run
