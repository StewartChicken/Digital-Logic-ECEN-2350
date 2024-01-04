`timescale 1ns / 1ps

module Lab11(
     
    //Output leds and led-segments
    input mclk,
    input [3:0] btn,
    output [7:0] D1_seg,
    output [3:0] D0_a, D1_a
);

reg [16:0] count = 16'b0; //Counts to 2^16 (65536) - starts at 0

reg [1:0] state = 2'b0; //Current state (which segment should be on)
reg [3:0] activeSegment = 4'b0; //Assign D0_a to this wire

reg pause;

wire [7:0] led_seg1;
wire [7:0] led_seg2;
wire [7:0] led_seg3;
wire [7:0] led_seg4;

//The integer values displayed by the light segments
reg [3:0] value1 = 4'b0001;
reg [3:0] value2 = 4'b0010;
reg [3:0] value3 = 4'b0011;
reg [3:0] value4 = 4'b0100;

reg [7:0] seg_reg = 8'b0;

always @(posedge(mclk)) begin

    if(btn[0] == 1) begin
        value4 <= 4'b0;
        value3 <= 4'b0;
        value2 <= 4'b0;
        value1 <= 4'b0;
    end
    
    if(count == 100000) begin
        count <= 0;
        
        //Assign active segment depending on which state the state reg is in (MUX)
        activeSegment <= (state == 2'b00) ? 4'b1110 : (state == 2'b01) ? 4'b1101 : (state == 2'b10) ?
        4'b1011 : 4'b0111; 
        
        //Assign segment register to different led_seg values depending on the state
        seg_reg <= (state == 2'b00) ? {led_seg1} : (state == 2'b01) ? {led_seg2} : (state == 2'b10) ?
        {led_seg3} : {led_seg4};
        
        if(!pause) begin
            if(value4 == 4'b1010) begin
                value4 <= 4'b0;
                value3 <= value3 + 1;
            end else begin
                value4 = value4 + 1;
            end
            
            if(value3 == 4'b1010) begin
                value3 <= 4'b0;
                value2 <= value2 + 1;
            end
            
            if(value2 == 4'b1010) begin
                value2 <= 4'b0;
                value1 <= value1 + 1;
            end
         
            if(value1 == 4'b1010) begin
                value1 <= 4'b0;
            end
        end
           
        state <= state + 1;
        
    end else begin
        count <= count + 1;
    end
end

always @ (posedge btn[1]) begin
    pause <= !pause;
end

//Which segment is active
assign D1_a = activeSegment;

//Encodes all the segment values based on the switches
hexEncodeDecimal en1(value1, led_seg4);
hexEncode en2(value2, led_seg3);
hexEncode en3(value3, led_seg2);
hexEncode en4(value4, led_seg1);
  
//Assign LED Seg value to seg_reg
assign D1_seg = seg_reg;

//Turn off unused led-segment
assign D0_a = 4'b1111;

endmodule

module hexEncode(input [3:0] bin, output [7:0] hex);
  
  //Ternary operator which assigns output
  assign hex = (bin==4'b0000)? 8'hC0 : (bin==4'b0001)? 8'hF9 : //0, 1
    
    (bin==4'b0010)? 8'hA4 : (bin==4'b0011)? 8'hB0 : //2, 3
    
    (bin==4'b0100)? 8'h99 : (bin==4'b0101)? 8'h92 : //4, 5
    
    (bin==4'b0110)? 8'h82 : (bin==4'b0111)? 8'hF8 : //6, 7
    
    (bin==4'b1000)? 8'h80 : (bin==4'b1001)? 8'h98 : //8, 9
    
    (bin==4'b1010)? 8'h88 : (bin==4'b1011)? 8'h83 : //A, B
    
    (bin==4'b1100)? 8'hC6 : (bin==4'b1101)? 8'hA1 : //C, D
    
    (bin==4'b1110)? 8'h86 : 8'h8E; //E, F
    
  
endmodule

module hexEncodeDecimal(input [3:0] bin, output [7:0] hex);
  
  //Ternary operator which assigns output
  assign hex = (bin==4'b0000)? 8'h40 : (bin==4'b0001)? 8'h79 : //0, 1
    
    (bin==4'b0010)? 8'h24 : (bin==4'b0011)? 8'h30 : //2, 3
    
    (bin==4'b0100)? 8'h19 : (bin==4'b0101)? 8'h12 : //4, 5
    
    (bin==4'b0110)? 8'h02 : (bin==4'b0111)? 8'h78 : //6, 7
    
    (bin==4'b1000)? 8'h00 : (bin==4'b1001)? 8'h18 : //8, 9
    
    (bin==4'b1010)? 8'h88 : (bin==4'b1011)? 8'h83 : //A, B
    
    (bin==4'b1100)? 8'hC6 : (bin==4'b1101)? 8'hA1 : //C, D
    
    (bin==4'b1110)? 8'h86 : 8'h8E; //E, F
    
  
endmodule


