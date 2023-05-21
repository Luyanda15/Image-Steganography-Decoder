`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.05.2023 13:27:20
// Design Name: 
// Module Name: testbench
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


module testbench(
    );
    
   wire sys_clk_p;
   wire sys_clk_n;
   reg reset;
   reg [1:0] gpio_buttons;
   reg 	     gpio_switch;
   wire [7:0] leds_n;
   
   // Clock gen
   initial begin
      sys_clk_p = 1'b0;
      forever sys_clk_p = #2.5 ~sys_clk_p;
   end
   // Differential clock
   assign sys_clk_n = ~sys_clk_p;
 
   // reset logic
   initial begin
      reset = 1'b1;
      #100 reset = 1'b0;
   end
   
   isd_decoder lsb_decoder(.sys_clk_p(sys_clk_p), 
        .sys_clk_n(sys_clk_n), .reset(reset));
  
endmodule
