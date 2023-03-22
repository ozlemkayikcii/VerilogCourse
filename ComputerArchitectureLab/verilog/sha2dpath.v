module sha2dpath(
  input clk,rst_b,clr,st_pkt,pad_pkt,zero_pkt,mgln_pkt,
  input [63:0] pkt,
  output [2:0] idx,
  output [511:0] blk
);
  wire [63:0] msg_len, mout;
  wire [2:0] cout;
  pktmux inst1(.pkt(pkt),.pad_pkt(pad_pkt),.zero_pkt(zero_pkt),
      .mgln_pkt(mgln_pkt),.msg_len(msg_len),.o(mout));
  regfl inst2(.clk(clk),.rst_b(rst_b),.s(cout),.we(st_pkt),.d(mout),.q(blk));
  cntr #(.w(3)) inst3(.clk(clk),.rst_b(rst_b),.clr(clr),.c_up(st_pkt),.q(cout));
  rgst #(.w(64)) inst4(.clk(clk),.rst_b(rst_b),.clr(clr),
      .ld(st_pkt&(~(pad_pkt|zero_pkt|mgln_pkt))),.q(msg_len),
      .d(msg_len+64));
endmodule