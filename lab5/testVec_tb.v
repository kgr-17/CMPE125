
`timescale 1ns / 1ps

module testVector_tb();

    reg clk, reset;
    reg [3:0] A, B;
    reg Ci;

    reg [4:0] expected;
    reg PGexpected, GGexpected;

    wire [3:0] S;
    wire Co, PG, GG;

    integer vectornum, errors;

    // 16-bit test vectors
    reg [15:0] testvectors [0:3];

    // Instantiate Device Under Test
    CLA4 dut(A, B, Ci, S, Co, PG, GG);

    // Generate clock
    always begin
        clk = 1; #5;
        clk = 0; #5;
    end

    // Load test vectors and initialize
    initial begin
        $readmemb(
            "/home/017406857@SJSUAD/Downloads/test_vector.tv",
            testvectors
        );

        vectornum = 0;
        errors = 0;
        reset = 1;

        A = 0;
        B = 0;
        Ci = 0;
        expected = 0;
        PGexpected = 0;
        GGexpected = 0;

        #27;
        reset = 0;
    end

    // Apply inputs on rising edge
    always @(posedge clk) begin
        if (!reset && vectornum < 4) begin
            #1;
            {A, B, Ci, expected, PGexpected, GGexpected}
                = testvectors[vectornum];
        end
    end

    // Check outputs on falling edge
    always @(negedge clk) begin
        if (!reset && vectornum < 4) begin

            if ({Co, S, PG, GG} !==
                {expected, PGexpected, GGexpected}) begin

                $display("Test %0d FAILED", vectornum + 1);
                $display("A=%b B=%b Ci=%b", A, B, Ci);
                $display("Actual:   Sum=%b PG=%b GG=%b",
                         {Co, S}, PG, GG);
                $display("Expected: Sum=%b PG=%b GG=%b",
                         expected, PGexpected, GGexpected);

                errors = errors + 1;
            end
            else begin
                $display("Test %0d PASSED: Sum=%b PG=%b GG=%b",
                         vectornum + 1, {Co, S}, PG, GG);
            end

            vectornum = vectornum + 1;

            if (vectornum == 4) begin
                $display("%0d tests completed with %0d errors",
                         vectornum, errors);
                $finish;
            end
        end
    end

endmodule
