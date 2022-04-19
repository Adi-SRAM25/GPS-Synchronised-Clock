
`timescale 1ns / 1ps

module Counter_1 (reset,clk,q);
  input clk;
  input reset;
  output reg[27:0]q=28'd0;
  
  
  always@(posedge clk , posedge reset)
    begin
	 
     if(reset)
       q<=0;
     else
       q<=q+1;
   end  
	
endmodule
