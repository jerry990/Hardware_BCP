module bcp_assign(
                 input CLK,
				 input RST,
                 input [3:0] UNIT_CLAUSE, 
				 input [3:0] CLAUSE_ODD,
				 output logic [11:0] ADDR,
				 output logic ASSSIGN
				 );
  logic [3:0] clause_pole; 
  logic [1:0] clause_size;
  always_ff@(posedge CLK) begin 
    if(RST)
	  ASSIGN <= 1'b0;
	else begin
      clause_pole[3:0] <= clause_type[3:0];
	  clause_size[1:0]<=clause_type[7:6];
	case(UNIT_CLAUSE)
	  4'b0001:
	    if(clause_pole[0])
		  assignment[0]<=1'b1;
		else
		  assignment[0]<=1'b0;
	  4'b0010:
	    if(clause_pole[1])
		  assignment[1]<=1'b1;						
		else
		  assignment[1]<=1'b0;
	  4'b0100:
		if(clause_pole[2])
		  assignment[2]<=1'b1;						
		else
		  assignment[2]<=1'b0;
	  4'b1000:
		if(clause_pole[3])
		  assignment[3]<=1'b1;						
		else
		  assignment[3]<=1'b0;
		default:
		  assignment<=4'b0;
	endcase
  end
end
endmodule


