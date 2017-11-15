module t_top (
              input clk,
			  input rst,
			  input en,
			  input en1,
			  input r_w,
			  input [2:0] abus,
			  input [2:0] addr);
	logic value;
	 [31:0] dbus;
//	 wire [2:0] addr;
	bram mem (clk, rst, en, r_w, abus, dbus);
    traveral_engine uut (clk,assignment,rst,addr,finish,en1);
endmodule
