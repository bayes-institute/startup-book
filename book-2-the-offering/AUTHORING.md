# Authoring and print design

This guide travels with the book.

## Developing five independent books

### The editorial contract

The new books are foundations for writing, not automatic exports of the old
reference manual. All 36 chapter intentions and their planned section labels
have been retained. The source repository retains its archive in `reference/`, Markdown in
`content/`, and curated PDFs unchanged. Those optional collections are not
needed to build an exported book folder.

Each current chapter is explicitly marked **Chapter in development** and shows
its existing argument plan. That is a planning proof, not finished narrative.
There is no placeholder prose added to inflate the page count.

To draft a chapter, replace its `ChapterPlan` environment with developed prose
and real `\section` headings. Keep its `\chapter`, source label, and useful section
labels. `chapter-template.tex` shows the production structure. Do not rerun
any migration against a chapter after writing into it.

### Five decisions, five books

| Book | Independent question | Source chapter IDs | Local chapters |
| --- | --- | --- | --- |
| The Opportunity | Which business is worth pursuing? | 01-09 | 1-9 |
| The Offering | How do we reliably deliver the promised result? | 10-14 | 1-5 |
| The Engine | How does value become cash, survival, and repeatable growth? | 15-22 | 1-8 |
| The Advantage | How do people, systems, and strategic choices create lasting advantage? | 23-31 | 1-9 |
| The Institution | How does the enterprise allocate capital and endure beyond its founder? | 32-36 | 1-5 |

File names retain the old source IDs so material can be traced into the archive.
Printed chapter numbers restart at 1 in every book. For example, source chapter
10 is Book Two, Chapter 1. Its source label remains `ch:source-10`; section labels
such as `sec:ch10-change-of-state` remain stable. Do not print the source ID as if
it were the reader's local chapter number.

Within a volume use `\ref` for numbered chapters, figures, tables, and equations;
use `\nameref{sec:...}` for the unnumbered section headings. Between books, name the book and local
chapter explicitly, for example `\BookReference{The Offering}{1}`. Never rely on
another book's `.aux` file just to compile an independent volume.

### Replace the topic catalogue with an argument

Start from a situation a reader can recognize. Establish the consequential
question, then develop the explanation in connected paragraphs. Show why the
mechanism works, what evidence supports it, a worked example, and the conditions
under which it fails. Apply it to a real choice and close with the decision the
reader is now able to make. These are editorial moves, not mandatory headings.

Do not repeat the same nine-section anatomy in every chapter. A heading should
mark a turn in the reasoning, not a noun followed by a list of associated topics.
Use bullets for a genuine checklist, alternatives, or steps; keep explanations,
causal chains, interpretation, and transitions in prose. A useful table or diagram
can clarify a relationship, but cannot substitute for the explanation around it.

For independence, introduce the minimum concepts this book needs. Reintroduce the
Bayes Institute situation at the point where it matters, instead of assuming the
reader remembers a previous volume. Distinguish case facts, hypotheses, illustrative
numbers, evidence, and the author's judgment. Add actual source notes with
`\NotesSection`; do not invent citations to make a draft appear complete.

### Length planning

Around 500 pages per volume and 2,500 for the series is an editorial target, not a
geometry setting. With this type size and trim, the amount of prose, figures,
worked cases, notes, and appendices will determine the actual length.

Reserve roughly 20-30 pages per book for front matter and back matter. A rough
470-page main-text budget works out to about 52 pages per chapter in Books One
and Four, 59 in Book Three, and 94 in Books Two and Five. This unequal workload is
visible now: the narrower five-chapter books need more developed cases and
explanation if they are to reach the same length. Split an oversized chapter into
several narrative chapters when the argument warrants it; do not pad it or add
lists merely to meet the target.

The existing combined content PDF in this checkout has 1,636 pages. Its page
count is not comparable to the new edition until the typography, chapter scope,
and narrative rewrite are settled. There is no automatic claim that conversion
alone produces five 500-page books.

### Chapter workflow

1. Read the relevant archive files and map distinct claims, examples, and limits.
2. Write the chapter's central question and its argument in a short paragraph.
3. Replace the plan with prose. Preserve substance before compressing repetition.
4. Reuse section labels and add evidence, meaningful visuals, and source notes.
5. Build just that local chapter and inspect its PDF at actual print size.
6. Build its full volume to check transitions, numbering, contents, and blank versos.

