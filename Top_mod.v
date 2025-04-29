`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.04.2025 15:46:54
// Design Name: 
// Module Name: Top_mod
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


module Top_mod (input [7:0] data,
 input clk, 
 input transmit,
  input btn, 
  output TxD,
output TxD_Debug,
output transmit_debug,
output btn_debug,
output clk_debug);





wire transmit_out;
//Transmitter T1(clk, data, transmit_out, btn, TxD);
Transmitter T1(
  .clk(clk),
  .data(data),          // 8-bit data from switches
  .transmit(transmit_out), // Debounced signal from Debounce_Signals
  .reset(btn),          // Raw reset button
  .TxD(TxD)
);
//Debounce_Signals DB (clk, btn, transmit_out);
//Debounce_Signals DB (
//  .clk(clk),
//  .btn(transmit),       // Raw transmit button (from Top_mod input)
//  .transmit(transmit_out) // Debounced output
//);

debounce db (
  .clk_in(clk),
  .pb(transmit),       // Raw transmit button (from Top_mod input)
  .led(transmit_out) // Debounced output
);


assign TxD_Debug =TxD;
assign transmit_debug =transmit_out;
assign btn_debug =btn;
assign clk_debug =clk;



endmodule
