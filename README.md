# Building What Lasts

Five independent book projects by **Sagar Udasi**. Each book folder can be copied
or zipped on its own: its manuscript, chapters, style, fonts, logos, templates,
examples, build instructions, and Windows build support are all local.

| Book | Project | Interior PDF |
| --- | --- | --- |
| 1. The Opportunity | [Folder](book-1-the-opportunity/) | [PDF](book-1-the-opportunity/build/the-opportunity.pdf) |
| 2. The Offering | [Folder](book-2-the-offering/) | [PDF](book-2-the-offering/build/the-offering.pdf) |
| 3. The Engine | [Folder](book-3-the-engine/) | [PDF](book-3-the-engine/build/the-engine.pdf) |
| 4. The Advantage | [Folder](book-4-the-advantage/) | [PDF](book-4-the-advantage/build/the-advantage.pdf) |
| 5. The Institution | [Folder](book-5-the-institution/) | [PDF](book-5-the-institution/build/the-institution.pdf) |

Each folder's README contains its complete build and writing instructions.
Finished interiors and front-cover PDFs are written into each book's `build/`
folder. There is no root build directory or shared runtime dependency.

## Build on Windows

Use Python 3.10+ on PATH and Windows PowerShell. The portable Tectonic compiler
is bundled locally in each book. Source-only exports that omit binaries can
bootstrap the pinned compiler automatically. The first uncached build needs
internet for TeX packages and the pinned Python PDF dependency.

Build all five interiors and covers from this repository:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File build.ps1
```

Build one book or one local chapter:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File build.ps1 -Book 2
powershell -NoProfile -ExecutionPolicy Bypass -File build.ps1 -Book 2 -Target Interior -Chapter 1
```

Build an exported book from inside its own folder:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File build.ps1
```

The optional `-Target Proof` renders that book's bundled teaching/design specimen.
The root build script only dispatches to the independent book scripts; exported
books never call back into this repository. Intermediates, Python dependencies,
font caches, and print-check reports live in each book's hidden `.cache/` folder.
Generated manuscript PDFs and downloaded binaries remain ignored by Git.
Vector logo PDFs, fonts, licenses, and source files are retained.

## Fonts and design

The books bundle only **EB Garamond** and **Inter**, in upright Regular and
SemiBold faces. EB Garamond supplies reading text, titles, and cover subtitles;
Inter supplies navigation, captions, and functional labels. Standard mathematical
symbols come from LaTeX's math packages. No Manrope is used or bundled in a book.

Each book has an independent `bayesinstitute.sty`, `chapter-template.tex`,
`design-proof.tex`, and `AUTHORING.md`. A style change affects only that book.
The chapter files retain their existing labelled writing plans for development
chapter by chapter. Covers remain front-cover concepts, pending final wraps.

## Retained source collections

- `reference/` and `content/` preserve the original reference material unchanged.
- `assets/` retains the supplied master SVG artwork and brand notes.
- `fonts/` retains the two font families and their licenses as source assets.
- `tools/` preserves the original Windows compiler and PDF inspection tools.

The master collections are conveniences for this repository; each book includes
all copies it needs. The former root `shared/`, `scripts/`, and `docs/` folders
have been replaced by the independent book projects.
