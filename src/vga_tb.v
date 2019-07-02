`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Elano Rolim
// 
// Create Date: 06/28/2019 07:03:48 PM
// Design Name: 
// Module Name: princ_tb
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


module vga_tb(

    );
    
    reg clk = 0, rst = 0;
   wire VGA_H_SYNC = 0,VGA_V_SYNC = 0;
   wire [3:0] VGA_R = 0,VGA_G = 0,VGA_B = 0;
   
   princ t (
    .clk(clk),
    .rst(rst),
    .VGA_H_SYNC(VGA_H_SYNC),
    .VGA_V_SYNC(VGA_V_SYNC),
    .VGA_R(VGA_R),
    .VGA_G(VGA_G),
    .VGA_B(VGA_B)
   );
   
   initial
   begin   
        forever #10 clk = ~clk;
   end
endmodule
