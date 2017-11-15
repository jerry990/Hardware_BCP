`include "define.sv"
module traveral_engine(input CLK,
                       input RST,
					   input VALUE,
					   input [1:0]OFFSET,
                       input EN,
					   input [`ADDR_SIZE-1:0] BASE,
					   input [`DATA_SIZE-1:0] DATA_IN,
					   output logic [`DATA_SIZE-1:0] DATA_OUT,
                 //      output logic [`ADDR_SIZE-1:0] ADDR_OUT, 
                 //      output logic FINISH,
				//	   output logic CONFLICT
                   );

  parameter read_data = 3'b000;
  parameter assign_value = 3'b001; 
  parameter dummy = 3'b010;
  parameter bcp_check = 3'b011;
  parameter bcp_assign = 3'b100;
  logic [`DATA_SIZE-1:0] data_out_p;
  logic [2:0] cs;
  logic [2:0] ns;  
  always_ff@(posedge CLK) begin
    if(RST) 
	  cs <= read_data;
	else
	  cs <= ns;
  end
  
  always_comb begin
    case(cs)
	  read_data: begin
	    if(EN) begin
          if(DATA_IN[OFFSET+4]) begin
       	    if(DATA_IN[OFFSET] == VALUE)	
              FINISH = 1'b1;
		    else if(DATA_IN[OFFSET] != VALUE) 
		      CONFLICT = 1'b1;
		    else 
		     ;// CONFLICT = CONFLICT;
		  end
	      data_out_p = DATA_IN; 
          ns = assign_value;
        end		  
      end      
      assign_value: begin
	    data_out_p[OFFSET] = VALUE;
		data_out_p[OFFSET+4] = 1'b1;
	    ns = dummy;
      end
	  dummy: begin
	    DATA_OUT = data_out_p;
		ADDR_OUT = BASE + OFFSET;
		ns = bcp_check;	    
	  end
      bcp_check: begin
        ns = bcp_assign;
      end

      bcp_assign: begin
        ns = read_data;

      end
   
    endcase
  end
endmodule
