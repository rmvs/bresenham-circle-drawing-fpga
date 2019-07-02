`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Elano Rolim
// 
// Create Date: 06/28/2019 06:40:14 PM
// Design Name: 
// Module Name: driver2
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


module driver2(

      input wire clk_i,
      input wire rst_i,
      input wire pixel,
      
      output wire hsync,
      output wire vsync,
      output wire[10:0] x,
      output wire[10:0] y

    );
    
    reg [10:0] hcounter;
    reg [10:0] vcounter;
    /*
    assign hsync = ~(hcounter > 640 + 16 & hcounter < 640 + 16 + 96);
    assign vsync = ~((vcounter > 480 + 11) & vcounter < 480 + 11 + 2);
    
    assign x = hcounter <= 640 ? hcounter : 640;
    assign y = vcounter <= 480 ? vcounter : 480;*/
    
    assign hsync = (hcounter > 800 + 40 & hcounter < 800 + 40 + 128);
    assign vsync = ((vcounter > 600 + 1) & vcounter < 600 + 1 + 4);
    
    assign x = hcounter <= 800 ? hcounter : 800;
    assign y = vcounter <= 600 ? vcounter : 600;
    
    initial
    begin
        hcounter = 0;
        vcounter = 0;        
    end
    always @(posedge pixel)
    begin
        /*if(pixel)
        begin*/
            if(hcounter == /*800*/1056)
            begin
                hcounter = 0;
                vcounter = vcounter + 1;
            end
            else
            begin
                hcounter = hcounter + 1;
            end
        
            if (vcounter == /*525*/628)
            begin
                vcounter = 0;
            end
       // end
    end
    
    
endmodule
