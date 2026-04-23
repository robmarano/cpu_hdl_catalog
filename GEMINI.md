# MIPS CPU HDL Catalog

This repository is used in the **ECE 251 Computer Architecture** course at **Cooper Union** (cooper.edu). It serves as a catalog of SystemVerilog components to build a computer, specifically implementing a single-cycle MIPS-based 32-bit RISC processor. The project was developed by **Prof Rob Marano** and is based on the architecture described in *Digital Design & Computer Architecture* by Harris and Harris.

## Project Overview

The project implements a single-cycle MIPS CPU using a modular approach. Each hardware component (ALU, Adder, Register File, etc.) is defined in its own directory within the `behavorial/` folder.

### Key Components
- **CPU**: Top-level CPU module (`behavorial/cpu/cpu.sv`) integrating the controller and datapath.
- **Controller**: Decodes instructions and generates control signals (`behavorial/controller/controller.sv`).
- **Datapath**: Connects registers and the ALU to execute instructions (`behavorial/datapath/datapath.sv`).
- **ALU**: Arithmetic Logic Unit supporting ADD, SUB, AND, OR, SLT, and MULT (`behavorial/alu/alu.sv`).
- **Memory**: Instruction Memory (`imem`) and Data Memory (`dmem`). `imem` loads programs from hex files.

## Getting Started

### Prerequisites
- **Icarus Verilog** (`iverilog`): For compilation and simulation.
- **VVP**: The runtime for Icarus Verilog.
- **GTKWave**: For viewing simulation waveforms (`.vcd` files).
- **Make**: To automate the build process.

### Building and Running
Each module directory contains a `Makefile`. The main entry point for simulating the full computer is in `behavorial/computer/`.

```bash
cd behavorial/computer/

# Compile the design and testbench
make compile

# Run the simulation (generates tb_computer.vcd)
make simulate

# View waveforms (requires a GUI environment)
make display

# Cleanup generated files
make clean
```

### Loading Programs
Programs are stored as hex strings in files like `program_exe` or `mult-prog_exe` in the `behavorial/imem/` or `behavorial/computer/` directories.
To switch between programs, you must edit `behavorial/imem/imem.sv` and update the `$readmemh` call:

```verilog
initial begin
  // Update this path to load a different program
  $readmemh("mult-prog_exe", RAM);
end
```

## Development Conventions

- **Modularity**: Components are isolated in subdirectories.
- **Includes**: Files use `\`include` to reference dependencies. Pathing is relative (e.g., `../alu/alu.sv`).
- **Include Guards**: Every file is wrapped in `\`ifndef MODULE_NAME` / `\`define MODULE_NAME` to prevent multiple inclusions.
- **Headers**: All files include a standard Cooper Union ECE 251 header with attribution and metadata.
- **Testbenches**: Named with the `tb_` prefix (e.g., `tb_computer.sv`).
- **Parameterization**: Modules often use parameters (e.g., `#(parameter n = 32)`) for bit-width flexibility.

## Directory Structure Highlights
- `behavorial/computer/`: Top-level "system-on-chip" assembly.
- `behavorial/cpu/`: Core CPU logic.
- `behavorial/alu/`: Math and logic operations.
- `behavorial/regfile/`: 32-port register file.
- `behavorial/imem/` & `behavorial/dmem/`: Memory modules.
