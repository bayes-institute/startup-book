"""Book-local vector assets and PDF preflight. No parent repository dependencies."""
import argparse
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / '.cache/python-packages'))
import pymupdf


def prepare():
    output = ROOT / 'assets'
    for kind, filename in (('knowledge', 'knowledge_logo.svg'), ('emblem', 'emblem-primary.svg')):
        original = (output / filename).read_text(encoding='utf-8')
        black = re.sub(r'#[0-9A-Fa-f]{6}\b', '#000000', original)
        variants = [(f'{kind}-primary', original), (f'{kind}-black', black)]
        if kind == 'knowledge':
            variants.append(('knowledge-white', re.sub(r'#[0-9A-Fa-f]{6}\b', '#FFFFFF', original)))
        for name, data in variants:
            with pymupdf.open(stream=data.encode(), filetype='svg') as svg:
                with pymupdf.open(stream=svg.convert_to_pdf(), filetype='pdf') as doc:
                    if name.endswith(('black', 'white')):
                        doc.recolor(components=1)
                    doc.save(output / (name + '.pdf'), garbage=4, deflate=True)
    print('Prepared local vector assets.')


def check(job):
    path = Path(job['path'])
    interior = job['kind'] == 'interior'
    if interior:
        with pymupdf.open(path) as doc:
            doc.recolor(components=1)
            normalized = path.with_suffix('.gray.pdf')
            doc.save(normalized, garbage=4, deflate=True)
        normalized.replace(path)
    errors = []
    fonts = set()
    with pymupdf.open(path) as doc:
        for i, page in enumerate(doc, 1):
            if abs(page.rect.width - 504) > .1 or abs(page.rect.height - 720) > .1:
                errors.append(f'Page {i}: trim size is not 7 x 10 inches')
            for entry in page.get_fonts(full=True):
                fonts.add(entry[3])
                if 'ebgaramond' in entry[3].lower() and 'italic' in entry[3].lower():
                    errors.append(f'Page {i}: EB Garamond italic was reintroduced')
                if not doc.extract_font(entry[0])[3]:
                    errors.append(f'Page {i}: font is not embedded: {entry[3]}')
            value = page.get_text()
            if '??' in value or '\ufffd' in value:
                errors.append(f'Page {i}: unresolved reference or replacement glyph')
            for block in page.get_text('dict')['blocks']:
                for line in block.get('lines', []):
                    for span in line['spans']:
                        if interior and span['color'] not in (0, 16777215):
                            errors.append(f'Page {i}: text uses a tint: {span["text"]}')
                        rect = pymupdf.Rect(span['bbox'])
                        if rect.x0 < -1 or rect.x1 > 505 or rect.y0 < -1 or rect.y1 > 721:
                            errors.append(f'Page {i}: text extends beyond the page')
            if interior:
                for drawing in page.get_drawings():
                    for key in ('fill', 'color'):
                        color = drawing.get(key)
                        if color is not None and not (all(abs(c) < .001 for c in color)
                                                      or all(abs(c - 1) < .001 for c in color)):
                            errors.append(f'Page {i}: vector artwork contains a grey tint')
                raw = page.get_pixmap(matrix=pymupdf.Matrix(.5, .5), colorspace=pymupdf.csRGB, alpha=False).samples
                if raw[0::3] != raw[1::3] or raw[1::3] != raw[2::3]:
                    errors.append(f'Page {i}: visible colour remains')
        pages = len(doc)
    log = Path(job['log'])
    if not log.exists():
        errors.append('Final compilation log is missing')
    else:
        value = log.read_text(encoding='utf-8', errors='replace')
        for issue in ('Overfull', 'Missing character:', 'LaTeX Font Warning:'):
            if issue in value:
                errors.append('Build log contains ' + issue)
    return dict(path=job['output'], kind=job['kind'], pages=pages,
                fonts=sorted(fonts), errors=sorted(set(errors)))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('operation', choices=('prepare', 'check'))
    parser.add_argument('manifest', nargs='?', type=Path)
    args = parser.parse_args()
    if args.operation == 'prepare':
        prepare()
        return
    if not args.manifest:
        parser.error('check requires a build manifest')
    jobs = json.loads(args.manifest.read_text(encoding='utf-8-sig'))
    if isinstance(jobs, dict):
        jobs = [jobs]
    results = [check(job) for job in jobs]
    (args.manifest.parent / 'print-checks.json').write_text(json.dumps(results, indent=2), encoding='utf-8')
    for result in results:
        print(f'{Path(result["path"]).name}: {result["pages"]} pages; {len(result["errors"])} errors')
        for error in result['errors']:
            print('  ' + error)
    sys.exit(1 if any(result['errors'] for result in results) else 0)


if __name__ == '__main__':
    main()
