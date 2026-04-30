# Hardware Challenge: Fast Inverse Square Root

## The Quake III Algorithm
In 1999, John Carmack (and others) famously implemented the "Fast Inverse Square Root" algorithm in C for the game *Quake III Arena*. It calculates `1 / sqrt(x)` using bit-level hacking and Newton-Raphson approximation, avoiding the massive hardware latency of traditional floating-point division.

```c
float Q_rsqrt( float number ) {
	long i;
	float x2, y;
	const float threehalfs = 1.5F;

	x2 = number * 0.5F;
	y  = number;
	i  = * ( long * ) &y;                       // evil floating point bit level hacking
	i  = 0x5f3759df - ( i >> 1 );               // what the fuck? 
	y  = * ( float * ) &i;
	y  = y * ( threehalfs - ( x2 * y * y ) );   // 1st iteration
	return y;
}
```

## The Hardware Challenge
Currently, our educational 5-Stage Pipelined SystemVerilog CPU **cannot** execute this algorithm. 

To successfully implement this in our hardware, the following architectural extensions must be designed and integrated:

### 1. Shift Right Logical (`srl`)
The "magic" line of code (`i = 0x5f3759df - (i >> 1)`) requires an arithmetic shift right.
*   **Hardware Req:** Modify `alu.sv` to support a bit-shifting datapath.
*   **Control Req:** Expand `alucontrol` (if necessary) to support an `SRL` operation.
*   **Tooling Req:** Update `tools/assembler.py` to correctly encode the R-Type `srl` instruction, respecting the `shamt` (shift amount) bits `[10:6]`.

### 2. Coprocessor 1 (Floating Point Unit)
The Newton-Raphson iteration (`y = y * (1.5 - (x2 * y * y))`) requires IEEE-754 single-precision floating-point multiplication (`mul.s`) and subtraction (`sub.s`).
*   **Hardware Req:** Implement a secondary ALU dedicated to IEEE-754 math.
*   **Control Req:** Implement `mfc1` and `mtc1` to move raw binary data between the standard integer Register File and the new FPU Register File without data conversion (the "evil bit level hack").

### 3. Alternate Route: Integer Emulation
If an FPU is too complex, the algorithm can theoretically be implemented entirely in integer software, provided the `srl` instruction exists.
*   **Software Req:** Write a MIPS32 subroutine to emulate IEEE-754 multiplication using purely integer operations (shifts, masks, and `add`/`mult`). This would take hundreds of cycles but avoid massive hardware redesigns.