```powershell
## Book Two, local Chapter 1 (source chapter 10).
powershell -NoProfile -ExecutionPolicy Bypass -File build.ps1 -Target Interior -Chapter 1

## Then check it in the complete volume.
powershell -NoProfile -ExecutionPolicy Bypass -File build.ps1 -Target Interior
```

Changes to `bayesinstitute.sty` affect only this book. Keep chapter-specific
layout overrides out of the manuscripts unless they serve a real reader need.

### A lesson and three founders

Teach the idea in connected, accessible prose before asking the reader to apply
it. A familiar situation, a surprising result, and a worked explanation are
better starting points than a list of learning objectives. Explain mathematical
quantities before introducing the equation; interpret the result afterwards.

End each chapter with three fictional teaching cases: technology, fashion, and
education. Founders may recur, but introduce enough context for a reader entering
this volume independently. Show a decision, let the reader pause, reason through
a defensible move, and explain which changed condition would change the answer.
Avoid giving every founder the same advice in different vocabulary. Distinguish
fiction and synthetic data from evidence; real company cases need sources.

Use `CaseStudies`, `CaseStudy`, `CaseSection`, and `CasePrompt` from the template.
A long case can span multiple pages. Use asides where a reader benefits from a
pause. Caption meaningful figures and tables, put a `label` after the caption,
and refer to them in the prose. State units, population, period, and provenance
beside data graphics. The local preface is a working introduction; each volume
should receive its own author-approved preface when the manuscript matures.

