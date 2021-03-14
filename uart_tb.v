module uart_rx_tb();

parameter period= 20,
          delay= 5;
reg clk;
reg rst;
reg reset_sys; 
reg rx_pin;
wire [7:0] led_pins;
wire tx;
//DUT_instantiation
uart_rx uart_rx_for_tb(
         .clk(clk),
		 .rst(rst),
		 .reset_sys(reset_sys),
		 .rx_pin(rx_pin),
		 .led_pins(led_pins),
		 .tx(tx)
);

//clk_gen
always 
begin
#(period/2) clk = 1;
#(period/2) clk = 0;
end

//stimilus_gen
initial
begin
#(delay) rst =1;
reset_sys =0;
#(delay) rst =0;
reset_sys =1;
#(delay) rx_pin=1;
#(delay) rx_pin=0;
 rx_pin=1;
 rx_pin=1;
 rx_pin=1;
 rx_pin=1;
 rx_pin=1;
 rx_pin=0;
 rx_pin=0;
 rx_pin=1;
 rx_pin=1;
end

initial
begin

//$time_format(-12,2,"ps",7);
$display("        ", "     Time  rst  reset_sys  rx_pin led_pins tx");
$monitor("%t %b %b %b %b %b" , $realtime, rst, reset_sys, rx_pin, led_pins, tx );

end
endmodule



