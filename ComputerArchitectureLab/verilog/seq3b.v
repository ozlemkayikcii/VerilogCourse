module seq3b (
	input [3:0] i,
	output o
);
	//write Verilog code here
endmodule

module seq3b_tb;
	reg [3:0] i;
	wire o;

	seq3b seq3b_i (.i(i), .o(o));

	integer k;
	initial begin
		$display("Time\ti\to");
		$monitor("%0t\t%b\t%b", $time, i, o);
		i = 0;
		for (k = 1; k < 16; k = k + 1)
			#10 i = k;
	end
endmodule