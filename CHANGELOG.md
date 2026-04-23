# Changelog

All notable changes to this project will be documented in this file.

## [0.0.1] - 2026-04-23
### Added
- `GEMINI.md` to document project guidelines, structure, and architecture.
- `ARCHITECTURE.md` to map out UML and Mermaid sequence/structural diagrams.
- Missing instruction decodings for `div` and `nor` in `aludec.sv`.

### Changed
- Expanded `alucontrol` signal from 3-bit to 4-bit across `cpu`, `controller`, `datapath`, `alu`, and `aludec` modules to fix operational collision.
- Refactored `clock.sv` generator to a clean `always` block for simulator stability.

### Fixed
- Prevented R-type `mult` and `div` instructions from asserting `regwrite` in the `controller`.
- Protected Register 0 (`$0`) from being written to in `regfile.sv`.
- Fixed array out of bounds read (`RAM[84]`) in `tb_computer.sv`, correcting it to word-aligned index `21`.
