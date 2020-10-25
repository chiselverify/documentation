//top.sv
`include "Myclass.svh"
`include "Cover.svh"
module top;
  Myclass mc;
  Cover cov;
  initial begin;
    mc = new;
    cov = new;
    cov.mc = mc;
    for(int i=0; i<20; i++) begin
      mc.randomize();
      cov.sample();      
  	end
  end
endmodule