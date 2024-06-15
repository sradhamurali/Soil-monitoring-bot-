module SM_1153_path_planning(
input clk_50,
input [5:0]counter,
output [2:0]robo_command_temp,
//output [2:0]node2,
output hold_state,
output reset_temp,
output [5:0]current_node_temp,
output [5:0]node11,
output [5:0]node10,
input red ,
input green,
input blue,
output [5:0]node9,
output [5:0]node8,
output [5:0]node7,
output [5:0]node6,
output [5:0]node5,
output [5:0]node4,
output [5:0]node3,
output [5:0]node2,
output [5:0]node1,
output [5:0]node0,
output [5:0]node12,
output [5:0]node13,
output [5:0]node14,
output [5:0]node15,
output [5:0]node16,
output [5:0]node17,
output [5:0]node18,
output [5:0]node19,
output [5:0]node20,
output [5:0]node21,
output [5:0]node22,
output [5:0]node23,
output [5:0]node24,
output [5:0]node25,
output [5:0]node26,
output [5:0]node27,
output [5:0]node28,
output [5:0]node29,
output [5:0]node30,
output [5:0]node31,
output [5:0]node32,
output [5:0]node33,
output [5:0]node34,
output [5:0]node35,
output [5:0]node36,
output [5:0]start_temp,
output [5:0]end_temp,
output sensor_off

);

// clk;
reg [7:0] counter_clk=8'b0;
parameter DIVISOR=20;
reg freq;

always@(negedge clk_50)
begin
counter_clk<=counter_clk+8'd1;
if(counter_clk>= (DIVISOR -1))
counter_clk<= 8'd0;
freq<= (counter_clk<DIVISOR/2)?0:1;
end
//assign clk=freq;
















reg swap=0;
reg [5:0]temp_node;
reg flag=0;
reg sensor_off_temp=0;

wire color_detected=red|green|blue;
reg signed[5:0]final_path[0:12];
reg [5:0]current_node;
reg [1:0]supply[0:6];

reg temp2=0;
integer counter_temp=0;
always@(counter)begin
counter_temp<=counter;
end
reg [5:0]counter_algo3;
reg temp1=0;
reg reset_count_temp=0;
reg reset=0;
reg [1:0]direction=00;//west
reg [0:8]x_coordinate[0:36];
reg [0:8]y_coordinate[0:36];
integer i=0;
integer j=0;
parameter n=37;

parameter m=6;
parameter infinity=63;
reg signed [9:0]graph[0:37][0:7];
reg signed [2:0]robo_command[0:12];

//reg signed [5:0]path[0:3];
reg [1:0]visited[0:n];
reg [9:0]distance[0:n];
reg signed[5:0]path[0:12];
reg [5:0]path_temp[0:n];

reg signed [5:0]minVertex;
reg [5:0]target_nodes[0:5];

initial begin
for(i=0;i<=12;i=i+1)begin
path[i]=-1;

