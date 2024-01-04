module testbench;
    reg C, D;
    wire Q, Qn;

    ff dut(.clock(C), .data(D), .q(Q), .qn(Qn));

    always #10 C = ~C;

    initial begin
        $monitor("%6d: C=%b, D=%b, Q=%b, Qn=%b", $time, C, D, Q, Qn);
        $dumpfile("dump.vcd"); 
        $dumpvars;
        C = 0;
        D = 0;
        #20 D = 1;
        #4  D = 0;
        #2  D = 1;
        #9  D = 0;
        #25 $finish;
    end
endmodule

module ff(input clock, data, output q, qn);
  
  //Nand gate outputs - q and qn are the outputs of 5 and 6
  wire n1out, n2out, n3out, n4out;
  
  //Nand gate assignments
  nand #1 n1(n1out, n2out, n4out);
  nand #1 n2(n2out, clock, n1out);
  nand #1 n3(n3out, clock, n2out, n4out);
  nand #1 n4(n4out, data, n3out);
  nand #1 n5(q, qn, n2out);
  nand #1 n6(qn, n3out, q);
  
endmodule

