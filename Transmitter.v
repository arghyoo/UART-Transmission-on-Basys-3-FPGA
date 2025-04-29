`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.04.2025 15:15:35
// Design Name: 
// Module Name: Transmitter
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


module Transmitter(
input clk,
input [7:0] data,
input transmit,
input reset,
output reg TxD);



reg [3:0]  bit_counter; // Counter to count 10 bits, 2 bit for start and stop and other bits for data
reg[13:0] baudrate_counter;//10,415
//counter = clock/baudrate clock =100MHz baudrate=9600

reg[9:0] shiftright_register; // 10 bits serially transmitted
reg state, next_state;// idle mode and transmitting mode
reg shift;// shift signal to shart shifting the bits in UART
reg load; // loadthe data into shift right register
reg clear; // reset the bit counter for UART transmission

always@(posedge clk)
begin
if(reset)
begin
state<= 0;
 bit_counter<=0;
baudrate_counter<=0;
end
else begin
baudrate_counter<=baudrate_counter+1;
if(baudrate_counter==10415)
begin
state<=next_state;// state changes from idle to transmitting
baudrate_counter<=0;//resetting counter

if(load)
shiftright_register<={1'b1, data, 1'b0};// the data is loaded into register

if(clear)
bit_counter<=0;
if(shift)
shiftright_register<=shiftright_register>>1;
bit_counter<=bit_counter+1;
end
end
end


// Mealy machine
always @(posedge clk)
begin
load<=0;
shift<=0;
clear<=0;
TxD<=1; //There is not transmission

case(state)
0:begin
if(transmit)
    begin
    next_state<=1; //it moves or switches to transmission state
    load<=1;// start laoding the bits
    shift<=0; // no shift at this point
    clear<=0; //to avoid any clearing of any counter
    end

else // if transmit buttor in  not pressed
    begin 
        next_state<=0;
        TxD<=1;// no transmission
    end

end

1: begin // transmitting state
if(bit_counter==10)
    begin 
    next_state<=0; // it should switch from transmission mode to idle mode
    clear<=1;
end
else begin
    next_state<=1;
    TxD<=shiftright_register[0];
    shift<=1;
end
end
default:
next_state<=0;
endcase
end




endmodule
