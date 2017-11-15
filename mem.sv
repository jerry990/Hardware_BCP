`define Dbus 18
`define Abus 12

module bram(
           input CLK, 
		   input RST, 
		   input BRAM_EN, 
		   input READ,
		   input WRITE,
		   input [`Abus-1:0] ADDR,
		   input [`Dbus-1:0] DIN,
		   output logic[`Dbus-1:0] DOUT
		   );
  logic [`Dbus-1:0] mem_data[4095:0];
  
  always_comb begin
    if(READ & BRAM_EN)
	  DOUT = mem_data[ADDR];
	else 
	  DOUT = `Dbus'd0;
  end
  
  always_ff @(posedge CLK) begin
    if (RST) begin
      for(int i=0;i<4096;i++)
        mem_data [i] <= `Dbus'd0; 	  
    end
    else if(BRAM_EN) begin // r_w==0:write
      if(WRITE)
	    mem_data[ADDR] <= DIN;
      else 
	    mem_data[ADDR] <= mem_data[ADDR];
    end
  end
endmodule
