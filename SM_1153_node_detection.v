module SM_1153_node_detection(
input clk_50,
input node_detected,
output [5:0]nodes,
output signed [7:0]error,
//output counter,
input reset_count
);
reg signed[7:0]error_temp=0;
parameter IDLE=2'b00;
parameter node=2'b01;
parameter rest=2'b10;
reg left=0;
reg right=0;
reg reverse=0;
reg [2:0]current_state=IDLE;
reg counter=0;
reg [5:0]count_nodes=0;
reg [31:0]count_delay=0;
parameter delay=100000;
reg [3:0]count_state=0;
always@(posedge clk_50)begin
if(reset_count==1)begin
count_nodes<=0;
current_state<=IDLE;
counter<=1;
end
else begin
case(current_state)
IDLE:
	begin
//	counter<=0;
	count_nodes<=0;
	current_state<=node;	
	end
node:
	begin
	if(count_delay<delay)begin
	count_delay<=count_delay+1;
	end
	else
	begin
	count_delay<=0;
//	if(reset_count==1)begin
//		count_nodes<=0;
//		current_state<=IDLE;
//
//	end
//	else 
	if(counter==0 && node_detected==1)begin
	counter<=counter+1;
	count_nodes<=count_nodes+1;
	
	end
	else if(counter==1 && node_detected==1)begin
	current_state<=rest;
	end
	else if(counter==1 &&node_detected==0)current_state<=IDLE;
	else current_state<=node;
	end
	end
rest:
	begin
	
	if(count_delay<delay)begin
	count_delay<=count_delay+1;
	end
	else if(count_state<=4)begin
	count_state<=count_state+1;
	count_delay<=0;
	current_state<=rest;
	end
	else 
	begin
	count_delay<=0;
	count_state<=0;
	if(node_detected==0)begin
	counter<=0;
	current_state<=node;
	error_temp<=0;
	end
	else current_state<=rest;
	end
	end
endcase
end
end

assign error=error_temp;
assign nodes=count_nodes;

endmodule