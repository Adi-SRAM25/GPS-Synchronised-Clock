`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:52:14 04/18/2022
// Design Name:   Counter_1
// Module Name:   C:/Counter/Counter_1_test.v
// Project Name:  Counter

module Counter_1_test;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire [27:0] q;

	// Instantiate the Unit Under Test (UUT)
	Counter_1 uut (
		.clk(clk), 
		.reset(reset), 
		.q(q)
	);
	
	  
	  
	
	always #10 clk =~ clk;

	initial begin
		// Initialize Inputs
		
	   clk <= 0;
		reset <= 0;
		// Wait 100 ns for global reset to finish
		#100
		
		reset <= 1;
		
		#100
		
		reset <= 0;
		
		#100
		
		reset <= 1;
		
        
		// Add stimulus here

	end
      
endmodule

