`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:51:00 04/18/2022
// Design Name:   Counter
// Module Name:   C:/Counter/abcd.v
// Project Name:  Counter
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module abcd;

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

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

