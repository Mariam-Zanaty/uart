module uart_rx(clk, rx_pin, led_pins);
//io declaration
input clk; //assumed to be 5M HZ
input rx_pin; //for recieving serial data 
output reg [7:0] led_pins; 
//signals declaration
//reg [7:0] the_received_bits;
reg data_in_recieved; //first reg for eleminating metastability
reg data_in; //second reg for eleminating metastability
//counter reg
//reg [10:0] acc;   // 11 bits total!
reg [3:0] recieved_bit_index;
reg [1:0] next_state;
//wire BaudTick;
reg [6:0] cycles_per_bit_counter=7'b0;
//baud rate =115200 & cycles_per_bit= 87
parameter  cycles_per_bit= 87,
           IDLE= 2'b00,
           start_bit= 2'b01,
           data_bits= 2'b10,
           stop_bit=  2'b11;
/*
//2M/115200=1024/59
// add 59 to the accumulator at each clock
always @(posedge clk)
  acc <= acc[9:0] + 59; // use 10 bits from the previous accumulator result, but save the full 11 bits result

assign BaudTick = acc[10]; // so that the 11th bit is the accumulator carry-out
*/

//for eleminating metastability problems 
always @(posedge clk)
begin
data_in_recieved <=rx_pin;
data_in <=data_in_recieved;
end


always @ (posedge clk)
begin
case(next_state)
IDLE:begin
led_pins<=8'b0;
cycles_per_bit_counter<=7'b0;
if(!data_in)
next_state<= start_bit;
else
next_state<= IDLE;
end

start_bit:begin
if(cycles_per_bit_counter == (cycles_per_bit-1)/2)
if(!data_in)
begin
cycles_per_bit_counter<=7'b0;
next_state<=data_bits;
end
else
next_state<=IDLE;
else
begin
cycles_per_bit_counter<= cycles_per_bit_counter+1;
next_state<=start_bit;
end
end

data_bits:begin
if(cycles_per_bit_counter == cycles_per_bit-1)
if(recieved_bit_index < 8)
begin
led_pins[recieved_bit_index]<=data_in;
recieved_bit_index<= recieved_bit_index+1;
next_state<=data_bits;
end
else
begin
recieved_bit_index<=4'b0;
next_state<=stop_bit;
end
else
begin
cycles_per_bit_counter<= cycles_per_bit_counter+1;
next_state<=data_bits;
end
end

stop_bit: begin
if(cycles_per_bit_counter == cycles_per_bit-1)
next_state<=IDLE;
else
begin
cycles_per_bit_counter <= cycles_per_bit_counter+1;
next_state<=stop_bit;
end
end
endcase
end

endmodule