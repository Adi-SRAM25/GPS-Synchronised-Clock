`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:44:53 04/16/2022
// Design Name:   hemlo
// Module Name:   C:/Counter/hemlo_test.v
// Project Name:  Counter
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: hemlo
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module hemlo_test;

	// Inputs
	reg sig;
	reg clk;

	// Outputs
	wire pe;

	// Instantiate the Unit Under Test (UUT)
	hemlo uut (
		.sig(sig), 
		.clk(clk), 
		.pe(pe)
	);
	
	always #10 clk = ~clk;

	initial begin
		// Initialize Inputs
		sig <= 0;
		clk<=0;

		#105 sig <= 1;
		
        
		// Add stimulus here

	end
	
      
endmodule