end///////////weight/////////////////////////weight////////////////// ////weight//// /////////////////weight///////
graph[0][0]=1;graph[0][1]=1;graph[0][2]=8;graph[0][3]=1;graph[0][4]=9;graph[0][5]=1;graph[0][6]=-1;graph[0][7]=0;
graph[1][0]=0;graph[1][1]=1;graph[1][2]=18;graph[1][3]=1;graph[1][4]=2;graph[1][5]=1;graph[1][6]=-1;graph[1][7]=0;
graph[2][0]=20;graph[2][1]=1;graph[2][2]=1;graph[2][3]=1;graph[2][4]=3;graph[2][5]=1;graph[2][6]=-1;graph[2][7]=0;
graph[3][0]=21;graph[3][1]=1;graph[3][2]=2;graph[3][3]=1;graph[3][4]=4;graph[3][5]=1;graph[3][6]=-1;graph[3][7]=0;
graph[4][0]=17;graph[4][1]=1;graph[4][2]=3;graph[4][3]=1;graph[4][4]=5;graph[4][5]=1;graph[4][6]=-1;graph[4][7]=0;
graph[5][0]=4;graph[5][1]=1;graph[5][2]=26;graph[5][3]=1;graph[5][4]=6;graph[5][5]=1;graph[5][6]=-1;graph[5][7]=0;
graph[6][0]=5;graph[6][1]=1;graph[6][2]=14;graph[6][3]=1;graph[6][4]=7;graph[6][5]=1;graph[6][6]=-1;graph[6][7]=0;
graph[7][0]=6;graph[7][1]=1;graph[7][2]=27;graph[7][3]=1;graph[7][4]=8;graph[7][5]=1;graph[7][6]=-1;graph[7][7]=0;
graph[8][0]=7;graph[8][1]=1;graph[8][2]=36;graph[8][3]=1;graph[8][4]=0;graph[8][5]=1;graph[8][6]=37;graph[8][7]=6'b111111;
graph[9][0]=0;graph[9][1]=1;graph[9][2]=30;graph[9][3]=1;graph[9][4]=10;graph[9][5]=1;graph[9][6]=29;graph[9][7]=1;
graph[10][0]=11;graph[10][1]=1;graph[10][2]=9;graph[10][3]=1;graph[10][4]=32;graph[10][5]=1;graph[10][6]=31;graph[10][7]=1;
graph[11][0]=34;graph[11][1]=1;graph[11][2]=10;graph[11][3]=1;graph[11][4]=33;graph[11][5]=1;graph[11][6]=12;graph[11][7]=1;
graph[12][0]=13;graph[12][1]=1;graph[12][2]=11;graph[12][3]=1;graph[12][4]=35;graph[12][5]=1;graph[12][6]=-1;graph[12][7]=0;
graph[13][0]=12;graph[13][1]=1;graph[13][2]=14;graph[13][3]=1;graph[13][4]=36;graph[13][5]=1;graph[13][6]=15;graph[13][7]=1;
graph[14][0]=13;graph[14][1]=1;graph[14][2]=6;graph[14][3]=1;graph[14][4]=24;graph[14][5]=1;graph[14][6]=-1;graph[14][7]=0;
graph[15][0]=13;graph[15][1]=1;graph[15][2]=25;graph[15][3]=1;graph[15][4]=18;graph[15][5]=1;graph[15][6]=16;graph[15][7]=1;
graph[16][0]=17;graph[16][1]=1;graph[16][2]=26;graph[16][3]=1;graph[16][4]=15;graph[16][5]=1;graph[16][6]=-1;graph[16][7]=0;
graph[17][0]=16;graph[17][1]=1;graph[17][2]=22;graph[17][3]=1;graph[17][4]=4;graph[17][5]=1;graph[17][6]=-1;graph[17][7]=0;
graph[18][0]=15;graph[18][1]=1;graph[18][2]=1;graph[18][3]=1;graph[18][4]=19;graph[18][5]=1;graph[18][6]=-1;graph[18][7]=0;
graph[19][0]=18;graph[19][1]=1;graph[19][2]=-1;graph[19][3]=0;graph[19][4]=-1;graph[19][5]=0;graph[19][6]=-1;graph[19][7]=0;
graph[20][0]=2;graph[20][1]=1;graph[20][2]=-1;graph[20][3]=0;graph[20][4]=-1;graph[20][5]=0;graph[20][6]=-1;graph[20][7]=0;
graph[21][0]=3;graph[21][1]=1;graph[21][2]=-1;graph[21][3]=0;graph[21][4]=-1;graph[21][5]=0;graph[21][6]=-1;graph[21][7]=0;
graph[22][0]=17;graph[22][1]=1;graph[22][2]=-1;graph[22][3]=0;graph[22][4]=-1;graph[22][5]=0;graph[22][6]=-1;graph[22][7]=0;
graph[23][0]=26;graph[23][1]=1;graph[23][2]=-1;graph[23][3]=1;graph[23][4]=-1;graph[23][5]=0;graph[23][6]=-1;graph[23][7]=0;
graph[24][0]=14;graph[24][1]=1;graph[24][2]=-1;graph[24][3]=1;graph[24][4]=-1;graph[24][5]=0;graph[24][6]=-1;graph[24][7]=0;
graph[25][0]=15;graph[25][1]=1;graph[25][2]=-1;graph[25][3]=0;graph[25][4]=-1;graph[25][5]=0;graph[25][6]=-1;graph[25][7]=0;
graph[26][0]=5;graph[26][1]=1;graph[26][2]=16;graph[26][3]=1;graph[26][4]=23;graph[26][5]=1;graph[26][6]=-1;graph[26][7]=0;
graph[27][0]=7;graph[27][1]=1;graph[27][2]=-1;graph[27][3]=0;graph[27][4]=-1;graph[27][5]=0;graph[27][6]=-1;graph[27][7]=0;
graph[28][0]=36;graph[28][1]=1;graph[28][2]=-1;graph[28][3]=0;graph[28][4]=-1;graph[28][5]=0;graph[28][6]=-1;graph[28][7]=0;
graph[29][0]=9;graph[29][1]=1;graph[29][2]=-1;graph[29][3]=0;graph[29][4]=-1;graph[29][5]=0;graph[29][6]=-1;graph[29][7]=0;
graph[30][0]=9;graph[30][1]=1;graph[30][2]=-1;graph[30][3]=0;graph[30][4]=-1;graph[30][5]=0;graph[30][6]=-1;graph[30][7]=0;
graph[31][0]=10;graph[31][1]=1;graph[31][2]=-1;graph[31][3]=0;graph[31][4]=-1;graph[31][5]=0;graph[31][6]=-1;graph[31][7]=0;
graph[32][0]=10;graph[32][1]=1;graph[32][2]=-1;graph[32][3]=0;graph[32][4]=-1;graph[32][5]=0;graph[32][6]=-1;graph[32][7]=0;
graph[33][0]=11;graph[33][1]=1;graph[33][2]=-1;graph[33][3]=0;graph[33][4]=-1;graph[33][5]=0;graph[33][6]=-1;graph[33][7]=0;
graph[34][0]=11;graph[34][1]=1;graph[34][2]=37;graph[34][3]=6'b111111;graph[34][4]=-1;graph[34][5]=0;graph[34][6]=-1;graph[34][7]=0;
graph[35][0]=12;graph[35][1]=1;graph[35][2]=-1;graph[35][3]=0;graph[35][4]=-1;graph[35][5]=0;graph[35][6]=-1;graph[35][7]=0;
graph[36][0]=28;graph[36][1]=1;graph[36][2]=13;graph[36][3]=1;graph[36][4]=8;graph[36][5]=1;graph[36][6]=37;graph[36][7]=6'b111111;
graph[37][0]=34;graph[37][1]=6'b111111;graph[37][2]=-1;graph[37][3]=0;graph[37][4]=-1;graph[37][5]=0;graph[37][6]=-1;graph[37][7]=0;
////////////////////////////////////////////////
x_coordinate[0]=55;y_coordinate[0]=130;x_coordinate[1]=55;y_coordinate[1]=145;x_coordinate[2]=55;y_coordinate[2]=155;x_coordinate[3]=35;y_coordinate[3]=170;x_coordinate[4]=20;y_coordinate[4]=170;x_coordinate[5]=0;y_coordinate[5]=150;x_coordinate[6]=0;y_coordinate[6]=130;x_coordinate[7]=0;y_coordinate[7]=120;x_coordinate[8]=20;y_coordinate[8]=115;x_coordinate[9]=45;y_coordinate[9]=130;x_coordinate[10]=40;y_coordinate[10]=130;x_coordinate[11]=30;y_coordinate[11]=130;x_coordinate[12]=25;y_coordinate[12]=130;x_coordinate[13]=20;y_coordinate[13]=130;x_coordinate[14]=10;y_coordinate[14]=130;x_coordinate[15]=20;y_coordinate[15]=145;x_coordinate[16]=20;y_coordinate[16]=150;x_coordinate[17]=20;y_coordinate[17]=160;x_coordinate[18]=35;y_coordinate[18]=145;x_coordinate[19]=35;y_coordinate[19]=150;x_coordinate[20]=50;y_coordinate[20]=155;x_coordinate[21]=35;y_coordinate[21]=165;x_coordinate[22]=15;y_coordinate[22]=160;x_coordinate[23]=10;y_coordinate[23]=155;x_coordinate[24]=10;y_coordinate[24]=135;x_coordinate[25]=15;y_coordinate[25]=145;x_coordinate[26]=10;y_coordinate[26]=150;x_coordinate[27]=5;y_coordinate[27]=120;x_coordinate[28]=15;y_coordinate[28]=125;x_coordinate[29]=45;y_coordinate[29]=125;x_coordinate[30]=45;y_coordinate[30]=135;x_coordinate[31]=40;y_coordinate[31]=125;x_coordinate[32]=40;y_coordinate[32]=135;x_coordinate[33]=30;y_coordinate[33]=125;x_coordinate[34]=30;y_coordinate[34]=135;x_coordinate[35]=25;y_coordinate[35]=135;x_coordinate[36]=20;y_coordinate[36]=125;
target_nodes[0]=34;target_nodes[1]=17;target_nodes[2]=18;target_nodes[3]=17;target_nodes[4]=5;

