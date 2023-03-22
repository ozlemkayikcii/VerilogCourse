module pat_sh(
  input clk, rst_b, i,
  output o
);
  reg [4:0] q;
  
  always @ (posedge clk, negedge rst_b)
    if (rst_b == 0) q <= 0;
    else q <= {q[3:0], i};
      
  assign o = (q == 5'b11011);
endmodule

module pat_sh_tb;
  reg clk, rst_b, i;
  wire o;
  
  pat_sh inst1(.clk(clk),.rst_b(rst_b),.i(i),.o(o));
  localparam CLK_PERIOD=100;
  localparam RUNNING_CYCLES=11;
  initial begin
    clk=0;
    repeat (2*RUNNING_CYCLES) #(CLK_PERIOD/2) clk=~clk;
  end
  localparam RST_DURATION=10;
  initial begin
    rst_b=0;
    #RST_DURATION rst_b=1;
  end
  initial begin
    i=1;
    #(1*CLK_PERIOD) i=~i;//0
    #(1*CLK_PERIOD) i=~i;//1
    #(2*CLK_PERIOD) i=~i;//0
    #(1*CLK_PERIOD) i=~i;//1
    #(2*CLK_PERIOD) i=~i;//0
    #(1*CLK_PERIOD) i=~i;//1
    #(2*CLK_PERIOD) i=~i;//0
    #(1*CLK_PERIOD) i=~i;//1
  end
endmodule