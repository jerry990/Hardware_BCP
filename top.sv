//`include "fifo.sv"
`include "traversal.sv"
`include "bcp_check.sv"
//`include "bcp_assign.sv"
module top(
        input CLK,
		input RST,
		input [17:0]DATA_IN,
		output logic [17:0] DATA_OUT,
		output logic [3:0] UNIT_CLAUSE
          );
  //logic [7:0] CLAUSE;
  //logic [3:0] CLAUSE_TYPE;
  //logic [3:0] CLAUSE_ODD;
 // logic [3:0] UNIT_CLAUSE;
  
  logic VALUE;
  logic [1:0] OFFSET;
  logic EN;
  //logic [17:0] DATA_IN;
 // logic [17:0] DATA_OUT;
  logic [11:0] ADDR_OUT;
  logic [11:0] ADDR_IN;  
  logic FINISH;
  logic CONFLICT;
  //logic [3:0] UNIT_CLAUSE;
  
  bcp_check bc (CLK,
				RST,
                DATA_OUT[7:0],
		        DATA_OUT[11:8],
				DATA_OUT[3:0],
				UNIT_CLAUSE
				);
  traveral_engine te(.CLK(CLK),
                     .VALUE(VALUE),
					 .OFFSET(OFFSET),
                     .RST(RST),
					 .EN(EN),
					 .DATA_IN(DATA_IN),
					 .DATA_OUT(DATA_OUT),
                     .ADDR_IN(ADDR_IN), 
					 .ADDR_OUT(ADDR_OUT),
                     .FINISH(FINISH),
					 .CONFLICT(CONFLICT)
					   //output logic CONFLICT
                   );
  //fifo in ();
  //fifo out ()
endmodule