supply[0]=1;supply[1]=2;supply[2]=3;supply[3]=0;supply[4]=1;supply[5]=2;supply[6]=3;
end

//red-->01 // green-->10 // blue-->11
//reg counter=0;
reg [5:0]start_node=0;////////////////////////////////////
reg [5:0]end_node=1;///////////////////////////////
integer t=0;

reg [5:0]dist=0;
reg count_reset=0;
reg [5:0]target=0;
integer temp=0;
parameter IDLE=3'b000;
parameter algo=3'b001;
parameter algo1=3'b010;
parameter algo2=3'b011;
parameter algo3=3'b100;
parameter hold=3'b101;
parameter rest=3'b110;
parameter rest2=3'b111;
parameter inter=4'b1000;
parameter inter1=4'b1001;
parameter inter2=4'b1010;
parameter inter3=4'b1011;
parameter inter4=4'b1100;
parameter inter5=4'b1101;
parameter inter6=4'b1110;
parameter inter7=4'b1111;
parameter inter8=5'b10000;
reg left_temp=0;
reg right_temp=0;
reg reverse_temp=0;

reg [4:0]state=IDLE;


always@(posedge freq)begin
case(state)
IDLE:
	begin
	state<=inter5;
	reset<=0;
	
	for(i=0;i<=12;i=i+1)begin
	robo_command[i]<=0;
	path[i]<=-1;
	end
	robo_command[0]<=-1;
	
	end
