# Windows build tools

The preserved portable Tectonic 0.17.0 Windows x64 compiler is in
`tectonic/tectonic.exe`; its original ZIP is retained here too. `python-packages/`
preserves the PDF tooling used to inspect and compare this migration.

Each book has its own compiler copy and build support. It never looks here or
in another book to compile. If a compiler binary is omitted from a source-only
export, the book's build script can download and verify the pinned release.
Downloaded binaries and Python packages are ignored by Git.
