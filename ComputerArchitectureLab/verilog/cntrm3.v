module cntrm3(
  input clk,rst_b,clr,c_up,
  output dclk
);
  localparam S0=2, S1=0, S2=1;
  reg [2:0] st;
  wire [2:0] st_nxt;
  assign st_nxt[S0]=  (st[S0] & (clr | (~c_up))) |
                      (st[S1] & clr) |
                      (st[S2] & (clr | c_up));
  assign st_nxt[S1]=  (st[S0] & (~clr) & c_up) |
                      (st[S1] & (~clr) & (~c_up));
  assign st_nxt[S2]=  (st[S1] & (~clr) & c_up) |
                      (st[S2] & (~clr) & (~c_up));
  assign dclk = st[S0];
  always @ (posedge clk, negedge rst_b)
    if (rst_b == 0) begin
      st<=0;
      st[S0]<=1;
    end else
      st<=st_nxt;
endmodule

module cntrm3_tb;
  reg clk,rst_b,clr,c_up;
  wire dclk;
  cntrm3 inst(.clk(clk),.rst_b(rst_b),.clr(clr),
      .c_up(c_up),.dclk(dclk));
  localparam CLK_PERIOD=100, RUNNING_CYCLES=17, RST_DURATION=25;
  initial begin
    clk=0;
    repeat (2*RUNNING_CYCLES) #(CLK_PERIOD/2) clk=~clk;
  end
  initial begin
    rst_b=0;
    #RST_DURATION rst_b=1;
  end
  initial begin
    {clr,c_up} = 2'b01;
    #(4*CLK_PERIOD) {clr,c_up} = 2'b11;
    #(1*CLK_PERIOD) {clr,c_up} = 2'b00;
    #(1*CLK_PERIOD) {clr,c_up} = 2'b01;
    #(4*CLK_PERIOD) {clr,c_up} = 2'b00;
    #(1*CLK_PERIOD) {clr,c_up} = 2'b01;
  end
endmodule