inter5:begin
state<=algo;
for(i=0;i<=n;i=i+1)begin
	path_temp[i]<=0;
	end

end
algo:
	begin
//	reset=0;
	state<=inter1;
	for (i=0;i<=n;i=i+1)begin
	distance[i]<=10'b1111111111;
	visited[i]<=0;
	end
	
end
inter1:begin
	distance[start_node]<=0;

	i<=0;
	state<=inter6;
	

end
///////////////////new state/////////////////////////
inter6:begin
minVertex<=-1;
state<=algo1;
end
algo1:begin
state<=inter2;
	
	for(j=0;j<=n;j=j+1)begin
		if(visited[j]==0)begin
			if(minVertex==-1)begin
				minVertex=j;
			end
			else if(distance[j]<distance[minVertex])begin
			minVertex=j;
			end
		end
	end
	
end
inter2:begin
visited[minVertex]<=1;
state<=inter3;
j<=0;

end
inter3:begin
	state<=inter4;
	for(j=0;j<=6;j=j+2)begin
		if(graph[minVertex][j]!=-1 && visited[graph[minVertex][j]]==0)begin
		
			
			if(distance[minVertex]+graph[minVertex][j+1]<distance[graph[minVertex][j]])begin
				
				distance[graph[minVertex][j]]<=distance[minVertex]+graph[minVertex][j+1];
				path_temp[graph[minVertex][j]]<=minVertex;
			end
		end
	end
	
end


inter4:begin
if(i<37)begin
	i<=i+1;
//	temp1=0;
//	minVertex<=-1;
	state<=inter7;
end
else begin
	i<=0;
	state<=algo2;
	end
	
end


inter7:begin
state<=inter6;

end

algo2:
	begin

state<=algo3;
t=end_node;
for(i=0;(i<=12)&&(t!=start_node);i=i+1)begin
path[i]=t;
t=path_temp[t];
end

path[i]=t;
t=0;
j=12;

end
	
	
	
	
algo3:
	begin
//	temp1=1;
//for(j=12;j>=1;j=j-1)begin
if(path[j]!=-1)begin
	final_path[t]<=path[j];
