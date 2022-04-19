`timescale 1ns / 1ps

module counter_module(rst,clk,q);
  input clk;
  input rst;
  output reg[27:0]q=28'd0;
  
  always@(posedge clk , posedge rst)
    begin
     if(rst)
       q<=0;
     else
       q<=q+1;
   end  
  
endmodule
