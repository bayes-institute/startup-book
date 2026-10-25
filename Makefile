SHELL := /bin/bash

BOOK := startups-and-business-handbook
OUT_DIR := build
LATEXMK := latexmk
LATEX_FLAGS := -xelatex -interaction=nonstopmode -halt-on-error -file-line-error -outdir=$(OUT_DIR)

.PHONY: pdf watch clean

pdf:
	@mkdir -p $(OUT_DIR)
	$(LATEXMK) $(LATEX_FLAGS) $(BOOK).tex

watch:
	@mkdir -p $(OUT_DIR)
	$(LATEXMK) $(LATEX_FLAGS) -pvc $(BOOK).tex

clean:
	$(LATEXMK) -C -outdir=$(OUT_DIR) $(BOOK).tex
	@rmdir $(OUT_DIR) 2>/dev/null || true
