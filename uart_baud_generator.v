module uart_baud_generator(clk, tick);

input clk;
output[3:0] tick;
reg tick= 4'b0000;
reg [8:0] acc= 9'b000_000_000;

/*parameter  clock_frequency= 'd150_000_000,
           Baud_Rate= 'd9600,
           over_sampling_mode= 5'b10000,
           divisor= clock_frequency/(Baud_Rate* over_sampling_mode);
*/


always @ (posedge clk)
begin
//acc==977
if(acc ==9'b111_101_000 )
begin
tick <= tick+ 4'b0001;
acc <= 9'b000_000_000;
end
else
acc = acc +9'b000_000_001;

end




endmodule