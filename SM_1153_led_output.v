module SM_1153_led_output(
input clk_50,
input red,
input green,
input blue,
input [5:0]node,
output red2,
output green2,
output blue2,
output red3,
output green3,
output blue3,
output red1,
output green1,
output blue1
);
reg red1_temp=0;
reg green3_temp=0;
reg blue2_temp=0;


always@(posedge clk_50)begin
if(node==11||node==22)begin
red1_temp<=0;
green3_temp<=0;
blue2_temp<=0;

end
if(red==1)begin
red1_temp<=1;
end
if(blue==1)begin
blue2_temp<=1;
end
if(green==1)begin
green3_temp<=1;
blue2_temp<=0;
end
end


assign red1=red1_temp;
assign blue2=blue2_temp;
assign green3=green3_temp;
assign red2=0;
assign red3=0;
assign blue1=0;
assign blue3=0;
assign green1=0;
assign green2=0;

endmodule