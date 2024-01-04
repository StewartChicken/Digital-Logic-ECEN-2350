// This is a buggy 8-input priority encoder
module priorityEncoder8(input [7:0]in, output [2:0] out, output valid);
  assign out = in[7] ? 3'b111 : in[6] ? 3'b110 : in[5] ? 3'b101 : in[4] ? 3'b100 : 
    in[3] ? 3'b011 : in[2] ? 3'b010 : in[1] ? 3'b001 : in[0] ? 3'b000 : 3'b000;
  assign valid = |in;
endmodule

//16 bit encoder which uses 8 bit encoders
module priorityEncoder16(input [15:0] in, output [3:0] out, output valid);
  
  //Outputs for both the most and least significant halves
  wire[2:0] mostSignificantOut;
  wire[2:0] leastSignificantOut;
  
  wire MSValidity; //valid wire of most significant half
  wire LSValidity; //valid wire of least significant half
  
  //Creates 8 bit priority encoder to encode the most significant half
  //of the 16 bit input. The three bit output is assigned to mostSignificantOut and 
  //the validity is assigned to MSValidity
  priorityEncoder8 mostSignificantHalf(in[15:8], mostSignificantOut, MSValidity);
  
  //8 bit priority encoder to encode least significant half of 
  //16 bit input. The three bit output is assigned to leastSignificantOut and
  //the validity is assigned to LSValidity
  priorityEncoder8 leastSignificantHalf(in[7:0], leastSignificantOut, LSValidity);
  
  
  assign valid = MSValidity | LSValidity;
  
  //If tempOut1 is 000 it means the input was either 00000001 or 00000000. If it is valid, it means
  //the input was the former. If it isn't valid, it was the latter. 
  assign out = (!(|mostSignificantOut))? (MSValidity? 4'b1000 : 4'b0000 + leastSignificantOut) : 
    4'b1000 + mostSignificantOut;
  
endmodule
  
module priorityEncoder32(input [31:0] in, output[4:0] out, output valid);
  
  wire[3:0] mostSignificantOut;
  wire[3:0] leastSignificantOut;
  
  wire MSValidity;
  wire LSValidity;
  
  priorityEncoder16 mostSignificantHalf(in[31:16], mostSignificantOut, MSValidity);
  
  priorityEncoder16 leastSignificantHalf(in[15:0], leastSignificantOut, LSValidity);
  
  assign valid = MSValidity | LSValidity;
  
  assign out = (!(|mostSignificantOut))? (MSValidity? 5'b10000 : 5'b00000 + leastSignificantOut) :
    5'b10000 + mostSignificantOut;
endmodule