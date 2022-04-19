`timescale 1ns / 1ps

module Counter(rst,clock,counter);

input rst; 
input clock; 
output reg[27:0] counter=28'd0;

// The frequency of the output clk_out
// The frequency of the input clk_in divided by DIVISOR
// For example: Fclk_in = 50Mhz, if you want to get 1Hz signal to blink LEDs
// You will modify the DIVISOR parameter value to 28'd50.000.000
// Then the frequency of th2q-e output clk_out = 50Mhz/50.000.000 = 1Hz

always @(posedge clock)
begin
  if (rst'event and rst=1)
	 counter <= counter + 28'd1;
  else
    counter <= 28'd0;
end

endmodule