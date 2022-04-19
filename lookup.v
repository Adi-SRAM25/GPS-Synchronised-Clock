`timescale 1ns / 1ps


module lookup(
    input clk
    );
	 
	 reg [7:0] rand;
	 integer fd;
	 initial begin
	 fd = $fopen("out.txt", "w");
	 @(posedge clk)
        $fwriteb(fd, $random);
	 $fclose(fd);
	 end
endmodule
