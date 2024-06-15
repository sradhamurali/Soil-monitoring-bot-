module SM_1153_pick_drop(
input clk_50,
input [31:0]node,
input node_detected,
output control_mag,
output drop_message,
output pick_message
);

reg control_mag_temp=0;
always@(posedge clk_50)begin
if(node_detected==1)begin
if(node==30||node==29||node==31||node==32||node==33||node||34||node==35)begin
control_mag_temp<=1;
pick_message_temp<=1;
drop_message_temp<=0;
end
else begin
pick_message_temp<=0;
drop_message_temp<=0;

end
if(node==17||node==19||node==20||node==21||node==22||node==23||node==24||node==25||node==14||node==27||node==28)begin
control_mag_temp<=0;
drop_message_temp<=1;
pick_message_temp<=0;
end
else begin
pick_message_temp<=0;
drop_message_temp<=0;

end
end
end
assign control_mag=control_mag_temp;
assign pick_message=pick_message_temp;
assign drop_message=drop_message_temp;

endmodule
