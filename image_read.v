`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/04/2023 09:15:33 AM
// Design Name: 
// Module Name: image_read
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module image_read(
        input clk,
        output reg LSB
    );
parameter SIZE = 41420;
reg [15:0] rom_memory [SIZE-1:0];
reg [1:0] lsbs [SIZE-1:0];
integer i;

initial begin
    $readmemh("image_values.mem", rom_memory);
    i = 0;
end

always @(posedge clk) begin
    LSB = rom_memory[i] & 1'b1;
    i = i + 1;
    if(i == SIZE)
        i = 0;
end
    
endmodule
