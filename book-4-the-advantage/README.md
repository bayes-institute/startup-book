# Building What Lasts: The Advantage

**Book 4 of five, by Sagar Udasi**

How to Build Capabilities That Competitors Struggle to Match

This folder is a complete, independently buildable book project. Copy or zip
the entire folder to work elsewhere. It includes its own style, fonts, logos,
chapter template, examples, build support, and Windows compiler. No parent
folder, root tools directory, or other volume is required.

## Build on Windows

Prerequisites: Windows PowerShell and Python 3.10 or newer on PATH. Bundled
fonts need no installation. Tectonic 0.17.0 is in `tools/tectonic/tectonic.exe`.
If a source-only export omits the binary, the build uses Tectonic on PATH or
downloads the pinned Windows x64 release into this book's own tools folder.
The first build needs internet for uncached TeX packages and PDF dependencies.

From this folder:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File build.ps1
```

The default build writes these files into this book's **`build/` folder**:

- `build/the-advantage.pdf`: black-and-white interior.
- `build/the-advantage-front-cover.pdf`: colour front-cover concept.

Useful targets:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File build.ps1 -Target Interior
powershell -NoProfile -ExecutionPolicy Bypass -File build.ps1 -Target Cover
powershell -NoProfile -ExecutionPolicy Bypass -File build.ps1 -Target Interior -Chapter 1
powershell -NoProfile -ExecutionPolicy Bypass -File build.ps1 -Target Proof
```

The chapter target uses local numbers 1-9 and writes
`build/the-advantage-chapter-01.pdf`. The optional Proof target builds the bundled
reading and teaching-element specimen as `build/design-proof.pdf`.

The build installs PyMuPDF from `requirements-build.txt` into `.cache/` if it
is missing, prepares the local SVG logos, compiles, normalizes the interior to
DeviceGray, and runs print checks. It only replaces the final PDFs after checks
pass. Intermediates, font/Python caches, logs, and `print-checks.json` stay in
`.cache/`. Removing that cache does not remove the finished PDFs or sources;
the next build recreates it. The tools and final PDFs are ignored by Git;
the SVGs, vector logo PDFs, text fonts, and source files are retained.

## Contents of the project

| File or folder | Purpose |
| --- | --- |
| `the-advantage.tex` | Manuscript entry point and local chapter order |
| `book-info.tex` | Title, approved subtitle, scope, and opening question |
| `cover.tex` | Colour front-cover entry point |
| `bayesinstitute.sty` | This book's independent layout and teaching elements |
| `chapters/` | The chapter sources |
| `fonts/` | EB Garamond and Inter Regular/SemiBold, with licenses |
| `assets/` | Source logos and vector PDF derivatives |
| `chapter-template.tex` | Starting structure for a narrative lesson and founder cases |
| `design-proof.tex` | Optional specimen with prose, charts, equations, and teaching elements |
| `AUTHORING.md` | Writing, print-design, and editorial-element guidance |
| `tools/` | Local compiler and PDF preparation/preflight helper |
| `build.ps1` | Standalone build entry point |
| `build/` | Finished PDFs for this book |

## Write a chapter

The chapters currently contain explicitly labelled writing plans. Replace a
`ChapterPlan` with developed prose while keeping existing chapter/section labels.
Use `chapter-template.tex` and [the authoring guide](AUTHORING.md). Printed lesson
numbers restart at 1 in this volume; filenames retain their original series IDs.

| Local chapter | Source file |
| --- | --- |
| 1 | `chapters/ch23-hiring-talent-selection.tex` |
| 2 | `chapters/ch24-specialized-hiring.tex` |
| 3 | `chapters/ch25-operational-excellence.tex` |
| 4 | `chapters/ch26-organizational-design-culture.tex` |
| 5 | `chapters/ch27-theory-of-scaling.tex` |
| 6 | `chapters/ch28-competitive-advantage-moats.tex` |
| 7 | `chapters/ch29-strategic-adjacencies.tex` |
| 8 | `chapters/ch30-ecosystems-partnerships.tex` |
| 9 | `chapters/ch31-international-expansion.tex` |

Readability settings: 7 x 10 in trim, upright EB Garamond reading text, Inter
navigation/captions, justified paragraphs without hyphenation or indents, and
compact paragraph spacing. Cover subtitles use solid-black EB Garamond SemiBold.
No Manrope or italic text face is bundled. `bayesinstitute.sty` is a local copy:
editing it changes this book only.

Use `LessonBrief`, `WorkedExample`, `EvidenceNote`, `DecisionChecklist`, and
`LessonReview` selectively. End lessons with the three founder cases. The
specimen and template show captioned tables/figures, mathematics, process
diagrams, bar/pie/radar/waterfall charts, and the reusable environments.

Print at actual size / 100% to inspect the gutter and small labels. The cover
is a trim-size front concept; a final wrap needs the printer's template and
the final paper, binding, and page count.