if(x_coordinate[path[j]]>x_coordinate[path[j-1]]&&y_coordinate[path[j]]==y_coordinate[path[j-1]])begin
//final direction of bot should be north
	if(direction==00)begin
	robo_command[t]<=3;//right;
	end
	else if(direction==01)begin
	robo_command[t]<=2;//left
	end
	else if(direction==2)begin
	robo_command[t]<=1;
	end
	else if(direction==3)begin
	robo_command[t]<=4;
	end
	direction<=2;
end
else if(x_coordinate[path[j]]<x_coordinate[path[j-1]]&&y_coordinate[path[j]]==y_coordinate[path[j-1]])begin
//final direction of bot should be south
	if(direction==00)begin
	robo_command[t]<=2;
	end
	else if(direction==01)begin
	robo_command[t]<=3;
	end
	else if(direction==2)begin
	robo_command[t]<=4;
	end
	else if(direction==3)begin
	robo_command[t]<=1;
	end
	direction<=3;
end
else if(y_coordinate[path[j]]<y_coordinate[path[j-1]]&&x_coordinate[path[j]]==x_coordinate[path[j-1]])begin
//final direction of bot should be west
if(direction==0)begin
	robo_command[t]<=1;//backward
	end
	else if(direction==1)begin
	robo_command[t]<=4;//
	end
	else if(direction==2)begin
	robo_command[t]<=2;
	end
	else if(direction==3)begin
	robo_command[t]<=3;
	end
	direction<=0;
end
else if(y_coordinate[path[j]]>y_coordinate[path[j-1]]&&x_coordinate[path[j]]==x_coordinate[path[j-1]])begin
//final direction of bot should be east
	if(direction==00)begin
	robo_command[t]<=4;//right;
	end
	else if(direction==01)begin
	robo_command[t]<=1;//straight
	end
	else if(direction==2)begin
	robo_command[t]<=3;
	end
	else if(direction==3)begin
	robo_command[t]<=2;
	end
	direction<=1;
end
else begin
if(x_coordinate[path[j]]==55 && y_coordinate[path[j]]==130 &&x_coordinate[path[j-1]]==20&&y_coordinate[path[j-1]]==115)begin
if(direction==00)begin
	robo_command[t]<=4;//right;
	end
	else if(direction==01)begin
	robo_command[t]<=1;//straight
	end
	else if(direction==2)begin
	robo_command[t]<=3;
	end
	else if(direction==3)begin
	robo_command[t]<=2;
	end
direction<=2;//north
end
else if(x_coordinate[path[j-1]]==55 && y_coordinate[path[j-1]]==130 &&x_coordinate[path[j]]==20&&y_coordinate[path[j]]==115)begin
if(direction==00)begin
	robo_command[t]<=2;//right;
	end
	else if(direction==01)begin
	robo_command[t]<=3;//straight
	end
	else if(direction==2)begin
	robo_command[t]<=4;
	end
	else if(direction==3)begin
	robo_command[t]<=1;
	end
direction<=0;
end
else if(x_coordinate[path[j]]==55 && y_coordinate[path[j]]==155 &&x_coordinate[path[j-1]]==35&&y_coordinate[path[j-1]]==170)begin
if(direction==00)begin
	robo_command[t]<=1;//right;
	end
	else if(direction==01)begin
	robo_command[t]<=4;//straight
	end
	else if(direction==2)begin
	robo_command[t]<=2;
	end
	else if(direction==3)begin
	robo_command[t]<=3;
	end
direction<=2;
end
else if(x_coordinate[path[j-1]]==55 && y_coordinate[path[j-1]]==155 &&x_coordinate[path[j]]==35&&y_coordinate[path[j]]==170)begin
if(direction==00)begin
	robo_command[t]<=2;//right;
	end
	else if(direction==01)begin
	robo_command[t]<=3;//straight
	end
	else if(direction==2)begin
	robo_command[t]<=4;
	end
	else if(direction==3)begin
	robo_command[t]<=1;
	end
