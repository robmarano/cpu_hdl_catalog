//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2023
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: aludec
//     Description: 32-bit RISC ALU decoder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef ALUDEC
`define ALUDE

`timescale 1ns/100ps

module aludec
    #(parameter n = 32)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic [5:0] funct,
    input  logic [1:0] aluop,
    output logic [2:0] alucontrol);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    always @*
    begin
        case(aluop)
        2'b00: alucontrol <= 3'b010;  // add (for lw/sw/addi)
        2'b01: alucontrol <= 3'b110;  // sub (for beq)
        default:
            // for R-type instructions
            case(funct)
                6'b100000: alucontrol <= 3'b010; // add
                6'b100010: alucontrol <= 3'b110; // sub
                6'b100100: alucontrol <= 3'b000; // and
                6'b100101: alucontrol <= 3'b001; // or
                6'b101010: alucontrol <= 3'b111; // slt
                6'b011000: alucontrol <= 3'b011; // mult
                6'b010010: alucontrol <= 3'b100; // mflo
                6'b010000: alucontrol <= 3'b101; // mfhi
                default:   alucontrol <= 3'bxxx; // ???
            endcase
        endcase
    end

endmodule

`endif // ALUDEC