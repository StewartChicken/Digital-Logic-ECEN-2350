//This verilog program will allow the Boolean Board to take a 16 bit input
//from the built in switches and convert it to a hex value which will
//be displayed on the boards 7-segment displays. The particular segment 
//that the board will display the hex value on is determined by which of the 
//boards four buttons is currently being pressed. 

`timescale 1ns / 1ps

module lab6q3(
        
        //switches on board
        input [15:0] sw,
        
        //buttons on board
        input [3:0] btn,
        
        output [7:0] D0_seg, D1_seg,
        output [3:0] D0_a, D1_a
        
);
    
    //Will hold the 4 differnt hex values
    wire [7:0] seg1;
    wire [7:0] seg2;
    wire [7:0] seg3;
    wire [7:0] seg4;
    
    //Turn off left display
    assign D0_a = 4'b1111;
    assign D0_seg = 8'b11111111;
    
    //determines which LED Segment is on
    assign D1_a = btn[3]? 4'b0111 : btn[2]? 4'b1011 : btn[1]? 4'b1101 : 4'b1110;
    
    hexEncode en3(sw[3:0], seg1); //Least significant
    hexEncode en2(sw[7:4], seg2);
    hexEncode en1(sw[11:8], seg3);
    hexEncode en0(sw[15:12], seg4); //Most significant
    
    assign D1_seg = btn[3]? seg4: btn[2]? seg3 : btn[1]? seg2 : btn[0]? seg1 : 16'hFF;
    

 endmodule
    
module hexEncode(input [3:0] bin, output [7:0] hex);
  
  assign hex = (bin==4'b0000)? 8'hC0 : (bin==4'b0001)? 8'hF9 : //0, 1
    (bin==4'b0010)? 8'hA4 : (bin==4'b0011)? 8'hB0 : //2, 3
    (bin==4'b0100)? 8'h99 : (bin==4'b0101)? 8'h92 : //4, 5
    (bin==4'b0110)? 8'h82 : (bin==4'b0111)? 8'hF8 : //6, 7
    (bin==4'b1000)? 8'h80 : (bin==4'b1001)? 8'h98 : //8, 9
    (bin==4'b1010)? 8'h88 : (bin==4'b1011)? 8'h83 : //A, B
    (bin==4'b1100)? 8'hC6 : (bin==4'b1101)? 8'hA1 : //C, D
    (bin==4'b1110)? 8'h86 : 8'h8E; //E, F
    
  
endmodule
    