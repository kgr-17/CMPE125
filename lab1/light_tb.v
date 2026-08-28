`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/08/27 17:17:05
// Design Name: 
// Module Name: light_tb
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


module light_tb();

    reg x1;
    reg x2;
    wire f;
    
    
    
    light uut(
    .x1(x1),
    .x2(x2),
    .f(f)
    );
    
    
    initial begin

        x1 = 0;
        x2 = 0;
        #10;

        x1 = 0;
        x2 = 1;
        #10;

        x1 = 1;
        x2 = 0;
        #10;

        x1 = 1;
        x2 = 1;
        #10;

        $finish;

    end
endmodule
