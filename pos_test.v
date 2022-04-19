`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:58:56 04/19/2022
// Design Name:   Pos_Edge
// Module Name:   C:/Counter/pos_test.v
// Project Name:  Counter
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Pos_Edge
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module pos_test;

	// Inputs
	reg clk;
	reg sig;

	// Outputs
	wire pe;

	// Instantiate the Unit Under Test (UUT)
	Pos_Edge uut (
		.clk(clk), 
		.sig(sig), 
		.pe(pe)
	);
	
	always #10 clk =~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		sig = 0;

		// Wait 100 ns for global reset to finish
		#100;
		sig =1;
        
		// Add stimulus here

	end
      
endmodule