direction<=1;
end
else if(x_coordinate[path[j]]==20 && y_coordinate[path[j]]==170 &&x_coordinate[path[j-1]]==0&&y_coordinate[path[j-1]]==150)begin
if(direction==00)begin
	robo_command[t]<=3;//right;
	end
	else if(direction==01)begin
	robo_command[t]<=2;//straight
	end
	else if(direction==2)begin
	robo_command[t]<=1;
	end
	else if(direction==3)begin
	robo_command[t]<=4;
	end
direction<=1;
end
else if(x_coordinate[path[j-1]]==20 && y_coordinate[path[j-1]]==170 &&x_coordinate[path[j]]==0&&y_coordinate[path[j]]==150)begin
if(direction==00)begin
	robo_command[t]<=1;//right;
	end
	else if(direction==01)begin
	robo_command[t]<=4;//straight
	end
	else if(direction==2)begin
	robo_command[t]<=2;
	end
	else if(direction==3)begin
	robo_command[t]<=3;
	end
direction<=3;
end
else if(x_coordinate[path[j]]==0 && y_coordinate[path[j]]==120 &&x_coordinate[path[j-1]]==20&&y_coordinate[path[j-1]]==115)begin
if(direction==00)begin
	robo_command[t]<=4;//right;
	end
	else if(direction==01)begin
	robo_command[t]<=1;//straight
	end
	else if(direction==2)begin
	robo_command[t]<=3;
	end
	else if(direction==3)begin
	robo_command[t]<=2;
	end
direction<=3;
end
else if(x_coordinate[path[j-1]]==0 && y_coordinate[path[j-1]]==120 &&x_coordinate[path[j]]==20&&y_coordinate[path[j]]==115)begin
if(direction==00)begin
	robo_command[t]<=3;//right;
	end
	else if(direction==01)begin
	robo_command[t]<=2;//straight
	end
	else if(direction==2)begin
	robo_command[t]<=1;
	end
	else if(direction==3)begin
	robo_command[t]<=4;
	end
direction<=0;
end

end
//t<=t+1;
flag<=1;
end
state<=inter;
end


inter:
begin
if(flag==1)begin
flag<=0;
t<=t+1;
end
if(j==0)begin
state<=hold;
end
else begin
j<=j-1;
state<=algo3;
end
end

hold:
	
	begin
//
	if(robo_command[counter]==0||red==1||green==1||blue==1)begin
	reset<=1;
	state<=rest;

	start_node<=end_node;
	end
	if(start_node==20||start_node==21||start_node==19||start_node==22||start_node==23||start_node==24||start_node==27||start_node==28)begin
	sensor_off_temp<=0;
	end
end
rest:
	begin
