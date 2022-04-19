`timescale 1ns / 1ps


module testing;

	// Inputs
	reg rst;
	reg clock;
	// Outputs
	wire [27:0] counter;

	// Instantiate the Unit Under Test (UUT)
	Counter uut (
		.rst(rst), 
		.clock(clock), 
		.counter(counter)
	);

	initial begin
		// Initialize Inputs
		rst = 0;
		clock = 0;
		forever #10 clock= ~clock;

	end
      
endmodule

