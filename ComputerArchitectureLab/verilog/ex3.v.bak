module ex3 (
	input [3:0] i,
	output [3:0] o
);
	//write Verilog code here
endmodule

module ex3_tb;
	reg [3:0] i;
	wire [3:0] o;

	ex3 ex3_i (.i(i), .o(o));

	integer k;
	initial begin
		$display("Time\ti\to");
		$monitor("%0t\t%b\t%b", $time, i, o);
		i = 0;
		for (k = 1; k < 10; k = k + 1)
			#10 i = k;
	end
endmodule