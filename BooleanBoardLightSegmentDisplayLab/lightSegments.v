`timescale 1ns / 1ps

    module project1_demo(
        //Clock input
        input mclk,
        
        //switches on board
        input [15:0] sw,
        output [7:0] D0_seg, D1_seg,
        output [3:0] D0_a, D1_a
    );

    reg [28:0] cnt29 = 29'd0; //29 bit decimal number?
    
    //8'h00 is all light segments on
    //8'hFF is all light segments off
    //8'hFE is just the top
    
    /*
        8 bits gives 256 possible combinations
    */
    reg [7:0] seg_reg;
    

    //Increments cnt29 at the positive edge of the clock (posedge) 
    always @(posedge mclk) begin
        //cnt29 increases by 1 whenever mclk changes from 0 to 1
        cnt29 <= cnt29 + 1;
    end
    
    //Whenever cnt29 increases? Not sure how cnt29's positive edge is determined bc its not changing from 0 to 1
    always @(posedge cnt29[24])
    begin
    
        //if the most significant 4 bits of the cnt29 reg is 0000, assign seg_reg to an 8-bit hex number (this looks like a reset)
        /*if (cnt29[28:25] == 4'b0) begin
            seg_reg <= 8'hFA; //Was 8'hFE originally
        end
        else begin
            //If the (reset?) case is not met, sets the first 7 bits of the segment 
            //register to the value of the 7th bit of seg_reg
            seg_reg <= {seg_reg[6:0], seg_reg[7]};
        end*/
        
        if (cnt29[28:25] == 4'b0) begin
            seg_reg <= 8'hFE;
        end 
        else begin
            seg_reg <= 8'h00;
        end
    end
    
    //Decoders which determine which lights are on
    //Entire lights are turned on when pulled low
    assign D0_a = 4'b0010;
    assign D1_a = 4'b0000;
    
    //Values of the light segments
    assign D0_seg = seg_reg;
    assign D1_seg = seg_reg;

    endmodule
