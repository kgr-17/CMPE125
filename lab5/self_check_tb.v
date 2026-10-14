`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2026 04:26:39 PM
// Design Name: 
// Module Name: self_check_tb
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




module self_check_tb();

    reg [3:0] A, B;
    reg Ci;

    wire [3:0] S;
    wire Co, PG, GG;

    // Instantiate Device Under Test
    CLA4 dut(A, B, Ci, S, Co, PG, GG);

    // Apply inputs and check results
    initial begin

        // Test 1: 0 + 0 = 0
        A = 4'd0; B = 4'd0; Ci = 0; #10;
        if ({Co, S} !== 5'd0)
            $display("Test 1 failed.");
        else
            $display("Test 1 passed.");

        // Test 2: 3 + 5 = 8
        A = 4'd3; B = 4'd5; Ci = 0; #10;
        if ({Co, S} !== 5'd8)
            $display("Test 2 failed.");
        else
            $display("Test 2 passed.");

        // Test 3: 9 + 6 + 1 = 16
        A = 4'd9; B = 4'd6; Ci = 1; #10;
        if ({Co, S} !== 5'd16)
            $display("Test 3 failed.");
        else
            $display("Test 3 passed.");

        // Test 4: 15 + 15 = 30
        A = 4'd15; B = 4'd15; Ci = 0; #10;
        if ({Co, S} !== 5'd30)
            $display("Test 4 failed.");
        else
            $display("Test 4 passed.");

        $finish;

    end

endmodule

