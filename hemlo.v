`timescale 1ns / 1ps

module Counter(input CLK, reset, output reg[2:0] val);
    reg reset_reg = 0;
    reg last_reset = 0;
    always@(posedge CLK) begin
        reset_reg <= reset;
        last_reset <= reset_reg;
        if (!reset_reg && last_reset) begin
            val <= 0;
        end else begin
            val <= val+1;
        end
    end
endmodule