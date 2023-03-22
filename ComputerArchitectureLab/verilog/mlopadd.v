module mlopadd(
  input clk,rst_b,
  input [7:0] x,
  output [14:0] a
);
  wire [7:0] xb;
  rgst #(.w(8)) inst1(.clk(clk),.rst_b(rst_b),.clr(1'd0),
    .ld(1'd1),.d(x),.q(xb));
  rgst #(.w(15)) inst2(.clk(clk),.rst_b(rst_b),.clr(1'd0),
    .ld(1'd1),.d(a+xb),.q(a));
endmodule

module mlopadd_tb;
  reg clk,rst_b;
  reg [7:0] x;
  wire [14:0] a;
  
  mlopadd inst1(.clk(clk),.rst_b(rst_b),.x(x),.a(a));
  localparam CLK_PERIOD=100, RUNNING_CYCLES=201, RST_DURATION=25;
  initial begin
    $display("time\t\tclk\trst_b\tx\ta");
    $monitor("%6t\t%b\t%b\t%3d\t%5d",$time,clk,rst_b,x,a);
    clk=0;
    repeat (2*RUNNING_CYCLES) #(CLK_PERIOD/2) clk=~clk;
  end
  initial begin
    rst_b=0;
    #RST_DURATION rst_b=~rst_b;
  end
  integer k;
  initial begin
    x=1;
    for(k=2; k<201; k=k+1)
      #CLK_PERIOD x=k;
  end
endmodule