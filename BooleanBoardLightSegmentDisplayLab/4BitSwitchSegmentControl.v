//This verilog was programmed to a boolean board and allowed the 7-segment display to be
//programmed via the on-board switches. The four right-most switches were used
//to program a hex value onto the right most 7-segment led.

`timescale 1ns / 1ps

module lab6q2(
        
        //switches on board
        input [15:0] sw,
        output [7:0] D0_seg, D1_seg,
        output [3:0] D0_a, D1_a
        
);
    
    //Decoders which determine which lights are on
    //Entire lights are turned on when pulled low
    assign D0_a = 4'b1111;
    assign D1_a = 4'b1110;
    
    //Values of the light segments
    assign D0_seg = 8'b11111111;
    
    hexEncode en(sw[3:0], D1_seg);

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
    