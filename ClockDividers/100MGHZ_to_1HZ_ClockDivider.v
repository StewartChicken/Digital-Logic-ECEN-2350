`timescale 1ns / 1ps

module Lab(

    //Output leds and led-segments
    input mclk,
    output [15:0] led,    
    output [3:0] D0_a, D1_a
);

reg [26:0] count = 16'b0; //Counts to 2^16 (65536) - starts at 0
reg [15:0] ledReg;

always @(posedge(mclk)) begin
    if(count == 50000000) begin
        count <= 0;
        ledReg[0] = !ledReg[0];
    end else begin
        count <= count + 1;
    end
end

assign led = ledReg;

//Turn off led-segments
assign D0_a = 4'b1111;
assign D1_a = 4'b1111;

endmodule


    


