module msd (
	input [3:0] i,
	output [3:0] o
);
	//write Verilog code here
endmodule

module msd_tb;
	reg [3:0] i;
	wire [3:0] o;

	msd msd_i (.i(i), .o(o));

	integer k;
	initial begin
		$display("Time\ti\to");
		$monitor("%0t\t%b\t%b", $time, i, o);
		i = 0;
		for (k = 1; k < 16; k = k + 1)
			#10 i = k;
	end
endmodule