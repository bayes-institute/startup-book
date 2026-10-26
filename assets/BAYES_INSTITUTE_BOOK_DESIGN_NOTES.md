# Bayes Institute — Book Design Notes

Use this brief to design a book that feels like an extension of the **current Bayes Institute website** in `client/apps/web`. Treat the website as the source of truth for the brand. The older brochure is not the authority for this book.

The visual character is refined, editorial, calm, and contemporary: warm serif display type paired with clear sans serif text, a restrained burgundy accent, soft neutral surfaces, generous whitespace, and precise details. Aim for an academic institution that feels approachable and current.

## Brand character

- **Editorial and assured:** clear hierarchy, thoughtful pacing, confident but quiet design.
- **Warm and contemporary:** serif display typography softens the clean, modern sans serif system.
- **Readable and welcoming:** comfortable type sizes, open spacing, and neutral reading surfaces.
- **Purposeful:** use color, rules, cards, and imagery to clarify content rather than decorate it.

## Color palette

These values come from the current web app’s shared CSS tokens and page styles.

| Color | Hex | Role |
|---|---|---|
| **Burgundy** | `#5B0F1A` | Primary brand accent. Use for key headings or labels, chapter markers, selected rules, buttons/callouts, and occasional dark panels. |
| **Deep Burgundy** | `#430A13` | Darker burgundy for occasional deep backgrounds or transitions. |
| **White** | `#FFFFFF` | Main page and card surface; preserve as open reading space. |
| **Warm Light Gray** | `#F7F6F4` | Alternate section or page surface that adds a subtle change of pace. |
| **Ink** | `#211D1E` | Primary text color. |
| **Soft Ink** | `#696164` | Secondary text, captions, supporting information. Use with sufficient contrast. |
| **Rule / Border** | `#E9E4DF` | Subtle dividers, table lines, and card outlines. |
| **Warm White on Dark** | `#F7F2EE` | Soft white text for deep burgundy sections. |

### Color use

- Let white and warm light gray carry most reading pages. Burgundy is an accent and occasional feature color, not a background for every spread.
- Use deep burgundy sparingly for a chapter opener, a strong closing page, or a featured callout. Keep long passages on light backgrounds for comfortable reading.
- Use thin, light rules to organize information. Avoid heavy borders and strong box outlines.
- Keep body text in Ink; use Soft Ink for clearly secondary material. Check contrast when text is small.
- Do not introduce verdigris or the older brochure’s broader color system. Add other colors only when a chart requires distinct categories, and keep them muted and purposeful.

## Typography

### Current web typefaces

- **EB Garamond — display serif.** The website loads EB Garamond as its display face. Use it for the book title, chapter titles, section headings, pull quotes, and occasional prominent numerals. Use regular weight for the characteristic light editorial feel.
- **Manrope — primary sans serif.** The website loads Manrope as its body face. Use it for body copy, subheads, captions, labels, tables, page furniture, and other functional information. Use weight to distinguish hierarchy without making all text bold.

Do not substitute Newsreader or add decorative typefaces. The older brochure uses Newsreader, but it does not match the current website typography. The web app’s exact fonts are loaded in `client/apps/web/app/layout.tsx`.

### Type hierarchy for print

The website uses responsive web sizes, so its CSS values should not be copied literally into print. Establish a print hierarchy that preserves the same relationships:

1. **Book and chapter titles:** large EB Garamond, regular weight, with generous line spacing and restrained line lengths.
2. **Section headings:** EB Garamond, clearly smaller than chapter titles but visibly distinct from body copy.
3. **Subheads and labels:** Manrope, medium or semibold; small uppercase labels may use modest letter spacing.
4. **Body copy:** Manrope, regular weight, comfortable book-reading size and leading.
5. **Captions and folios:** Manrope, smaller than body copy but still legible in print; use Soft Ink.

Use fluid, responsive display proportions as inspiration rather than forcing web sizes into a fixed page. Keep text left aligned in most cases, keep line lengths comfortable, and avoid excessive letter spacing, all-caps paragraphs, or too many competing sizes.

