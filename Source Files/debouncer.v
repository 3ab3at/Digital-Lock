`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2022 21:36:14
// Design Name: 
// Module Name: debouncer
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


module debouncer(input pb_1,clk,output pb_out);
    wire slow_clk;
    wire Q1,Q2,Q2_bar,Q0;
    clock_div u1(clk,slow_clk);
    my_dff d0(slow_clk, pb_1,Q0 );
    
    my_dff d1(slow_clk, Q0,Q1 );
    my_dff d2(slow_clk, Q1,Q2 );
    assign Q2_bar = ~Q2;
    assign pb_out = Q1 & Q2_bar;
endmodule
