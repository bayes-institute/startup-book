SHELL := /bin/bash

BOOK := startups-and-business-handbook
OUT_DIR := build
LATEXMK := latexmk
LATEX_FLAGS := -xelatex -interaction=nonstopmode -halt-on-error -file-line-error

.PHONY: pdf book chapter ch ch1 ch2 ch3 ch4 ch5 ch6 ch7 ch8 ch9 ch10 ch11 ch12 ch13 ch14 ch15 chapters lock lock1 lock2 lock3 lock4 lock5 lock6 lock7 lock8 lock9 lock10 lock11 lock12 lock13 lock14 lock15 unlock status watch clean clean-chapters help

# Default target: compile the full book
pdf:
	@mkdir -p $(OUT_DIR)
	@echo "==> Building complete master book (all chapters)..."
	$(LATEXMK) $(LATEX_FLAGS) -outdir=$(OUT_DIR) $(BOOK).tex
	@echo "==> [SUCCESS] Full book compiled: $(OUT_DIR)/$(BOOK).pdf"

book: pdf

# Build an individual chapter standalone
# Usage: `make chapter CH=5` or `make chapter CHAPTER=05`
chapter:
	@RAW="$(or $(CH),$(CHAPTER),15)"; \
	NUM=$$((10#$$RAW)); \
	PAD=$$(printf "%02d" $$NUM); \
	mkdir -p $(OUT_DIR)/chapters; \
	echo "==> Compiling Chapter $$NUM standalone into $(OUT_DIR)/chapters/chapter-$$PAD.pdf..."; \
	$(LATEXMK) $(LATEX_FLAGS) -outdir=$(OUT_DIR)/chapters -jobname=chapter-$$PAD -usepretex="\def\SingleChapter{$$NUM}" $(BOOK).tex && \
	echo "==> [SUCCESS] Chapter $$NUM standalone compiled: $(OUT_DIR)/chapters/chapter-$$PAD.pdf"

# Short alias for chapter
ch:
	@$(MAKE) chapter CH=$(or $(CH),$(CHAPTER),15)

# Dedicated chapter shortcuts
ch1:
	@$(MAKE) chapter CH=1
ch2:
	@$(MAKE) chapter CH=2
ch3:
	@$(MAKE) chapter CH=3
ch4:
	@$(MAKE) chapter CH=4
ch5:
	@$(MAKE) chapter CH=5
ch6:
	@$(MAKE) chapter CH=6
ch7:
	@$(MAKE) chapter CH=7
ch8:
	@$(MAKE) chapter CH=8
ch9:
	@$(MAKE) chapter CH=9
ch10:
	@$(MAKE) chapter CH=10
ch11:
	@$(MAKE) chapter CH=11
ch12:
	@$(MAKE) chapter CH=12
ch13:
	@$(MAKE) chapter CH=13
ch14:
	@$(MAKE) chapter CH=14
ch15:
	@$(MAKE) chapter CH=15

# Lock an individual chapter after verification
# Usage: `make lock CH=5`
lock:
	@RAW="$(or $(CH),$(CHAPTER),15)"; \
	NUM=$$((10#$$RAW)); \
	PAD=$$(printf "%02d" $$NUM); \
	mkdir -p $(OUT_DIR)/chapters $(OUT_DIR)/locked; \
	echo "==> Compiling and verifying Chapter $$NUM before locking..."; \
	$(LATEXMK) $(LATEX_FLAGS) -outdir=$(OUT_DIR)/chapters -jobname=chapter-$$PAD -usepretex="\def\SingleChapter{$$NUM}" $(BOOK).tex || { echo "==> [ERROR] Chapter $$NUM compilation failed. Cannot lock."; exit 1; }; \
	cp $(OUT_DIR)/chapters/chapter-$$PAD.pdf $(OUT_DIR)/locked/chapter-$$PAD.pdf; \
	touch .chapter-locks; \
	grep -v "^$$NUM:" .chapter-locks > .chapter-locks.tmp 2>/dev/null || true; \
	echo "$$NUM:$$(date '+%Y-%m-%d %H:%M:%S')" >> .chapter-locks.tmp; \
	sort -n -t: -k1,1 .chapter-locks.tmp > .chapter-locks && rm -f .chapter-locks.tmp; \
	echo "==> [LOCKED] Chapter $$NUM verified and locked at $$(date '+%Y-%m-%d %H:%M:%S')."; \
	echo "==> Saved locked release: $(OUT_DIR)/locked/chapter-$$PAD.pdf"

lock1:
	@$(MAKE) lock CH=1
lock2:
	@$(MAKE) lock CH=2
lock3:
	@$(MAKE) lock CH=3
lock4:
	@$(MAKE) lock CH=4
lock5:
	@$(MAKE) lock CH=5
lock6:
	@$(MAKE) lock CH=6
lock7:
	@$(MAKE) lock CH=7
lock8:
	@$(MAKE) lock CH=8
lock9:
	@$(MAKE) lock CH=9
lock10:
	@$(MAKE) lock CH=10
lock11:
	@$(MAKE) lock CH=11
lock12:
	@$(MAKE) lock CH=12
lock13:
	@$(MAKE) lock CH=13
lock14:
	@$(MAKE) lock CH=14
lock15:
	@$(MAKE) lock CH=15

# Unlock a chapter for further editing
# Usage: `make unlock CH=5`
unlock:
	@RAW="$(or $(CH),$(CHAPTER),15)"; \
	NUM=$$((10#$$RAW)); \
	if [ -f .chapter-locks ]; then \
		grep -v "^$$NUM:" .chapter-locks > .chapter-locks.tmp 2>/dev/null || true; \
		mv .chapter-locks.tmp .chapter-locks; \
		echo "==> [UNLOCKED] Chapter $$NUM is now unlocked."; \
	else \
		echo "==> No locked chapters found."; \
	fi

# Display current lock and draft status of all active chapters
status:
	@echo "=========================================================================="; \
	echo " Bayesforce Publishing Engine :: Chapter Lock Status"; \
	echo "=========================================================================="; \
	for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15; do \
		PAD=$$(printf "%02d" $$i); \
		if [ -f .chapter-locks ] && grep -q "^$$i:" .chapter-locks; then \
			LOCK_TIME=$$(grep "^$$i:" .chapter-locks | cut -d: -f2-); \
			printf "  Chapter %2d [%s] : [LOCKED] at %s\n" $$i "$$PAD" "$$LOCK_TIME"; \
		else \
			printf "  Chapter %2d [%s] : [DRAFT / UNLOCKED]\n" $$i "$$PAD"; \
		fi \
		done; \
	echo "=========================================================================="

# Build all active individual chapters sequentially
chapters:
	@for c in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15; do \
		$(MAKE) chapter CH=$$c || exit 1; \
	done


# Continuous watch mode (works for full book or individual chapter)
# Usage: `make watch` or `make watch CH=4`
watch:
	@mkdir -p $(OUT_DIR)
	@if [ -n "$(CH)" ] || [ -n "$(CHAPTER)" ]; then \
		RAW="$(or $(CH),$(CHAPTER))"; \
		NUM=$$((10#$$RAW)); \
		PAD=$$(printf "%02d" $$NUM); \
		mkdir -p $(OUT_DIR)/chapters; \
		$(LATEXMK) $(LATEX_FLAGS) -pvc -outdir=$(OUT_DIR)/chapters -jobname=chapter-$$PAD -usepretex="\def\SingleChapter{$$NUM}" $(BOOK).tex; \
	else \
		$(LATEXMK) $(LATEX_FLAGS) -pvc -outdir=$(OUT_DIR) $(BOOK).tex; \
	fi

# Clean build artifacts
clean:
	$(LATEXMK) -C -outdir=$(OUT_DIR) $(BOOK).tex 2>/dev/null || true
	rm -rf $(OUT_DIR)

clean-chapters:
	rm -rf $(OUT_DIR)/chapters

help:
	@echo "Bayesforce Book Publishing Engine - Available Commands:"
	@echo "  make pdf / make book        Compile the entire master book (all chapters)"
	@echo "  make chapter CH=<n>         Compile Chapter <n> standalone (e.g. make chapter CH=4)"
	@echo "  make ch1 / ch2 / ch3 / ch4 / ch5  Quick shortcuts to compile individual chapters"
	@echo "  make chapters               Compile all active chapters standalone into build/chapters/"
	@echo "  make lock CH=<n>            Compile, verify, and lock Chapter <n>"
	@echo "  make unlock CH=<n>          Unlock Chapter <n> for further editing"
	@echo "  make status                 Display lock and draft status of all chapters"
	@echo "  make watch [CH=<n>]         Live recompile on change (chapter or full book)"
	@echo "  make clean                  Remove all build artifacts and caches"
