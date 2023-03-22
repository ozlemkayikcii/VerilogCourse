module cntrm5(
  input clk,rst_b,clr,c_up,
  output dclk
);
  wire [2:0] ro;
  rgst #(.w(3)) inst1(.clk(clk),.rst_b(rst_b),.ld(c_up),
      .clr(clr | ro[2]),.q(ro),
      .d({ro[2]^(ro[1]&ro[0]),ro[1]^ro[0], ~ro[0]}));
  assign dclk = ~(|ro);
endmodule

module cntrm5_tb;
  reg clk,rst_b,clr,c_up;
  wire dclk;
  
  cntrm5 inst(.clk(clk),.rst_b(rst_b),.clr(clr),
      .c_up(c_up),.dclk(dclk));
  localparam CLK_PERIOD=100, RUNNING_CYCLES=9,
      RST_DURATION=25;
  initial begin
    clk=0;
    repeat (2*RUNNING_CYCLES) #(CLK_PERIOD/2)
        clk=~clk;
  end
  initial begin
    rst_b=0;
    #RST_DURATION rst_b=1;
  end
  initial begin
    {clr,c_up} = 2'b01;
    #(5*CLK_PERIOD) {clr,c_up} = 2'b11;
    #(1*CLK_PERIOD) {clr,c_up} = 2'b01;
  end
endmodule