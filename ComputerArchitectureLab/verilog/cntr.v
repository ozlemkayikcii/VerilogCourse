module cntr #(parameter w=8)(
  input clk, rst_b, c_up, clr,
  output reg [w-1:0] q
);
  always @ (posedge clk, negedge rst_b) begin
    if (rst_b == 0) q <= 0;
    else if (c_up == 1) q <= q+1;
    else if (clr == 1) q <= 0;
  end
endmodule

module cntr_tb; //w = 3
  reg clk, rst_b, c_up, clr;
  wire [2:0] q;
  
  cntr #(.w(3)) inst1(.clk(clk), .rst_b(rst_b), .c_up(c_up), .clr(clr), .q(q));
  localparam CLK_PERIOD = 200;
  localparam RUNNING_CYCLES = 11;
  initial begin
    $display("time\tclk\trst_b\tc_up\tclr\tq");
    $monitor("%4t\t%b\t%b\t%b\t%b\t%b",$time,clk,rst_b,c_up,clr,q);
    clk = 0;
    repeat (2*RUNNING_CYCLES) #(CLK_PERIOD/2) clk=~clk;
  end
  localparam RST_DURATION = 50;
  initial begin
    rst_b = 0;
    #RST_DURATION rst_b = 1;
  end
  initial begin
    c_up = 1;
    #400 c_up = 0;
    #400 c_up = 1;
  end
  initial begin
    clr = 0;
    #600 clr = 1;
    #400 clr = 0;
  end
endmodule