// end_node ese choose krne hai jo ki humesha coloured patch ke just baad vala node ho - isse muje thodi sasani hogi kykoi start_node humesha update hojayega apne aap hi
// alaag se current node bnane ki zarurat nhi hai 
	if(swap==1)begin
	if(temp_node==2)begin
	end_node<=20;
	end
	else if(temp_node==3)begin
	end_node<=21;
	end
	else if(temp_node==18)begin
	end_node<=19;
	end
	else if(temp_node==17)begin
	end_node<=22;
	end
	else if(temp_node==26)begin
	end_node<=23;
	end
	else if(temp_node==14)begin
	end_node<=24;
	end
	else if(temp_node==15)begin
	end_node<=25;
	end
	else if(temp_node==36)begin
	end_node<=28;
	end
	else if(temp_node==7)begin
	end_node<=27;
	end
	swap<=0;
	state<=IDLE;
	end
	else if(red==1||green==1||blue==1)begin
	//color detect hote hi muje search krna hai same color ki supply kha rakhi hai uske baad supply se associated node tak aana hai 
	//red-->01 // green-->10 // blue-->11
	//let current node be current_node
	if(red==1)begin
	if(supply[0]==1)begin
	end_node<=29;//jha supply 0 rakhi hai ;
	supply[0]<=0;
	end
	else if(supply[1]==1)begin
	end_node<=30;//jha supply 1 rakhi hai ;
	supply[1]<=0;
	end
	else if(supply[2]==1)begin
	
	end_node<=31;//jha supply 2 rakhi hai
	supply[2]<=0;
	end
	else if(supply[3]==1)begin
	
	end_node<=32;//jha supply 3 rakhi hai ;
	supply[3]<=0;
	end
	else if(supply[4]==1)begin
	end_node<=33;//jha supply 4 rakhi hai ;
	supply[4]<=0;
	end
	else if(supply[5]==1)begin
	end_node<=34;//jha supply 5 rakhi hai ;
	supply[5]<=0;
	end
	else if(supply[6]==1)begin
	end_node<=35;//jha supply 6 rakhi hai ;
	supply[6]<=0;
	end
	
	end
	else if(green==1)begin
	if(supply[0]==2)begin
	end_node<=29;//jha supply 0 rakhi hai ;
	supply[0]<=0;
	end
	else if(supply[1]==2)begin
	end_node<=30;//jha supply 0 rakhi hai ;
	supply[1]<=0;
	end
	else if(supply[2]==2)begin
	end_node<=31;//jha supply 0 rakhi hai ;
	supply[2]<=0;
	end
	else if(supply[3]==2)begin
	end_node<=32;//jha supply 0 rakhi hai ;
	supply[3]<=0;
	end
	else if(supply[4]==2)begin
	end_node<=33;//jha supply 0 rakhi hai ;
	supply[4]<=0;
	end
	else if(supply[5]==2)begin
	end_node<=34;//jha supply 0 rakhi hai ;
	supply[5]<=0;
	end
	else if(supply[6]==2)begin
	end_node<=35;//jha supply 0 rakhi hai ;
	supply[6]<=0;
	end
	
	end
	else if(blue==1)begin
	if(supply[0]==3)begin
	end_node<=29;//jha supply 0 rakhi hai ;
	supply[0]<=0;
	end
	else if(supply[1]==3)begin
	end_node<=30;//jha supply 0 rakhi hai ;
	supply[1]<=0;
	end
	else if(supply[2]==3)begin
	end_node<=31;//jha supply 0 rakhi hai ;
	supply[2]<=0;
	end
	else if(supply[3]==3)begin
	end_node<=32;//jha supply 0 rakhi hai ;
	supply[3]<=0;
	end
	else if(supply[4]==3)begin
	end_node<=33;//jha supply 0 rakhi hai ;
	supply[4]<=0;
	end
	else if(supply[5]==3)begin
	end_node<=34;
	supply[5]<=0;
	end
	else if(supply[6]==3)begin
	end_node<=35;
	supply[6]<=0;
	end
	
	
	end
	
	
	
	
	temp_node<=start_node;
	state<=IDLE;
	swap<=1;
	sensor_off_temp<=1;
	
	end
	else begin
	end_node<=target_nodes[target];
	state<=rest2;
	end
end
//seedha IDLE state mei bhejhdo toh flag nhi bnana padega 
rest2:
begin


if(target==5)begin
	target<=0;
	end
	else 
	target<=target+1;

	state<=IDLE;
end
endcase
end




assign sensor_off=sensor_off_temp;
assign node0=robo_command[0];
assign node1=robo_command[1];
assign node2=robo_command[2];
assign node3=robo_command[3];
assign node4=robo_command[4];
assign node5=robo_command[5];
assign node6=robo_command[6];
assign node7=robo_command[7];
assign node8=robo_command[8];
assign node9=robo_command[9];
assign node10=robo_command[10];
assign node11=path_temp[11];
assign node12=path_temp[12];
assign node13=path_temp[13];
assign node14=path_temp[14];
assign node15=path_temp[15];
assign node16=path_temp[16];
assign node17=path_temp[17];
assign node18=path_temp[18];
assign node19=path_temp[19];
assign node20=path_temp[20];
assign node21=path_temp[21];
assign node22=path_temp[22];
assign node23=path_temp[23];
assign node24=path_temp[24];
assign node25=path_temp[25];
assign node26=path_temp[26];
assign node27=path_temp[27];
assign node28=path_temp[28];
assign node29=path_temp[29];
assign node30=path_temp[30];
assign node31=path_temp[31];
assign node32=path_temp[32];
assign node33=path_temp[33];
assign node34=path_temp[34];
assign node35=path_temp[35];
assign node36=path_temp[36];
assign start_temp=start_node;
assign end_temp=end_node;
assign robo_command_temp=robo_command[counter];

//assign robo_command_temp =robo_command[counter];

assign reset_temp=reset;



endmodule
