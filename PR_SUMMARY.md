# Pull Request Summary: Architecture Fixes & Stabilization

## Previous Work (from last PR & Commits)
- Merged core modules (`aludec`, `cpu`, `datapath`, `regfile`).
- Added `dmem` module.
- Fixed `tb_computer.sv` and added `program_exe` ensuring the single-cycle computer works fundamentally.

## Current Design Changes & Fixes
- **Register File Security**: Protected Register 0 (`$0`) from being overwritten by modifying `regfile.sv` to explicitly check `wa3 != 0`.
- **ALU Control Bus Expansion**: Expanded `alucontrol` from 3-bit to 4-bit across `alu`, `aludec`, `datapath`, `cpu`, and `controller` to provide enough addressing space for all implemented instructions, removing the collision between MULT/DIV and NOR/MFHI.
- **ALU Decoder Extensions**: Mapped `nor` and `div` instructions into `aludec.sv`.
- **Controller Register Write Fix**: Disabled the `regwrite` signal in `controller.sv` for `mult` and `div` R-type instructions to correctly prevent writing their combinational outputs to the main register file.
- **Testbench Stabilization**: Corrected an out-of-bounds array access in `tb_computer.sv` (from byte address 84 to word address 21).
- **Clock Generator Fix**: Replaced problematic while-loops in `clock.sv` with a robust simulation-friendly continuous toggle block.
