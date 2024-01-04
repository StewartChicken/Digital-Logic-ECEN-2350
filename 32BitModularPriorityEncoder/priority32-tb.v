// Code your testbench here
// or browse Examples
// This is a buggy 8-input priority encoder
//Testbench for decoder4
module test;
  wire [31:0] in; //8-bit input
  wire [5:0] out; //3-bit output
  
  wire valid;
  
  //If output is buggy, this is assigned a value of 1
  integer buggy;
  
  //Creates empty integer i? (00000000)
  integer i; 
  
  integer j;
  integer seed = 88;
  
  //Assigns input to an 8 bit integer number called 'i' which will be iterated through later
  assign in = i[31:0]; 
  
  priorityEncoder32 en(in, out, valid);
  
  initial begin

    //Displays all outputs
    $monitor("in=%b, out=%b, valid=%b", in, out, valid);
    
    for(j = 0; j < 10; j =  j + 1)begin
      i = {$random(seed)} %4294967296;
      #1;
    end
    
    $finish;  
  end
endmodule