Use the [editorial elements](#editorial-elements-for-a-reading-book) where they help the reader:
an opening brief for orientation, a numbered worked example for reasoning, an
evidence note for interpretation, a short checklist for a decision, and a closing
review for transfer. A lesson need not use every element. Keep the prose complete
without them and avoid turning each section into a stack of panels. Develop the
subject index and glossary from the finished manuscript's vocabulary.


## Print design specification

The supplied `assets/BAYES_INSTITUTE_BOOK_DESIGN_NOTES.md` supplies the brand
identity. The user's requirement for a black-and-white interior overrides its
web-specific grey surfaces, pale dividers, coloured headings, and lightweight UI
details. The reference archive is source material, not the new visual template.

### Interior

| Element | Specification |
| --- | --- |
| Trim | 7 x 10 inches, portrait, single column, no interior bleed |
| Mirrored margins | Inside 0.875 in; outside 0.70 in; top/bottom 0.65 in including navigation |
| Body | EB Garamond Regular, 11.5 pt / 14.6 pt, justified without word hyphenation |
| Emphasis | Upright EB Garamond SemiBold; nested emphasis returns to regular |
| Chapter titles | EB Garamond Regular, 34 pt / 36 pt; small Inter lesson label |
| Section titles | EB Garamond SemiBold, 17 pt / 20 pt; unnumbered, 4 pt below |
| Subheads | Inter SemiBold, 10 pt nominal / 14 pt |
| Running heads | Black Inter, 8.5 pt nominal; series/volume on verso, lesson on recto |
| Folios | Black Inter SemiBold, 9 pt nominal, outer footer |
| Contents | Preface, reading guide, chapters; avoid a syllabus of small numbered sections |
| Tables | Black rules, white cells, descriptive captions; no pale row shading |
| Diagrams | Black lines, white fills, direct labels, dashed lines or patterns |
| Asides | White, breakable, one black vertical rule; labels carry meaning |
| Logo | Exact-path monochrome derivative, kept as vectors |
| PDF | Embedded font subsets; interiors normalized to DeviceGray |

Text and vector artwork use solid black or white. Anti-aliasing in screen
previews will naturally show grey pixels at edges; there are no intentional grey
text styles, background tints, or coloured navigation links in the source design.
Regular and semibold static font instances are bundled. Inter is scaled to 88%
to sit quietly beside the serif. Fake bold, fake italics,
thin display weights, and dependence on system-installed fonts are avoided.
EB Garamond italic is not used. Chapter leads use its upright regular face;
ordinary emphasis uses upright semibold. Legacy italic commands also resolve to
upright semibold so imported material does not reintroduce slanted passages.

The wider measure gives a data-heavy book more room for diagrams and tables.
Compact leading, zero paragraph indents, and a 3 pt paragraph gap support sustained
reading. Every paragraph starts on the same left edge. Body and aside paragraphs
are justified by adjusting word spaces; automatic word splitting and line breaks
at existing hyphens are disabled. The final line of a paragraph remains naturally
short. Headings and captions retain their own alignment. Paragraph separation is
about one fifth of a line, rather than a full blank line. A 400-500-page book is a sensible editorial
target at this trim, not a guaranteed thickness or page count. Paper thickness
determines the final spine. This is a format choice, not a print-cost estimate.

The inside margin leaves room for binding a substantial volume. The format is
compatible with standard black-and-white paperback production; final production
must use the chosen printer's specifications. See [KDP's trim and margin guidance](https://kdp.amazon.com/en_US/help/topic/GVBQ3CMEQW3W2VL6/).

Chapters open on recto pages; intervening blank versos carry no furniture.
Headings reserve room for the text that follows. A 0.4 pt running-head rule sits
close to navigation. Opening pages have only an outer folio. There is no bar
under every section, no low-contrast running text, and no repeated card system.

### Colour covers

Five front-cover concepts share an open, asymmetric warm-white field.
**Building What Lasts** is the dominant title on two equal-sized lines;
it uses EB Garamond at 64 pt with 62 pt leading and slightly tighter letter
spacing. The 32 pt volume title and 18 pt upright EB Garamond SemiBold subtitle
form the second level below. The subtitle uses 24 pt leading, a 4.45 in measure,
a consistent left edge, and two deliberate phrase lines. The subtitle uses
solid black and a genuine semibold face for clearer print reproduction, with
greater separation from the volume title. It
has no quotation marks or terminal full stop. A short, fine 0.55 pt burgundy
rule separates the title levels. Inter is reserved for the small bookmark label
on the cover. An oversize, low-opacity B emblem sits
behind the open right side, cropped at the edge.
A top-right burgundy bookmark tab carries BOOK and the volume number, without
an out-of-five label. The cover's tab is shorter than the previous treatment.
A solid 1.52 in burgundy panel anchors the bottom. The author's name appears
at the left in 24 pt upright EB Garamond SemiBold, reversed out of the panel;
the small reversed publisher lockup sits at the right. There is no By prefix.
The stronger title, controlled spacing, and repeated burgundy shapes establish
the cover's hierarchy at full size and thumbnail size.
The original SVG paths and proportions are retained. The watermark tint is
confined to these colour PDFs, never embedded in the interior manuscript.
The publisher lockup comes from `assets/knowledge_logo.svg` and reads Bayes
Knowledge. An exact-path white derivative is used on the burgundy cover panel;
an exact-path black derivative is used on interior title pages. The original
primary artwork is retained. The separate B emblem supplies the watermark.
All cover artwork remains vector; there are no simulated foil, embossing, or
paper-texture effects baked into the file.

These are 7 x 10 trim-size **front-cover concepts**, not print-submission wraps.
The final back cover, barcode area, spine, bleed, and colour profile depend on
the final page count, paper stock, binding, and printer. A 500-page assumption is
not a production spine measurement. See [KDP's cover requirements](https://kdp.amazon.com/en_US/help/topic/G201953020).

### Front matter and teaching elements

Each volume has a title page matching the cover hierarchy, copyright verso,
working preface, reading guide with its scope and central question, five-volume
overview, and contents. Roman front-matter and Arabic lesson folios are separate.
The preface identifies this as a development edition; replace it with the
author's finished preface before publication.

The title page repeats the bookmark in black, then places the author beneath
the two-line subtitle, set in Inter Regular at 13.5 pt nominal with 19 pt leading.
The author's supplied MSc Statistics qualification,
specialization in Computational Finance, and University of Edinburgh credit
appear directly below the name, in smaller Inter type. The cover carries only
the author's name. `BookAuthorQualification` and `BookAuthorUniversity` control
the interior credit; `BookSubtitle` is plain text and the existing `BookTagline`
macro carries the same subtitle with its intentional two-line display setting.

### Subtitle language

Each subtitle makes one concrete reader promise using a continuous How to
phrase. The sequence moves from choosing an opportunity to designing an offering,
earning cash, developing capabilities, and building institutional continuity.
The subtitle should explain the volume's scope and usefulness rather than add
a second pair of motivational slogans.

| Volume | Subtitle |
| --- | --- |
| The Opportunity | How to Find a Market Worth Serving and a Business Worth Building |
| The Offering | How to Design Products and Services That Deliver on Their Promise |
| The Engine | How to Turn Customer Value into Profit, Cash Flow, and Growth |
| The Advantage | How to Build Capabilities That Competitors Struggle to Match |
| The Institution | How to Build an Enterprise That Outlasts Its Founder |

These are original subtitles. Editorial references included HBR Press titles
such as [Playing to Win](https://store.hbr.org/product/playing-to-win-expanded-with-bonus-hbr-articles-how-strategy-really-works/10852),
[Blue Ocean Strategy](https://store.hbr.org/product/blue-ocean-strategy-expanded-edition-how-to-create-uncontested-market-space-and-make-the-competition-irrelevant/13892),
and [Dual Transformation](https://store.hbr.org/product/dual-transformation-how-to-reposition-today-s-business-while-creating-the-future/10091).
The adopted principle is a clear explanation of the practical promise, not a
copy of those books' wording or cover designs. Use title case, no terminal
punctuation, and line breaks at phrase boundaries. Do not strand an article or
preposition at the end of a display line.

`NoteBox`, `TipBox`, `InsightBox`, `ExampleBox`, `WarningBox`, and `DefinitionBox`
use a white field, black side rule, and semantic title. `KeyIdea` and
`LessonTakeaway` set a short claim in larger upright serif type. Use these
sparingly; connected prose carries the argument.

Five additional teaching elements have distinct roles: `LessonBrief`, numbered
`WorkedExample`, `EvidenceNote`, `DecisionChecklist`, and `LessonReview` with
`TransferQuestion`. They are demonstrated within the reading specimen. Short
briefs, examples, and checklists stay together; the review is unboxed. The
[editorial element guide](#editorial-elements-for-a-reading-book) documents placement, code, limits,
and publication references. Keep these optional and avoid repeated summaries.

Figures and tables use standard numbered `caption` and `label` commands.
`FigureSource` adds provenance below the caption. TikZ and PGFPlots are loaded
centrally; `BIchart` supplies a monochrome chart baseline. The specimen shows
bar, pie, radar, waterfall, and process graphics that can be reused.

Give data graphics units, denominators, scales, and sources. Bars start at zero.
Use patterns, open/filled points, line styles, and direct labels. Radar ratings
need defined criteria and a common scale; polygon area is not an overall score.
Distinguish waterfall changes from totals. Identify synthetic data beside each
chart. Captions should explain the inference and its limits.

At the end of a lesson, `CaseStudies` sets the shared application question.
`CaseStudy` begins a fresh page with a strong top rule, APPLY THE LESSON label,
sector, title, and founder metadata. `CaseSection` supplies compact subheads;
`CasePrompt` marks the reader's decision. Cases start on the next available
page without forced blank versos. Aim for roughly 250-300 words for a short
one-page case; longer cases flow normally. Never shrink the type to force a fit.

The specimen follows technology, fashion, and education founders, then compares
their choices in a captioned table. Fictional teaching cases must be identified;
real company histories need actual sources.

### Review and validation

`design-proof.tex` contains prose excerpts from the existing manuscripts,
front matter, captioned tables, mathematics, asides, a process diagram, four
chart types, and three founder cases. Its datasets and founders are explicitly
illustrative. It is the place to judge sustained reading before expanding the books.

Build with `-Target Proof`, then print the proof at **actual size / 100%**, not fit-to-page. Inspect the gutter,
smallest captions, upright emphasis, diagram labels, and line weights on the stock
you intend to use. A screen proof cannot establish how a particular press and
paper combination will reproduce the fonts.

The build checks trim size, embedded fonts, missing glyphs, references, text
bounds, visible colour, vector tints, and LaTeX overflow/font-substitution warnings.
This is a development preflight, not PDF/X certification or printer approval.


## Editorial elements for a reading book

Use these to give the reader a specific kind of help. Connected prose remains
the main form. A short lesson may need only a worked example and a closing
question; a long, data-heavy lesson may benefit from all five elements.
Do not insert one after every section or repeat the same claim in several boxes.

### The five elements

| Element | Reader's need | Best location | Editorial limit |
| --- | --- | --- | --- |
| LessonBrief | Understand the question, mechanism, and decision | After the opening lead or concrete hook | Three short entries; at most once per lesson |
| WorkedExample | Follow reasoning from inputs to interpretation | Beside the mechanism or equation it demonstrates | Show assumptions, units, work, and meaning; do not just display an answer |
| EvidenceNote | Tell a result from an inference or illustration | Beside a consequential empirical claim or chart | Identify provenance, population, period, and limits; never invent a study |
| DecisionChecklist | Check readiness for a particular commitment | Near the decision or before the founder cases | Three to five verifiable conditions; no decorative lists of virtues |
| LessonReview | Retain the transferable lessons and apply them | After the founder cases, before notes | About three complete statements and one transfer question |

### Lesson brief

```latex
\begin{LessonBrief}
\BriefPoint{The question}{What decision is difficult here?}
\BriefPoint{The insight}{What mechanism changes how we understand it?}
\BriefPoint{The decision}{What can the reader now choose or test?}
\end{LessonBrief}
```

This is a concise route through an argument, not a syllabus or a substitute for
the chapter lead. Its short entries align left for scanning. The narrative body
continues to use justified text without hyphenation.

### Numbered worked example

```latex
\begin{WorkedExample}{From inputs to a decision}
\label{ex:unique-name}
\WorkedStep{1}{Set the boundary.}{Define inputs, units, and assumptions.}
\WorkedStep{2}{Calculate or reason.}{Show the intermediate work.}
\WorkedStep{3}{Interpret.}{State what follows and what does not.}
\end{WorkedExample}

Worked Example~\ref{ex:unique-name} shows ...
```

Numbers restart with each chapter, for example 2.1. Equations inside retain their
own normal numbering. Short examples stay together. For a genuinely long example,
use `\begin{WorkedExample}[breakable]{Title}` and inspect its page transitions.
Do not make an example tiny to fit a page. Examples may demonstrate qualitative
reasoning as well as arithmetic.

### Evidence note

```latex
\begin{EvidenceNote}{A descriptive study or dataset name}
\EvidenceLine{Source}{Actual citation, population, sample size, and period.}
\EvidenceLine{Finding}{The result, including units and relevant uncertainty.}
\EvidenceLine{Limit}{What this design cannot establish or generalise to.}
\end{EvidenceNote}
```

For hypothetical data, replace the source/finding with a Status entry explicitly
identifying the example as invented. The reading specimen uses fictional learners
and says that no study was conducted. Do not attach a research-looking badge to
an illustration, assign an unsupported evidence score, or imply causation from
a descriptive comparison. This note complements the source citation; it does
not replace the chapter's notes and references.

### Decision checklist

```latex
\begin{DecisionChecklist}{Is this promise ready to scale?}
\item Define the customer's result in an observable form.
\item Identify a failure that could prevent it.
\item Specify the evidence that would make you pause expansion.
\end{DecisionChecklist}
```

The squares indicate items a reader can actually check. The list is an aid to
reasoning, not a validated scoring instrument or a guarantee of success.
Keep it short enough to stay together on a page.

### Closing review and transfer question

```latex
\begin{LessonReview}
\item One mechanism the reader should retain.
\item A boundary or condition under which the answer changes.
\item The decision now possible.
\end{LessonReview}
\TransferQuestion{Which assumption in your business would change this answer?}
```

Use the review after the cases to extract lessons from their differences.
`LessonTakeaway` remains available for one central claim. Avoid making it,
the opening brief, and the review three copies of the same wording.

### Print treatment

All elements use solid black rules on white, upright type, and the existing
serif/sans hierarchy. There are no pale fills, decorative icons, or dependence
on colour. Panels use modest spacing; the closing review has no enclosing box.
The brief and checklist stay together. Other long material can flow. The strong
case-page treatment remains separate from these smaller teaching elements.

The elements are available to this volume through its local style. They are
demonstrated in `design-proof.tex`; unfinished chapter plans are not
automatically padded with invented summaries or research claims.

### Publication references

The reference points are editorial functions, not copied page designs or text:

- [HBR's practical toolkit example](https://store.hbr.org/product/hbr-guide-to-dealing-with-conflict-toolkit/10170)
  illustrates checklists, practical steps, and scripts accompanying explanation.
- [Springer Nature's manuscript guidance](https://www.springernature.com/gp/authors/publish-a-book/manuscript-guidelines)
  recommends consistent teaching elements.
- [Cambridge's Research Methods and Applied Statistics contents](https://assets.cambridge.org/97810093/61439/frontmatter/9781009361439_frontmatter.pdf)
  provides a further reference for cases, key terms, and chapter-end material.

A subject index, a curated glossary, and selective further reading will add value
once the chapters are written. Build those from the finished vocabulary and actual
sources rather than publishing an empty index or a generic reading list now.
