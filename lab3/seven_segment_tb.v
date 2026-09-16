`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2026 04:18:05 PM
// Design Name: 
// Module Name: seven_segment_tb
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
`timescale 1ns / 1ps

module seven_segment_tb;

    reg  [3:0] SW;
    wire [6:0] HEX0;

    reg [6:0] expected [0:15];
    integer i;
    integer errors;

    // Connect the circuit being tested
    seven_segment dut (
        .SW(SW),
        .HEX0(HEX0)
    );

    initial begin
        // Expected outputs in gfedcba order
        expected[0]  = 7'b1000000;
        expected[1]  = 7'b1111001;
        expected[2]  = 7'b0100100;
        expected[3]  = 7'b0110000;
        expected[4]  = 7'b0011001;
        expected[5]  = 7'b0010010;
        expected[6]  = 7'b0000010;
        expected[7]  = 7'b1111000;
        expected[8]  = 7'b0000000;
        expected[9]  = 7'b0011000;
        expected[10] = 7'b0001000;  // A
        expected[11] = 7'b0000011;  // B
        expected[12] = 7'b0100111;  // C
        expected[13] = 7'b0100001;  // D
        expected[14] = 7'b0000110;  // E
        expected[15] = 7'b0001110;  // F

        errors = 0;

        // Apply each input for 100 ns
        for (i = 0; i < 16; i = i + 1) begin
            SW = i;
            #100;


            end

    end

endmodule