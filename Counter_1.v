`timescale 1ns / 1ps

module Counter_1 (reset,clk,q);
  input clk;
  input reset;
  output reg[27:0]q=28'd0;
  
  reg [27:0] q1 = 28'd0;
  reg sig_dly;
  reg pe;
  
  always@(posedge clk , posedge reset)
    begin
	 sig_dly <= reset;
     if(reset)
       q1<=0;
     else
       q1<=q1+1;
   end  
	
 assign pe = reset & ~sig_dly; 
 assign q=(~pe)& q1;
  
endmodule
