module add4b (
  input [3:0] x, y,
  input ci,
  output [3:0] z,
  output co
);
  wire c1, c2, c3;
  fac inst1 (.x(x[0]), .y(y[0]), .ci(ci), .z(z[0]), .co(c1));
  fac inst2 (.x(x[1]), .y(y[1]), .ci(c1), .z(z[1]), .co(c2));
  fac inst3 (.x(x[2]), .y(y[2]), .ci(c2), .z(z[2]), .co(c3));
  fac inst4 (.x(x[3]), .y(y[3]), .ci(c3), .z(z[3]), .co(co));
endmodule

module add4b_tb;
  reg [3:0] x, y;
  reg ci;
  wire [3:0] z;
  wire co;
  
  add4b inst1 (.x(x), .y(y), .ci(ci), .z(z), .co(co));
  
  integer k;
  initial begin
    $display("time\tx\ty\tci\tco\tz");
    $monitor("%4t\t%4b\t%4b\t%b\t%b\t%4b", $time,x,y,ci,co,z);
    {x, y, ci} = 0;
    for (k = 1; k < 512; k = k + 1)
      #20 {x, y, ci} = k;
    #20;
  end
endmodule