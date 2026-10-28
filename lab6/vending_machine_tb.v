
`timescale 1ns/1ps

module vending_machine_tb;

    reg clk, reset;
    reg Nickel, Dime, Quarter;
    wire Dispense, ReturnNickel;
    wire ReturnDime, ReturnTwoDimes;
    wire [4:0] StateLED;

    // Use shorter debounce for simulation
    vending_machine #(
        .DEBOUNCE_CYCLES(3)
    ) dut (
        .clk(clk),
        .reset(reset),
        .Nickel(Nickel),
        .Dime(Dime),
        .Quarter(Quarter),
        .Dispense(Dispense),
        .ReturnNickel(ReturnNickel),
        .ReturnDime(ReturnDime),
        .ReturnTwoDimes(ReturnTwoDimes),
        .StateLED(StateLED)
    );

    reg [6:0] test_vectors [0:7];
    integer i, errors;

    // Clock
    always #5 clk = ~clk;

    initial begin
        $readmemb("/home/017406857@SJSUAD/Downloads/test_vector.tv", test_vectors);

        clk = 0;
        reset = 1;
        Nickel = 0;
        Dime = 0;
        Quarter = 0;
        errors = 0;

        #12 reset = 0;

        for (i = 0; i < 8; i = i + 1) begin

            @(negedge clk);

            // Insert coin
            {Nickel, Dime, Quarter} = test_vectors[i][6:4];

            // Wait for debounce
            repeat (8) @(negedge clk);

            // Release coin
            {Nickel, Dime, Quarter} = 3'b000;

            repeat (8) @(negedge clk);

            // Check output
            if ({Dispense, ReturnNickel,
                 ReturnDime, ReturnTwoDimes}
                 !== test_vectors[i][3:0]) begin

                $display("FAIL test %0d", i+1);
                errors = errors + 1;

            end else begin
                $display("PASS test %0d | StateLED=%b",
                         i+1, StateLED);
            end
        end

        if (errors == 0)
            $display("ALL 8 TESTS PASSED");
        else
            $display("%0d TESTS FAILED", errors);

        $finish;
    end

endmodule
