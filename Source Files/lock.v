`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2022 21:41:45
// Design Name: 
// Module Name: lock
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


module lock(input A,B,C,D, clk,rst, output reg[6:0] O);
    wire A_debounced, B_debounced, C_debounced, D_debounced;
    debouncer d1(A, clk, A_debounced);
    debouncer d2(B, clk, B_debounced);
    debouncer d3(C, clk, C_debounced);
    debouncer d4(D, clk, D_debounced);
    parameter [3:0] 
        zero = 3'b000, one = 3'b001, two = 3'b010, three = 3'b011, full = 3'b100;
    reg [3:0] state;
    always @(posedge A_debounced, posedge B_debounced, posedge C_debounced, posedge D_debounced, negedge rst) begin
        if (!rst)
            state = zero;
        else begin
            case (state) 
                zero: 
                    if (A_debounced)
                        state <= one;
                one: 
                    if (B_debounced)
                        state <= two;
                    else if (A_debounced)
                        state <= one;
                    else
                        state <= zero;
                two: 
                    if (C_debounced)
                        state <= three;
                    else if (A_debounced)
                            state <= one;
                        else
                            state <= zero;
                three: 
                    if (D_debounced)
                        state <= full;
                    else if (A_debounced)
                            state <= one;
                        else
                            state <= zero;
 
            endcase
        end
    end
    always @(state) begin
        if (state == full)
            O = 7'b1000001;
        else
            O = 7'b1110001;
    end
endmodule
