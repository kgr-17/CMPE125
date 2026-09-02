`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/01/2026 04:00:02 PM
// Design Name: 
// Module Name: full_adder_tb
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

module full_adder_tb;

    reg A;
    reg B;
    reg Cin;

    wire S;
    wire Cout;

    full_adder uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .S(S),
        .Cout(Cout)
    );

    initial begin
        A = 0; B = 0; Cin = 0;
        #10;

        A = 0; B = 0; Cin = 1;
        #10;

        A = 0; B = 1; Cin = 0;
        #10;

        A = 0; B = 1; Cin = 1;
        #10;

        A = 1; B = 0; Cin = 0;
        #10;

        A = 1; B = 0; Cin = 1;
        #10;

        A = 1; B = 1; Cin = 0;
        #10;

        A = 1; B = 1; Cin = 1;
        #10;

        $finish;
    end

endmodule