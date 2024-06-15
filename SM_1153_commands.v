module SM_1153_commands(
input clk_50,
input [2:0]robo_command,
output left,
output right,
output reverse

);
reg left_temp=0;
reg right_temp=0;
reg reverse_temp=0;
always@(posedge clk_50)begin
if(robo_command==1)begin
left_temp<=0;
right_temp<=0;
reverse_temp<=0;

end
else if(robo_command==2)begin
left_temp<=1;
right_temp<=0;
reverse_temp<=0;
end
else if(robo_command==3)begin
left_temp<=0;
right_temp<=1;
reverse_temp<=0;
end
else if(robo_command==4)begin
left_temp<=0;
right_temp<=0;
reverse_temp<=1;
end
end

assign left=left_temp;
assign right=right_temp;
assign reverse=reverse_temp;

endmodule
