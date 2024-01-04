//Encodes 4 bit input into respective 8 bit output which will display a certain Hex value
//on an 8 bit 7-segment led display


//0 is 11000000 
//1 is 11111001

//2 is 10100100
//3 is 10110000

//4 is 10011001
//5 is 10010010

//6 is 10000010
//7 is 11111000

//8 is 10000000
//9 is 10011000

//A is 10001000
//B is 10000011

//C is 11000110
//D is 10100001

//E is 10000110
//F is 10001110

//Tested this module with the provided test bench. I believe there is a mistake with the test bench
//for the '9' case. I can't find a mistake with my binary output and the bench continues to give me an error
//for the number 9
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