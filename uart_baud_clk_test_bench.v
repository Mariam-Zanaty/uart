
module uart_baud_clk_tb();

reg clk; 
wire[3:0] tick;

parameter period= 6.6;


//DUT_instantiation
uart_baud_generator uart_tb ( .clk(clk) , .tick(tick) );


//clk_gen
always 
begin
#(period/2) clk = 1;
#(period/2) clk = 0;
end

/*
//stimilus_gen
initial
begin
#(`delay) rst =0;

#(`delay) rst =1;
#(`delay) sequence=1;
#(`delay) sequence=0;
#(`delay) sequence=1;
#(`delay) sequence=1;
#(`delay) sequence=0;

#(`delay) sequence=0;
#(`delay) sequence=1;
#(`delay) sequence=1;

end
*/


initial
begin

$time_format(-9,3,"ns");
$display("        ", "     Time clk tick");
$monitor("%t %t %b " , $realtime, clk, tick);

end
endmodule
