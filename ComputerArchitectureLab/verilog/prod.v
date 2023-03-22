module prod(
  input clk,rst_b,
  output reg val,
  output reg [7:0] data
);
  always @ (posedge clk, negedge rst_b)
    if (rst_b == 0) begin
      val<=0;
      data<=0;
    end else begin
      data<=$urandom_range(0,5);
      val<=1;
    end
endmodule

module prod_tb;
  reg clk,rst_b;
  wire val;
  wire [7:0] data;
  
  prod inst1(.clk(clk),.rst_b(rst_b),.val(val),.data(data));
  localparam CLK_PERIOD=100, RUNNING_CYCLES=100, RST_DURATION=25;
  initial begin
    clk=0;
    repeat (2*RUNNING_CYCLES) #(CLK_PERIOD/2) clk=~clk;
  end
  initial begin
    rst_b=0;
    #RST_DURATION rst_b=~rst_b;
  end
endmodule