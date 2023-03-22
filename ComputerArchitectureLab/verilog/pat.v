module pat(
  input clk, rst_b, i,
  output reg o
);
  localparam S0 = 0;
  localparam S1 = 1;
  localparam S2 = 2;
  localparam S3 = 3;
  localparam S4 = 4;
  localparam S5 = 5;
 
  reg [2:0] st, st_nxt;
  
  always @ (*)
    case (st)
      S0: if (i == 1) st_nxt = S1;
          else st_nxt = S0;
      S1: if (i == 1) st_nxt = S2;
          else st_nxt = S0;
      S2: if (i == 0) st_nxt = S3;
          else st_nxt = S2;
      S3: if (i == 1) st_nxt = S4;
          else st_nxt = S0;
      S4: if (i == 1) st_nxt = S5;
          else st_nxt = S0;
      S5: if (i == 1) st_nxt = S2;
          else st_nxt = S3;
    endcase
  always @ (*)
    o = (st == S5);
  always @ (posedge clk, negedge rst_b)
    if (rst_b == 0) st <= S0;
    else st <= st_nxt;
endmodule

module pat_tb;
  reg clk, rst_b, i;
  wire o;
  
  pat inst1(.clk(clk),.rst_b(rst_b),.i(i),.o(o));
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