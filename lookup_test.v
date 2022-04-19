`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:17:50 04/14/2022
// Design Name:   lookup
// Module Name:   C:/Counter/lookup_test.v
// Project Name:  Counter
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: lookup
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module lookup_test;

	// Inputs
	reg clk;

	// Instantiate the Unit Under Test (UUT)
	lookup uut (
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		forever #50 clk = ~clk;
		// Wait 100 ns for global reset to finish
		#10000;
        
		// Add stimulus here

	end
      
endmodule

