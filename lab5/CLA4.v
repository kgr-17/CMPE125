`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2026 04:22:45 PM
// Design Name: 
// Module Name: CLA4
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module CLA4 (
    input  [3:0] A,
    input  [3:0] B,
    input        Ci,
    output [3:0] S,
    output       Co,
    output       PG,
    output       GG
);

    wire [3:0] P;
    wire [3:0] G;
    wire [2:0] C;

    // Four 1-bit GP Full Adders
    GPFullAdder FA0 (
        A[0],
        B[0],
        Ci,
        G[0],
        P[0],
        S[0]
    );

    GPFullAdder FA1 (
        A[1],
        B[1],
        C[0],
        G[1],
        P[1],
        S[1]
    );

    GPFullAdder FA2 (
        A[2],
        B[2],
        C[1],
        G[2],
        P[2],
        S[2]
    );

    GPFullAdder FA3 (
        A[3],
        B[3],
        C[2],
        G[3],
        P[3],
        S[3]
    );

    // Carry Lookahead Logic
    CLALogic CLA (
        G,
        P,
        Ci,
        C,
        Co,
        PG,
        GG
    );

endmodule