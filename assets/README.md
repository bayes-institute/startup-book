# Master brand assets

`knowledge_logo.svg` is the Bayes Knowledge lockup. `emblem-primary.svg` is the
B watermark. The supplied paths and proportions are retained.

Every book contains its own SVG copies and vector PDF derivatives. To update a
book's logo, copy the revised source SVG into that book's `assets/` folder and
run its local build. Its `tools/build_support.py` creates primary, black, and
reversed-white PDF variants. No book reads master assets from this directory.
