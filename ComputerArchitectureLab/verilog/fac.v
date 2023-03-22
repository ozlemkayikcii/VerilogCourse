module fac(
  input x, y, ci,
  output reg z, co
);
  always @ (*) begin
    z = x ^ y ^ ci;
    co = x&y | x&ci | y&ci;
  end
endmodule

module fac_tb;
  reg x, y, ci;
  wire z, co;
  
  fac inst1(.x(x), .y(y), .ci(ci), .z(z), .co(co));
  
  integer k;
  initial begin
    $display("time\tx\ty\tci\tco\tz");
    $monitor("%4t\t%b\t%b\t%b\t%b\t%b",$time,x, y, ci, co, z);
    {x, y, ci} = 0;
    for (k = 1; k < 8; k = k + 1)
      #10 {x, y, ci} = k;
    #10;
  end
endmodule