## Logo and identity marks

- Use official assets from `client/apps/web/public/brand/`.
- The web brand guidance says to use the **full logo lockup whenever the institute name appears**. Use the B emblem by itself only in compact contexts such as a small running marker or imprint.
- Use `full-primary.svg` on light backgrounds and `full-inverse.svg` on dark backgrounds. Use black/monochrome variants only when the production is monochrome.
- Preserve the mark’s proportions, original colors, and clear space. Do not redraw, distort, or add effects.

## Page composition and rhythm

- Design a coherent sequence of spreads with a consistent grid, margins, folios, and running information.
- Favor open editorial pages with clear alignment and generous whitespace. Use burgundy panels and full-bleed moments selectively to create emphasis and chapter transitions.
- Use alternating white and warm light gray surfaces to distinguish sections without making every page a colored panel.
- Keep rules thin and pale. Use card-like modules selectively for summaries, data, comparisons, timelines, or practical information. The website uses restrained borders and lightly rounded corners; translate that quality into print with fine rules and simple rectangular panels.
- Establish a comfortable reading experience across the main text pages. Vary the rhythm with chapter openers, pull quotes, image-led pages, diagrams, and occasional feature spreads.
- Keep grids, tables, and information modules clean and spare. Give each module enough room to breathe.

## Photography and imagery

- Use imagery when it adds context, humanity, or evidence to the story. Avoid adding images just to fill white space.
- Favor authentic, candid scenes of learning, research, collaboration, teaching, making, or real-world work.
- Choose images that feel specific to Bayes Institute and the subject at hand. Avoid generic corporate stock-photo conventions and overly staged scenes.
- Use deliberate crops and consistent alignment. A full-bleed image can work as a chapter opener or feature spread; otherwise, use calm, well-proportioned image blocks.
- Keep image treatments natural and restrained. Do not apply heavy filters or overlays that fight the web palette.
- Use diagrams, charts, and line illustrations only when they help explain the content. Style them with Burgundy, Ink, Soft Ink, Warm Light Gray, and pale neutrals.

## Repeatable book elements

Create consistent treatments for:

- chapter titles and chapter numbers;
- running heads and page folios;
- section labels and subheads;
- pull quotes and attribution;
- captions and source notes;
- tables, timelines, and data callouts.

Use EB Garamond for the editorial voice and Manrope for functional details. Use Burgundy for the recurring accent, and keep all other page furniture quiet.

## Avoid

- The older brochure’s Newsreader and verdigris palette.
- Making every spread a full-bleed geometric color composition.
- Dense card grids, heavy borders, strong drop shadows, or excessive rounded UI-style boxes.
- Overusing burgundy or setting long body passages in reverse white-on-burgundy text.
- Generic stock imagery, decorative fonts, distorted logos, and arbitrary bright colors.
- Tiny captions, long line lengths, crowded pages, and low-contrast supporting text.

## Ready-to-use instruction for a book-design agent

> Design this book as a Bayes Institute publication, using the current website in `client/apps/web` as the source of truth and following the attached design notes. Use EB Garamond for display headings and Manrope for body copy, labels, captions, and functional text. Use the restrained web palette: Burgundy `#5B0F1A`, Deep Burgundy `#430A13`, White `#FFFFFF`, Warm Light Gray `#F7F6F4`, Ink `#211D1E`, Soft Ink `#696164`, and subtle rules `#E9E4DF`. Create a refined, readable editorial book with generous whitespace, consistent grids and page furniture, selective burgundy feature moments, and authentic imagery where it supports the content. Use official current web logo assets without alteration. Do not use the old brochure’s Newsreader or verdigris system, and do not make every page a full-bleed panel.

## Current web references

- `client/apps/web/app/layout.tsx` — EB Garamond display and Manrope body font loading.
- `client/apps/web/app/styles.css` — shared color tokens, typography usage, surfaces, components, and page styles.
- `client/apps/web/public/brand/README.md` — current logo lockup/emblem usage.
- `client/apps/web/public/brand/` — current primary and inverse logo assets.
