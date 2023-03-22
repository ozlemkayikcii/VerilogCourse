module div3 (
	input [3:0] i,
	output [2:0] o
);
	//write Verilog code here
endmodule

module div3_tb;
	reg [3:0] i;
	wire [2:0] o;

	div3 div3_i (.i(i), .o(o));

	integer k;
	initial begin
		$display("Time\ti\to");
		$monitor("%0t\t%b\t%b", $time, i, o);
		i = 0;
		for (k = 1; k < 16; k = k + 1)
			#10 i = k;
	end
endmodule