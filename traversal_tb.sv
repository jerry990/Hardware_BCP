`timescale 1ns/10ps
`define CYCLE 10
`include "top.sv"
module traversal_tb;
  
  logic VALUE;
  logic [1:0] OFFSET;
  logic EN;
  logic [17:0] DATA_IN;
  logic [17:0] DATA_OUT;
  logic [11:0] ADDR; 
  logic FINISH;
  logic CONFLICT;
					   
  //logic [17:0]DATA_IN;
  logic CLK;
  logic RST;
  always #(`CYCLE/2) CLK = ~CLK;
  
  traveral_engine te(CLK,
                     VALUE,
					 OFFSET,
                     RST,
					 EN,
					 DATA_IN,
					 DATA_OUT,
                     ADDR, 
                     FINISH,
					 CONFLICT
					   //output logic CONFLICT
                       );
  initial begin
    CLK = 0; RST = 1;
    #(`CYCLE) RST = 0;
    DATA_IN = 18'd0;
	EN = 1'b1;
	VALUE = 1'b1;
	OFFSET = 2'd1;
	
	#(`CYCLE) DATA_IN = 18'd10;
    EN = 1'b0;
	#(`CYCLE) DATA_IN = 18'd30;
	EN = 1'b1;
	#(`CYCLE) DATA_IN = 18'd50;
    EN = 1'b0;
	#(`CYCLE) DATA_IN = 18'h20;
	EN = 1'b1;
	
	
    
  end	
  initial begin
    $fsdbDumpfile("tra.fsdb");
    $fsdbDumpvars(0, traversal_tb);
    #1000000 $finish;
  end	
	
	
	
endmodule