`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2026 03:16:53 PM
// Design Name: 
// Module Name: GPFullAdder
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

module GPFullAdder (
    input  Ai,
    input  Bi,
    input  Cin,
    output G,
    output P,
    output S
);

    xor (P, Ai, Bi);
    and (G, Ai, Bi);
    xor (S, P, Cin);

endmodule