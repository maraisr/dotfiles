src = $(wildcard src/*.c)

build: figgle

figgle: src/main.v
	./v/v -o $@ $^
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
