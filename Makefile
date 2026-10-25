SHELL := /bin/bash

BOOK := startups-and-business-handbook
OUT_DIR := build
LATEXMK := latexmk
LATEX_FLAGS := -xelatex -interaction=nonstopmode -halt-on-error -file-line-error

.PHONY: pdf book chapter ch ch1 ch2 ch3 ch4 ch5 ch6 ch7 ch8 ch9 ch10 ch11 ch12 ch13 ch14 ch15 ch16 ch17 ch18 ch19 ch20 ch21 ch22 ch23 ch24 ch25 ch26 ch27 ch28 ch29 ch30 ch31 chapters lock lock1 lock2 lock3 lock4 lock5 lock6 lock7 lock8 lock9 lock10 lock11 lock12 lock13 lock14 lock15 lock16 lock17 lock18 lock19 lock20 lock21 lock22 lock23 lock24 lock25 lock26 lock27 lock28 lock29 lock30 lock31 unlock status watch clean clean-chapters help

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
	@RAW="$(or $(CH),$(CHAPTER),31)"; \
	NUM=$$((10#$$RAW)); \
	PAD=$$(printf "%02d" $$NUM); \
	mkdir -p $(OUT_DIR)/chapters; \
	echo "==> Compiling Chapter $$NUM standalone into $(OUT_DIR)/chapters/chapter-$$PAD.pdf..."; \
	$(LATEXMK) $(LATEX_FLAGS) -outdir=$(OUT_DIR)/chapters -jobname=chapter-$$PAD -usepretex="\def\SingleChapter{$$NUM}" $(BOOK).tex && \
	echo "==> [SUCCESS] Chapter $$NUM standalone compiled: $(OUT_DIR)/chapters/chapter-$$PAD.pdf"

# Short alias for chapter
ch:
	@$(MAKE) chapter CH=$(or $(CH),$(CHAPTER),31)

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
ch16:
	@$(MAKE) chapter CH=16
ch17:
	@$(MAKE) chapter CH=17
ch18:
	@$(MAKE) chapter CH=18
ch19:
	@$(MAKE) chapter CH=19
ch20:
	@$(MAKE) chapter CH=20
ch21:
	@$(MAKE) chapter CH=21
ch22:
	@$(MAKE) chapter CH=22
ch23:
	@$(MAKE) chapter CH=23
ch24:
	@$(MAKE) chapter CH=24
ch25:
	@$(MAKE) chapter CH=25
ch26:
	@$(MAKE) chapter CH=26
ch27:
	@$(MAKE) chapter CH=27
ch28:
	@$(MAKE) chapter CH=28
ch29:
	@$(MAKE) chapter CH=29
ch30:
	@$(MAKE) chapter CH=30
ch31:
	@$(MAKE) chapter CH=31

# Lock an individual chapter after verification
# Usage: `make lock CH=5`
lock:
	@RAW="$(or $(CH),$(CHAPTER),31)"; \
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
lock16:
	@$(MAKE) lock CH=16
lock17:
	@$(MAKE) lock CH=17
lock18:
	@$(MAKE) lock CH=18
lock19:
	@$(MAKE) lock CH=19
lock20:
	@$(MAKE) lock CH=20
lock21:
	@$(MAKE) lock CH=21
lock22:
	@$(MAKE) lock CH=22
lock23:
	@$(MAKE) lock CH=23
lock24:
	@$(MAKE) lock CH=24
lock25:
	@$(MAKE) lock CH=25
lock26:
	@$(MAKE) lock CH=26
lock27:
	@$(MAKE) lock CH=27
lock28:
	@$(MAKE) lock CH=28
lock29:
	@$(MAKE) lock CH=29
lock30:
	@$(MAKE) lock CH=30
lock31:
	@$(MAKE) lock CH=31

# Unlock a chapter for further editing
# Usage: `make unlock CH=5`
unlock:
	@RAW="$(or $(CH),$(CHAPTER),31)"; \
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
	for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31; do \
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
	@for c in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31; do \
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
