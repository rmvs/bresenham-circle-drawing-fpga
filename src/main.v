`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Elano Rolim
// 
// Create Date: 06/23/2019 11:45:13 AM
// Design Name: 
// Module Name: main
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


module main(

    input wire clk,
    input wire rst,
    output wire VGA_H_SYNC,
    output wire VGA_V_SYNC,
    output wire [3:0] VGA_R,
    output wire [3:0] VGA_G,   
    output wire [3:0] VGA_B     

    );
    
    
    reg [15:0] cnt = 0;
    reg pix_stb = 0; 
    always @(posedge clk)
        {pix_stb, cnt} <= cnt + 16'h6666;
    
    
    wire [10:0] x;
    wire [10:0] y;    
    
    driver2 vga (
    .clk_i(clk),
    .rst_i(rst),
    .pixel(pix_stb),
    .hsync(VGA_H_SYNC),
    .vsync(VGA_V_SYNC),
    .x(x),
    .y(y)
    ); 
    
    
    reg linha;
    
    reg [9:0] x0;
    reg [9:0] y0;
    reg [9:0] r = 100;
    reg signed [9:0] d = 0;
    reg [9:0] x_center = 400;
    reg [9:0] y_center = 300;
      
    
    reg [19:0] points [699:0];   
    
    reg break;    
    
    
    initial
    begin
        y0 = r;
        x0 = 0;
        d = 3 - 2 * r;
        
        points[y_center + y0] = {x_center + x0,x_center - x0};
        points[y_center - y0] = {x_center + x0,x_center - x0};  
        points[y_center + x0] = {x_center + y0,x_center - y0};         
        points[y_center - x0] = {x_center + y0,x_center - y0};
        /*
        points[y_center + y0][19:10] = x_center + x0;
        points[y_center + y0][9:0] = x_center - x0; 
        points[y_center - y0][19:10] = x_center + x0;
        points[y_center - y0][9:0] = x_center - x0; 
        
        points[y_center + x0][19:10] = x_center + y0;
        points[y_center + x0][9:0] = x_center - y0;
        points[y_center - x0][19:10] = x_center + y0;
        points[y_center - x0][9:0] = x_center - y0;
        */
        
         
        while(y0 >= x0)
        begin
            x0 = x0 + 1;
            if(d > 0)
            begin
                y0 = y0 - 1;
                d = d + 4 * (x0 - y0) + 10;
            end
            else
            begin
                d = d + 4 * x0 + 6;
            end
            /*        
            points[y_center + y0][19:10] = x_center + x0;
            points[y_center + y0][9:0] = x_center - x0; 
            points[y_center - y0][19:10] = x_center + x0;
            points[y_center - y0][9:0] = x_center - x0; 
        
            points[y_center + x0][19:10] = x_center + y0;
            points[y_center + x0][9:0] = x_center - y0;
            points[y_center - x0][19:10] = x_center + y0;
            points[y_center - x0][9:0] = x_center - y0;*/       
            
            points[y_center + y0] = {x_center + x0,x_center - x0};
            points[y_center - y0] = {x_center + x0,x_center - x0};  
            points[y_center + x0] = {x_center + y0,x_center - y0}; 
            points[y_center - x0] = {x_center + y0,x_center - y0};
        end
    end
   
    
    reg hor,ver;  
    reg[10:0] a,b;
    initial
    begin
        hor = 0;
        ver = 0;
    end
    always @(posedge clk)
    begin
        if(y0 < x0)
        begin      
          
        
           ver = y >= (y_center - r) & y <= (y_center + r);                      
           linha = ver &  x >= points[y][9:0] & x <= points[y][19:10];                      
                   
        end        
    end
    
    
    
    
    
    assign VGA_R[3] = linha;
    assign VGA_R[2] = linha;
    assign VGA_R[1] = linha;    
    assign VGA_R[0] = linha;
    /*assign VGA_G[3] = linha;
    assign VGA_G[2] = linha;
    assign VGA_G[1] = linha;
    assign VGA_G[0] = linha;*/
    assign VGA_B[3] = linha;
    assign VGA_B[2] = linha;
    assign VGA_B[1] = linha;
    assign VGA_B[0] = linha;
    
    
 /* Midpoint circle commented
 initial
    begin
        x0 = r;
        y0 = 0;
        d = 1 - r;
        break = 0;
        if(r > 0)
        begin
            points[y_center + x0] = {x_center + y0,-y0 + x_center};          
        end
        while(x0 > y0 & ~break)
        begin
         y0 = y0 + 1;
         if(d <= 0)
         begin
            d = d + 2 * y0 + 1;
         end
         else
         begin
            x0 = x0 - 1;
            d = d + 2 * y0 - 2 * x0 + 1;
         end
         if(x0 < y0) 
         begin
            points[y_center] = {x_center + r,x_center - r};
            break = 1;
         end
         if(~break)
         begin
            points[y_center + y0] = {x_center + x0,-x0 + x_center};
            points[-y0 + y_center] = {x_center + x0,-x0 + x_center};
            if(x0 != y0)
            begin
                points[y_center + x0] = {x_center + y0,-y0 + x_center}; 
                points[-x0 + y_center] = {x_center + y0,-y0 + x_center};                     
            end 
         end
        end        
    end*/
    
endmodule
