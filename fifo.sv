//8x18 fifo
`define DATA_SIZE 18
module fifo(
            input clk,
			input rst,
			input read,
			input write,
			input en,
			input [`DATA_SIZE-1:0] fifo_in,
			output logic fifo_full,
			output logic fifo_empty,
			output logic [`DATA_SIZE-1:0] fifo_out
			);
  //logic [2:0] ptr;
  logic [2:0] read_ptr,write_ptr;
  logic [17:0] ram [7:0];//deepth 8 each has 8 bit 

  //logic [2:0] state, next;
  //logic [2:0] counter_write, counter_read;
  
 always_ff@(posedge clk) begin 
    if(rst) begin
      write_ptr <=3'b000;
	  read_ptr <= 3'b000;
	  fifo_full <= 1'b0;
      fifo_empty <= 1'b1;
	  fifo_out <= `DATA_SIZE'd0;
	end  
	else begin
      if(en) begin 
        if(write) begin
          ram[write_ptr] <= fifo_in;
          write_ptr <= write_ptr + 1;
        end
        else if(read) begin
          fifo_out <= ram[read_ptr];
          read_ptr <= read_ptr + 1;
        end		
        else
		  fifo_out <= fifo_out;
      end
      else 
          fifo_out <= fifo_out;	  
    end
  end
endmodule