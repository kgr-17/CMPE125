`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2026 04:17:12 PM
// Design Name: 
// Module Name: seven_segment
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


module seven_segment (
    input  wire [3:0] SW,
    output wire [6:0] HEX0,
    output AN[3:0]
);

    wire D3, D2, D1, D0;

    assign D3 = SW[3];
    assign D2 = SW[2];
    assign D1 = SW[1];
    assign D0 = SW[0];
    assign AN = 4'b1110;

    // Segment a
    assign HEX0[0] =
        ( D2 & ~D1 & ~D0) |
        ( D3 &  D2 & ~D1) |
        (~D3 & ~D2 & ~D1 & D0) |
        ( D3 & ~D2 &  D1 & D0);

    // Segment b
    assign HEX0[1] =
        ( D3 &  D2 & ~D0) |
        (~D3 &  D2 & ~D1 & D0) |
        ( D3 &  D1 &  D0) |
        ( D2 &  D1 & ~D0);

    // Segment c
    assign HEX0[2] =
        (~D3 & ~D2 & D1 & ~D0) |
        ( D3 &  D2 & ~D0) |
        ( D3 &  D2 &  D1);

    // Segment d
    assign HEX0[3] =
        (~D3 &  D2 & ~D1 & ~D0) |
        (~D2 & ~D1 &  D0) |
        ( D2 &  D1 &  D0) |
        ( D3 & ~D2 &  D1 & ~D0);

    // Segment e
    assign HEX0[4] =
        (~D3 &  D0) |
        (~D3 &  D2 & ~D1) |
        (~D2 & ~D1 &  D0);

    // Segment f
    assign HEX0[5] =
        ( D3 &  D2 & ~D1) |
        (~D3 & ~D2 &  D0) |
        (~D3 & ~D2 &  D1) |
        (~D3 &  D1 &  D0);

    // Segment g: output is 1 for inputs 0, 1, and 7
    assign HEX0[6] =
        (~D3 & ~D2 & ~D1) |
        (~D3 &  D2 &  D1 & D0);

endmodule
