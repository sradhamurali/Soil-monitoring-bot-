module SM_1153_PWM_Generator(
 
	input clk,             // Clock input
	input [7:0]DUTY_CYCLE, // Input Duty Cycle
	output PWM_OUT,         // Output PWM
	output temp
);
 
////////////////////////WRITE YOUR CODE FROM HERE////////////////////

reg freq_1;
reg[12:0] counter=12'd0;
parameter DIVISOR=100;

reg [12:0]counter_1=0;
always@(posedge clk)
begin
counter<=counter+8'd1;
if(counter>= (DIVISOR -1))
counter<= 12'd0;
freq_1<= (counter<DIVISOR/2)?1:0;

//



end
reg[12:0] counter1=12'd0;
//parameter DIVISOR1=0.5;

//reg [7:0]counter_1=0;

assign temp=freq_1;
integer i;
//reg temp_op;
always@(posedge temp)
begin
if(counter1<50)counter1<=counter1+1;
else counter1<=0;
end


assign PWM_OUT=(counter1<DUTY_CYCLE/2 +1);






////////////////////////YOUR CODE ENDS HERE//////////////////////////
endmodule
///////////////////////////////MODULE ENDS///////////////////////////