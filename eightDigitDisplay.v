`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.05.2023 00:35:26
// Design Name: 
// Module Name: eightDigitDisplay
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


module EightDigitSevenSegmentDisplay(
    input [31:0] message,  // 32-bit input signal for the values to be displayed on each digit
    output [63:0] segment  // 64-bit output signal to control the segments of all 8 7-segment displays
);

    reg [7:0] segment_pattern [0:7];  // Register to store the segment pattern for each digit
    
    always @(*)  // Continuous assignment to update the segment patterns based on the message input
    begin
        for (integer i = 0; i < 8; i = i + 1) begin  // Iterate over each of the 8 digits
            case(message[4*i +: 4])  // Use a case statement to map each 4-bit nibble to the corresponding segment pattern
                4'h0: segment_pattern[i] = 8'h3F;  // If the nibble is 0, set the segment pattern to display '0'
                4'h1: segment_pattern[i] = 8'h06;  // If the nibble is 1, set the segment pattern to display '1'
                4'h2: segment_pattern[i] = 8'h5B;  // If the nibble is 2, set the segment pattern to display '2'
                4'h3: segment_pattern[i] = 8'h4F;  // If the nibble is 3, set the segment pattern to display '3'
                4'h4: segment_pattern[i] = 8'h66;  // If the nibble is 4, set the segment pattern to display '4'
                4'h5: segment_pattern[i] = 8'h6D;  // If the nibble is 5, set the segment pattern to display '5'
                4'h6: segment_pattern[i] = 8'h7D;  // If the nibble is 6, set the segment pattern to display '6'
                4'h7: segment_pattern[i] = 8'h07;  // If the nibble is 7, set the segment pattern to display '7'
                4'h8: segment_pattern[i] = 8'h7F;  // If the nibble is 8, set the segment pattern to display '8'
                4'h9: segment_pattern[i] = 8'h6F;  // If the nibble is 9, set the segment pattern to display '9'
                default: segment_pattern[i] = 8'h00;  // If the nibble is not a valid digit, display blank
            endcase
        end
    end

    // Concatenate the segment patterns for each digit and assign to the output
    assign segment = {segment_pattern[7], segment_pattern[6], segment_pattern[5], segment_pattern[4], segment_pattern[3], segment_pattern[2], segment_pattern[1], segment_pattern[0]};

endmodule

