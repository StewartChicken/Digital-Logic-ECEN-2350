`timescale 1ns / 1ps

module Lab(

    //Input switches and buttons
    input [15:0] sw,
    input [3:0] btn,
    
    //Output leds and led-segments
    output [15:0] led,    
    output [3:0] D0_a, D1_a
);

//Shift register to hold data
reg [15:0] shiftRegister;

//Updates shift register upon button press
always @(posedge btn[0]) begin
    shiftRegister <= {sw[15], shiftRegister[15:1]};
end

//Assigns led output to shiftRegister data
assign led = shiftRegister;

//Turn off led-segments
assign D0_a = 4'b1111;
assign D1_a = 4'b1111;

endmodule


