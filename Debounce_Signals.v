`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.04.2025 15:31:58
// Design Name: 
// Module Name: Debounce_Signals
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


module Debounce_Signals#(parameter threshold =1000000)(
input clk,
input btn,
output reg transmit);

reg button_ff1=0;
reg button_ff2=0;
reg [30:0] count=0;


always @(posedge clk)
begin
button_ff1<=btn;
button_ff2<=button_ff1;
end

always @ (posedge clk)
begin
if(button_ff2)
begin
if(~&count)
count<=count+1;
if(|count)
count<=count-1;
end
if(count>threshold)
transmit<=1;
else 
transmit<=0;
end


endmodule

