`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.04.2023 15:32:06
// Design Name: 
// Module Name: isd_decoder
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


module isd_decoder(sys_clk_p, sys_clk_n, reset, addra, dina, douta);
    // Define port types and directions
    input sys_clk_p, sys_clk_n, reset;
    input [15:0] addra;
    input [7:0] dina;
    output [7:0] douta;
    
    wire enable, write_enable;
    
    reg [7:0] data_ref;
    reg [7:0] data_stg;
    wire [7:0] d_out;
    
    parameter W_DEPTH = 100000;
    reg [7:0]  ref_image[W_DEPTH-1:0];
    reg [7:0]  stg_image[W_DEPTH-1:0];
    
    initial begin
        $readmemh("ref_image.mem", ref_image);
        $readmemh("stego_image.mem", stg_image);        
    end
    
    stego_detector stg_detector (.clk_p(sys_clk_p),
        .clk_n(sys_clk_n), .reset(reset),
        .data_ref(data_ref), .data_stg(data_stg),
        .d_out(d_out));
        
    blk_mem_gen_0 blk_mem(.clka(sys_clk_p),
        .ena(enable), .wea(write_enable),
        .addra(addra), .dina(dina),
        .douta(douta));
        
    integer i;   
    always @(posedge sys_clk_p)
        begin : test_loop_p
            for(i = 0; i < W_DEPTH -1; i=i+3)
               #5 data_ref <= ref_image[i];
            // small delay why not           
    end
    
    always @(posedge sys_clk_n)
        begin : test_loop_n
            for(i = 0; i < W_DEPTH -1; i=i+3)
                #5 data_stg <= stg_image[i];
            // small delay why not           
    end
  endmodule