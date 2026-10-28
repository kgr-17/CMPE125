// CMPE 125 Lab 6 - Basys 3 vending machine
// Clock: 100 MHz. SW0=reset, SW1=Nickel, SW2=Dime, SW3=Quarter.
// Each switch OFF->ON counts as ONE coin (after 10 ms debounce).
// LED0-3 show the last transaction result; LED4-8 show the current state.
// Exactly one state LED is ON (S0 / S5 / S10 / S15 / S20).
//
// NOTE: This is a board-friendly variation of the Mealy FSM.
// The external LED outputs are registered/held instead of instantaneous.



module vending_machine #(
    parameter DEBOUNCE_CYCLES = 1_000_000
)(
    input  wire clk,
    input  wire reset,
    input  wire Nickel,
    input  wire Dime,
    input  wire Quarter,
    output reg  Dispense,
    output reg  ReturnNickel,
    output reg  ReturnDime,
    output reg  ReturnTwoDimes,
    output wire [4:0] StateLED    // bit 0->LED4, ..., bit 4->LED8

);
    localparam [2:0] S0  = 3'b000,
                     S5  = 3'b001,
                     S10 = 3'b010,
                     S15 = 3'b011,
                     S20 = 3'b100;

    reg [2:0] state, next_state;

    // Show the stored balance as one-hot state LEDs (not a binary code).
    // LED4 = S0, LED5 = S5, LED6 = S10, LED7 = S15, LED8 = S20.
    assign StateLED[0] = (state == S0);
    assign StateLED[1] = (state == S5);
    assign StateLED[2] = (state == S10);
    assign StateLED[3] = (state == S15);
    assign StateLED[4] = (state == S20);

    // 1) Synchronize/debounce each of the three physical switches.
    //    100,000,000 clock ticks/second * 0.010 second = 1,000,000.
    reg [2:0] switch_meta, switch_sync;
    reg [2:0] switch_stable, switch_previous;
    reg [19:0] debounce_count [0:2];
    integer i;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            switch_meta     <= 3'b000;
            switch_sync     <= 3'b000;
            switch_stable   <= 3'b000;
            switch_previous <= 3'b000;
            for (i = 0; i < 3; i = i + 1)
                debounce_count[i] <= 20'd0;
        end else begin
            switch_meta     <= {Nickel, Dime, Quarter};
            switch_sync     <= switch_meta;
            switch_previous <= switch_stable;

            for (i = 0; i < 3; i = i + 1) begin
                if (switch_sync[i] == switch_stable[i]) begin
                    debounce_count[i] <= 20'd0;
                end else if (debounce_count[i] == DEBOUNCE_CYCLES-1) begin
                    switch_stable[i]   <= switch_sync[i];
                    debounce_count[i] <= 20'd0;
                end else begin
                    debounce_count[i] <= debounce_count[i] + 1'b1;
                end
            end
        end
    end

    // 2) Create a single-clock coin pulse for each OFF -> ON switch action.
    //    Independent edge detection lets you use another switch even if
    //    you forgot to turn the previous switch OFF.
    wire [2:0] coin_pulse = switch_stable & ~switch_previous;
    wire valid_coin = (coin_pulse == 3'b100) ||
                      (coin_pulse == 3'b010) ||
                      (coin_pulse == 3'b001);

    // 3) Original Mealy state transition logic, driven by coin pulses.
    reg dispense_now, return_nickel_now, return_dime_now, return_two_dimes_now;
    always @(*) begin
        next_state           = state;
        dispense_now         = 1'b0;
        return_nickel_now    = 1'b0;
        return_dime_now      = 1'b0;
        return_two_dimes_now = 1'b0;

        case (state)
            S0: begin
                case (coin_pulse)
                    3'b100: next_state = S5;
                    3'b010: next_state = S10;
                    3'b001: begin
                        next_state = S0;
                        dispense_now = 1'b1;
                    end
                    default: ;
                endcase
            end
            S5: begin
                case (coin_pulse)
                    3'b100: next_state = S10;
                    3'b010: next_state = S15;
                    3'b001: begin
                        next_state = S0;
                        dispense_now = 1'b1;
                        return_nickel_now = 1'b1;
                    end
                    default: ;
                endcase
            end
            S10: begin
                case (coin_pulse)
                    3'b100: next_state = S15;
                    3'b010: next_state = S20;
                    3'b001: begin
                        next_state = S0;
                        dispense_now = 1'b1;
                        return_dime_now = 1'b1;
                    end
                    default: ;
                endcase
            end
            S15: begin
                case (coin_pulse)
                    3'b100: next_state = S20;
                    3'b010: begin
                        next_state = S0;
                        dispense_now = 1'b1;
                    end
                    3'b001: begin
                        next_state = S0;
                        dispense_now = 1'b1;
                        return_nickel_now = 1'b1;
                        return_dime_now = 1'b1;
                    end
                    default: ;
                endcase
            end
            S20: begin
                case (coin_pulse)
                    3'b100: begin
                        next_state = S0;
                        dispense_now = 1'b1;
                    end
                    3'b010: begin
                        next_state = S0;
                        dispense_now = 1'b1;
                        return_nickel_now = 1'b1;
                    end
                    3'b001: begin
                        next_state = S0;
                        dispense_now = 1'b1;
                        return_two_dimes_now = 1'b1;
                    end
                    default: ;
                endcase
            end
            default: next_state = S0;
        endcase
    end

    // 4) Store the FSM state AND keep the result on the LEDs.
    //    LEDs remain on until the next accepted coin or a reset.
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state          <= S0;
            Dispense       <= 1'b0;
            ReturnNickel   <= 1'b0;
            ReturnDime     <= 1'b0;
            ReturnTwoDimes <= 1'b0;
        end else if (valid_coin) begin
            state          <= next_state;
            Dispense       <= dispense_now;
            ReturnNickel   <= return_nickel_now;
            ReturnDime     <= return_dime_now;
            ReturnTwoDimes <= return_two_dimes_now;
        end
    end
endmodule
