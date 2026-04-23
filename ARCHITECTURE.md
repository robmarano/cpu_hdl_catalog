# MIPS Single-Cycle Architecture

## Solution Architecture

```mermaid
graph TD
    subgraph Computer System
        CLK[Clock Generator]
        CPU[MIPS CPU]
        IMEM[(Instruction Memory)]
        DMEM[(Data Memory)]
    end

    CLK -->|clk| CPU
    CLK -->|clk| DMEM
    CPU -->|pc| IMEM
    IMEM -->|instr| CPU
    CPU -->|dataadr| DMEM
    CPU -->|writedata| DMEM
    CPU -->|memwrite| DMEM
    DMEM -->|readdata| CPU
```

## CPU Internal Architecture

```mermaid
graph TD
    subgraph CPU
        CTRL[Controller]
        DP[Datapath]
    end
    
    subgraph Controller
        MD[Main Decoder]
        AD[ALU Decoder]
    end
    
    subgraph Datapath
        PC[PC Register]
        RF[Register File]
        ALU[Arithmetic Logic Unit]
        EXT[Sign Extend]
    end

    CTRL -->|memtoreg, memwrite, alusrc, regdst, regwrite, jump, pcsrc| DP
    CTRL -->|alucontrol 4-bit| ALU
    DP -->|zero| CTRL
```

## Instruction Execution Sequence

```mermaid
sequenceDiagram
    participant PC as Program Counter
    participant IMEM as Instruction Mem
    participant CTRL as Controller
    participant RF as Register File
    participant ALU as ALU
    participant DMEM as Data Mem

    PC->>IMEM: Fetch Instruction (PC)
    IMEM-->>CTRL: Instruction [31:26], [5:0]
    IMEM-->>RF: Read Registers [25:21], [20:16]
    IMEM-->>ALU: Sign-Extended Imm [15:0] (if alusrc)
    
    CTRL->>RF: Control Signals (regdst, regwrite)
    CTRL->>ALU: ALU Control (4-bit)
    
    RF-->>ALU: Operand A & Operand B
    ALU-->>DMEM: ALU Result (Address)
    RF-->>DMEM: Write Data
    
    CTRL->>DMEM: memwrite
    DMEM-->>RF: Read Data (if memtoreg)
    ALU-->>RF: ALU Result (if not memtoreg)
```

## Unimplemented Designs (Future Work)
The current single-cycle MIPS implementation is functional but currently lacks the following common CPU architecture features:
- **Pipelining**: Breaking down the cycle into IF, ID, EX, MEM, WB stages using pipeline registers.
- **Hazard Detection & Forwarding Unit**: Required to resolve data and control hazards if pipelining is introduced.
- **Exception Handling (Coprocessor 0)**: Support for handling internal exceptions (overflows, undefined instructions) and external interrupts.
- **Floating-Point Unit (Coprocessor 1)**: For hardware acceleration of IEEE 754 operations.
- **Cache Memory**: Replacing direct combinatorial memory access with hierarchical L1/L2 caches.
- **Branch Prediction**: Static or dynamic branch predictors to minimize control hazard penalties.
