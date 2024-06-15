// SM : Task 2 B : UART
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design UART Transmitter.

Recommended Quartus Version : 19.1
The submitted project file must be 19.1 compatible as the evaluation will be done on Quartus Prime Lite 19.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

//UART Transmitter design
//Input   : clk_50M : 50 MHz clock
//Output  : tx : UART transmit output

//////////////////DO NOT MAKE ANY CHANGES IN MODULE//////////////////
module SM_1153_uart(
	input clk_50M,	//50 MHz clock
	output tx,
	input flag,
	input red,
	input green,
	input blue
);
////////////////////////WRITE YOUR CODE FROM HERE////////////////////
parameter IDLE=3'b000;
parameter tx_start_bit=3'b001;
parameter tx_data_bit=3'b011;
parameter tx_stop_bit=3'b100;
parameter cleanup=3'b101;
parameter rest=3'b110;
parameter clks_per_bit=434;
reg [1:0]colour_temp;
//always@(colour)
//colour_temp<=colour;
reg counter=0;
reg [2:0]count_colors=1;
reg[2:0]r_state=IDLE;
reg[9:0]r_clock_count=0;
reg[9:0]r_clock_count1=0;
reg[2:0]r_bit_index=0;
reg[7:0]r_data_bits=0;
reg[4:0]next=5'b000;

reg tx_serial;

always@(posedge clk_50M)
begin
if(count_colors==4)
		count_colors<=1;
case(r_state)
IDLE:
	begin
		
		
		r_clock_count=0;
		if(r_clock_count1<clks_per_bit-1)
		begin
		r_clock_count1<=r_clock_count1+1'b1;
		r_state<=IDLE;
		
		r_bit_index=0;
		tx_serial<=1'b1;
		end
		else if(next<=11 && counter==0 && flag==1)
		begin
		r_state<=tx_start_bit;
		end
		else if(counter==1)begin
		r_state<=rest;
		end
		else 
		r_state<=IDLE;
		end

tx_start_bit:
	begin 
		tx_serial<=0;
		if(r_clock_count<clks_per_bit-1)
		begin
			r_clock_count<=r_clock_count+1'b1;
			r_state<=tx_start_bit;
			end
			else
			begin
			r_clock_count<=0;
			r_state<=tx_data_bit;
			if(next==0)r_data_bits=8'b01010011;
			else if(next==1)r_data_bits=8'b01001001;//1001001
			else if(next==2)r_data_bits=8'b00101101;
			else if(next==3)begin
			r_data_bits=8'b01010011;
//			counter<=counter+1;
			end
			else if(next==4)begin
			r_data_bits=8'b01001001;
//			
			end
			else if(next==5)begin
			r_data_bits=8'b01001101;

			end
			else if(next==6)begin
			////count number of colours
			if(count_colors==1)
			r_data_bits=8'b00110001;
			else if(count_colors==2)
			r_data_bits=8'b00110010;
			else if(count_colors==3)
			r_data_bits=8'b00110011;
			end
			else if(next==7)begin
			r_data_bits=8'b00101101;
			end
			else if(next==8)begin
			/////colours code
			if(red==1)begin
			r_data_bits=8'b01010000;
			end
			else if(green==1)begin
			r_data_bits=8'b01001110;
			end
			else if(blue==1)begin
			r_data_bits=8'b01010111;
			end
			end
			else if(next==9)begin
			r_data_bits=8'b00101101;
			end
			else if(next==10)begin
			r_data_bits=8'b00100011;
			end
			else if(next==11)begin
			r_data_bits=8'b00001010;
			counter<=counter+1;
			count_colors<=count_colors+1;
			if(count_colors==0)
			count_colors<=1;
			
			end
			else r_data_bits=0;
			end
			end
			
tx_data_bit:
	begin
		tx_serial<=r_data_bits[r_bit_index];
		if(r_clock_count<clks_per_bit-1)
		begin
			r_clock_count<=r_clock_count+1'b1;
			r_state<=tx_data_bit;
		end
		else 
		begin
			if(r_bit_index==7)
			begin
				r_clock_count<=0;
				r_state<=tx_stop_bit;
			end
			else
			begin
				r_clock_count<=0;
				r_state<=tx_data_bit;
				r_bit_index<=r_bit_index+1'b1;
			end
			end
			end
tx_stop_bit:
	begin
	tx_serial<=1;
	if(r_clock_count<2*(clks_per_bit)-3)
	begin
		r_clock_count<=r_clock_count+1'b1;
		r_state<=tx_stop_bit;
	end
	else 
	begin
	r_state<=cleanup;
	end
	end

cleanup:
	begin
		r_clock_count<=0;
		r_bit_index<=0;
		r_state<=IDLE;
		next=next+1'b1;
	end
rest:
begin
	if(flag==0)begin
	counter<=0;
	next<=0;
	r_state<=IDLE;
	end
	else r_state<=rest;
end
default:
	begin
		r_state<=IDLE;
		end
endcase


end
		assign tx=tx_serial;
		



////////////////////////YOUR CODE ENDS HERE//////////////////////////
endmodule
///////////////////////////////MODULE ENDS///////////////////////////