# Pull Request Summary: Unified MIPS CPU Project Template

## Overview
This PR represents a major evolution of the repository into a production-ready pedagogical template for ECE 251. It integrates three distinct MIPS32 architectures, centralizes common resources, and introduces a robust multi-cycle implementation.

## Key Changes

### 1. Repository Restructuring
- **Flattened and Modularized**: Reorganized the repository into three self-contained folders: `single_cycle_computer/`, `multi_cycle_computer/`, and `pipelined_computer/`.
- **Centralized Programs**: Created a top-level `programs/` directory to host shared `.asm` and compiled `.exe` files, ensuring all three computers can run the same software tests.
- **Centralized Tooling**: Moved `assembler.py` and `patch.py` into a top-level `tools/` directory.

### 2. Multi-Cycle Implementation (New)
- Designed and built a **12-state FSM-based multi-cycle MIPS32 processor** from scratch.
- **Unified Memory**: Implemented a shared Instruction/Data memory module (`mem.sv`).
- **Intermediate State**: Added non-architectural registers (`IR`, `MDR`, `A`, `B`, `ALUOut`) to hold state between cycles.
- **Verified**: Confirmed functionality via testbench simulation using the centralized multiplication program.

### 3. Pipelined Implementation Integration
- Imported the advanced **5-stage pipelined processor** from the Week 12 curriculum.
- Includes full **Hazard Detection**, **Data Forwarding**, and **Exception Handling** support.
- Standardized the ALU control and decoding logic to match the rest of the template.

### 4. Standardization & Documentation
- **4-bit ALU Control**: Synchronized all three architectures to a unified 4-bit ALU control bus, resolving instruction collisions for `mult`, `div`, `nor`, and `mfhi`.
- **Include Guards**: Added missing `` `ifndef `` guards to all SystemVerilog modules to prevent double-compilation errors.
- **Master Guide**: Added `MASTER_GUIDE.md` providing a structured, phase-based roadmap for students.
- **Comprehensive README**: Updated the root `README.md` and repository description.

## Architecture Diagrams
- Updated `ARCHITECTURE.md` with:
    - **Multi-Cycle FSM State Diagram** (Mermaid).
    - **Pipeline Stage Visualization** (Mermaid).
    - **Solution Architecture** for the unified system.

## Unimplemented Designs (For Future Iterations)
- **Precise Exception Recovery**: Fixing the EPC capture logic in the pipelined model (Stage EX vs ID).
- **Branch Prediction**: Moving from static 1-cycle penalty to dynamic prediction.
- **Memory-Mapped I/O Extensions**: Adding UART/VGA simulation targets.
- **Cache Controller**: Implementing an L1 instruction/data cache in front of unified memory.
