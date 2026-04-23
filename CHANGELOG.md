# Changelog

All notable changes to this project will be documented in this file.

## [v0.1.0] - 2026-04-23
### Added
- **Multi-Cycle Computer**: Full implementation of a 12-state FSM-based MIPS32 processor.
- **Pipelined Computer**: Advanced 5-stage pipeline with hazard unit and exceptions.
- **Centralized Programs Directory**: Shared `.asm` and `.exe` files for all architectures.
- **Centralized Tools Directory**: Shared Python assembler and patching utilities.
- **MASTER_GUIDE.md**: Structured pedagogical roadmap for students.
- **Include Guards**: `` `ifndef `` guards added to all SV source files.

### Changed
- **Unified Repository Structure**: Reorganized files into architecture-specific folders.
- **4-bit ALU Control**: Standardized all computers to use 4-bit `alucontrol` (0-15) to resolve opcode collisions.
- **Makefiles**: Updated all build scripts to work with the new relative pathing.

### Fixed
- **ALU Control Collisions**: Fixed overlap between `mult`/`nor` and `div`/`mfhi`.
- **Register 0 Protection**: Ensured Register 0 is never modified in any architecture.
- **Testbench Stability**: Corrected array out-of-bounds warnings and clock race conditions.
