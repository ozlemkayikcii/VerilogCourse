module mux2s #(parameter w=8)(
  input [w-1:0] d0,d1,d2,d3,
  input [1:0] s,
  output reg [w-1:0] o
);
  always @(*) begin
    if (s == 0) o = d0;
    else if (s == 1) o = d1;
    else if (s == 2) o = d2;
    else o = d3;
  end
endmodule

module mux2s_tb; //w = 4
  reg [3:0] d0, d1, d2, d3;
  reg [1:0] s;
  wire [3:0] o;
  
  mux2s #(.w(4)) inst1 (.d0(d0), .d1(d1), .d2(d2), .d3(d3), .s(s), .o(o));
  integer k;
  initial begin
    $display("time\ts\td0\td1\td2\td3\to");
    $monitor("%4t\t%b\t%b\t%b\t%b\t%b\t%b",$time,s,d0,d1,d2,d3,o);
    {s, d0, d1, d2, d3} = 0; //18 bits
    for (k=1; k<100; k=k+1)
      #10 {s, d0, d1, d2, d3} = $urandom(k*200000);
    #10;
  end
endmodule