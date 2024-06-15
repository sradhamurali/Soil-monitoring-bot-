module SM_1153_colour_detection(
input clk_50,
output [3:0]counter_temp,
output s2,
output s3,
output s0,
output s1,
input freq,
output [1:0]color,//0 for white 1 for red, 2 for green, 3 for blue
output [15:0]count_red,
output [15:0]count_green,
output [15:0]count_blue,
output red ,
output green,
output blue,
output detected
);

reg [1:0] color_temp;
parameter delay=100000;
assign s0=1;
assign s1=1;

reg red_temp=0;
reg green_temp=0;
reg blue_temp=0;

reg s2_1;
reg s3_1;
reg [3:0]temp=1;
reg [31:0]counter=1;

always@(posedge clk_50)begin
if(counter< delay)begin

counter<=counter+1;
end
else begin
 counter<=1;
end
end

//////////counter done !! no need to check///////////////////



always@(posedge clk_50)begin
if(counter==delay)begin
if(temp<4)begin
temp<=temp+1;
end
else temp<=1;
end
end
assign counter_temp=temp;


/////////data frame done !!! no need to check////////////////


always@(posedge clk_50)begin
if(temp==1)begin
s2_1<=0;
s3_1<=0;
end
else if (temp==2)begin
s2_1<=0;
s3_1<=1;
end
else if(temp==3)begin
s2_1<=1;
s3_1<=1;
end
else if(temp==4)begin
s2_1<=1;
s3_1<=0;
end
end




reg [15:0]counter_red=0;
reg[15:0]counter_blue=0;
reg[15:0]counter_green=0;
reg[15:0]counter_red_temp;
reg[15:0]counter_green_temp;
reg[15:0]counter_blue_temp;


reg counter_aiv=0;
//it is not necessary that posedge of freq will occur when temp==4 and aounter_aiv==1
always@(posedge freq or posedge counter_aiv)begin
if(counter_aiv==1)begin
counter_red<=0;
counter_green<=0;
counter_blue<=0;
end
else if(temp==1)begin
counter_red<=counter_red+1;

end
else if(temp==2)begin
counter_green<=counter_green+1;
end
else if(temp==3)begin
counter_blue<=counter_blue+1;
end
end

reg detected_temp=0;
always@(posedge clk_50)begin
if(temp==4 && counter==1)begin
counter_blue_temp<=counter_blue;
counter_green_temp<=counter_green;
counter_red_temp<=counter_red;
if(counter_blue>=40 && counter_blue<=45 && counter_green>=27 && counter_green<=30 && counter_red>=35 && counter_red<=38)begin
// output 2
detected_temp<=1;
color_temp<=2;
red_temp<=0;
green_temp<=1;
blue_temp<=0;
end

else if(counter_blue>=17 && counter_blue<=20 && counter_green>=22 && counter_green<=25 && counter_red>=61 && counter_red<=71)begin
// output 0 
detected_temp<=1;
color_temp<=1;
red_temp<=1;
green_temp<=0;
blue_temp<=0;
end
else if(counter_blue>=20 && counter_blue<=23 && counter_green>=37 && counter_green<=41 && counter_red>=19 && counter_red<=25)begin
// output 1
detected_temp<=1;
color_temp<=3;
red_temp<=0;
green_temp<=0;
blue_temp<=1;
end
else if(counter_blue>=82 && counter_green>=101 && counter_red>=83)begin
color_temp<=0;
detected_temp<=0;
red_temp<=0;
green_temp<=0;
blue_temp<=0;
end
end
else if(temp==4 && counter==delay-1)begin
counter_aiv<=1;
end
else if(temp==1)begin
counter_aiv<=0;
end
end
assign s2=s2_1;
assign s3=s3_1;
assign count_blue=counter_blue_temp;
assign count_green=counter_green_temp;
assign count_red=counter_red_temp;
assign color=color_temp;
assign detected=detected_temp;
assign red=red_temp;
assign green=green_temp;
assign blue=blue_temp;

endmodule



