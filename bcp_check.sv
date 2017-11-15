module bcp_check(
                input clk,
				input rst,
                input [7:0] clause,
				input [7:0] clause_type,
				input [3:0] clause_odd,
				output logic [3:0] unit_clause
				);
	
  logic [3:0] temp_true;
  logic [3:0] total_true;
  logic [1:0] clause_size;
//	reg a,b,c,d,e,f,g,h;
  always_comb begin
    temp_true[0] = ~(clause_type[0] ^ clause [0]);
	temp_true[1] = ~(clause_type[1] ^ clause [2]);
	temp_true[2] = ~(clause_type[2] ^ clause [4]);
	temp_true[3] = ~(clause_type[3] ^ clause [6]);
	
	//assign	total_true[0] = temp_true[1] | temp_true[2] | temp_true[3];
	total_true[1] = temp_true[0] | temp_true[1] ;//clause_size==2
	total_true[2] = temp_true[0] | temp_true[1] | temp_true[2];//clause_size==3
	total_true[3] = temp_true[0] | temp_true[1] | temp_true[2] | temp_true[3];//clause_size==4
  end		 	 		
  always_ff@(posedge clk) begin	
    if(rst)
	  unit_clause <= 4'b0;
	else begin
	  unit_clause<=4'b0;
	  case(clause_type[7:6])
	    2'b11: begin
		  case(clause_odd)
		    4'b0111:
			  if(! total_true[3])
			    unit_clause[3]<=1'b1;
			  else
				unit_clause[3]<=1'b0;
		    4'b1011:
		      if(! total_true[3])
			    unit_clause[2]<=1'b1;
			  else
			    unit_clause[2]<=1'b0;	
		    4'b1101:
			  if(! total_true[3])
			    unit_clause[1]<=1'b1;
			  else
				unit_clause[1]<=1'b0;	
			4'b1110:	
			  if(! total_true[3])
				unit_clause[0]<=1'b1;
			  else
				unit_clause[0]<=1'b0;
			default:
				unit_clause<=4'b0;
		  endcase 
		end
		2'b10: begin
		  case(clause_odd[2:0])
		    3'b011:
		      if(! total_true[2])
			    unit_clause[2]<=1'b1;
			  else
				unit_clause[2]<=1'b0;	
			3'b101:
			  if(! total_true[2])
			    unit_clause[1]<=1'b1;
			  else
				unit_clause[1]<=1'b0;	
			3'b110:
			  if(! total_true[2])
				unit_clause[0]<=1'b1;
			  else
				unit_clause[0]<=1'b0;				
			default:
				unit_clause<=4'b0;
		  endcase 
		end
		2'b01: begin
		  case(clause_odd[1:0])
		    2'b01:
		      if(! total_true[1])
			    unit_clause[1]<=1'b1;
			  else
				unit_clause[1]<=1'b0;
			2'b10:
			  if(! total_true[1])
			    unit_clause[0]<=1'b1;
			  else
				unit_clause[0]<=1'b0;				
			  default:
				unit_clause<=4'b0;
		  endcase 
		end
		2'b00: begin
		  case(clause_odd[0])
		    1'b0: 
			  unit_clause[0]<=1'b1;			
			default:
			  unit_clause<=4'b0;
		  endcase 
	    end
	    default:
		  unit_clause<=4'b0;
	  endcase 
	end
  end	
endmodule		
		
