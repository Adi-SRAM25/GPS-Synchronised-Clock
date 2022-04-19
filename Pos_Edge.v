`timescale 1ns / 1ps

module Pos_Edge( input clk, input sig, output pe);
	 
reg sig_dly;

always @(posedge clk) begin
 sig_dly <= sig;
 end
 
 assign pe = sig & ~sig_dly;


endmodule






