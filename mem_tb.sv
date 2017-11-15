`timescale 1ns/10ps
`define CYCLE 10
`include "mem.sv"
module mem_tb;
  logic clk;
  logic rst;
  logic read;
  logic write;
  logic [11:0] ADDR;
  logic [17:0] DIN;
  logic [17:0] DOUT;
  bram mem(.CLK(clk), 
		   .RST(rst), 
		   .BRAM_EN(en), 
		   .READ(read),
		   .WRITE(write),
		   .ADDR(ADDR),
		   .DIN(DIN),
		   .DOUT(DOUT)
		   );
  
  always #(`CYCLE/2) clk = ~clk;  
  
  initial begin
    clk = 0; rst = 1;
    #(`CYCLE) rst = 0;  
  
  end
  initial begin
    $fsdbDumpfile("mem.fsdb");
    $fsdbDumpvars(0, mem_tb);
    #1000000 $finish;
  end
endmodule