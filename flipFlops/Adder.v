`timescale 1ns / 1ps

module Lab(

    //Input switches and buttons
    input [15:0] sw,
    input [3:0] btn,
    
    //Output leds and led-segments
    output [15:0] led,    
    output [3:0] D0_a, D1_a
);

//Holds data for button 0 and 1 inputs
reg [15:0] register0 = 16'b0;
reg [15:0] register1 = 16'b0;

//Register containing the sum of the two registers above
reg [15:0] sum;

//Updates register0 upon button 0 press
always @(posedge btn[0]) begin
    register0 <= {sw[15:0]};
end

//Updates register1 upon button 1 press
always @(posedge btn[1]) begin
    register1 <= {sw[15:0]};
end

always @(*) begin
    sum <= register0 + register1;
end

//Assigns led output to sum register data
assign led = sum;

//Turn off led-segments
assign D0_a = 4'b1111;
assign D1_a = 4'b1111;

endmodule


