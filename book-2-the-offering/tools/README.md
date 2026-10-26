# Book-local build support

`tectonic/tectonic.exe` is the portable Windows compiler. The build downloads
the pinned 0.17.0 release automatically if no local or PATH compiler exists.
The Windows release ZIP is checked against a fixed SHA-256 before extraction.

`build_support.py` converts this book's SVGs to vector PDFs and checks the
compiled output. Python and its pinned PyMuPDF dependency are required. The
book's `build.ps1` installs PyMuPDF in `.cache/python-packages/` if necessary.
There are no imports from the series repository or other book folders.
