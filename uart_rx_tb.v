`timescale 1ns/1ns
module uart_rx_tb();


reg clk; 
reg rx_pin;

wire[7:0] RBR;

parameter period= 6,
         // delay = 104166;
          delay= 30;

//DUT_instantiation
uart_rx u1 ( .clk(clk) , .rx_pin(rx_pin), .RBR(RBR) );


//clk_gen
always 
begin
#(period/2) clk = 1;
#(period/2) clk = 0;
end


//stimilus_gen
initial
begin
#(delay) rx_pin =1;
#(delay) rx_pin =1;
#(delay) rx_pin =0;
#(delay) rx_pin =0;
#(delay) rx_pin =1;
#(delay) rx_pin =0;
#(delay) rx_pin =1;
#(delay) rx_pin =1;
#(delay) rx_pin =0;
#(delay) rx_pin =0;
#(delay) rx_pin =1;
#(delay) rx_pin =1;

end



initial

begin
$time_format(-9,3,"ns");
$display("        ", "     Time clk rx_pin RBR");
$monitor("%t %b %b %b " , $realtime, clk, rx_pin, RBR);
end

endmodule

