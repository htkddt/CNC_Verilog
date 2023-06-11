module Bai_3 (clk, clk_1, WR, D, Pulse, LS, f_full, flag_T, Dir, data, LS_temp);
input clk, WR, LS;
input [7:0] D;
output clk_1, f_full, flag_T, Pulse, Dir, LS_temp;
output reg [7:0] data=0;
reg [7:0] temp_1=0, acc=10, Nbuff_1, Nbuff_2, Nbuff_3, Nbuff_4;
reg [3:0] temp_2=0;
reg [2:0] cnt_1=1;
reg pre_WR, pre_flag_T, pinout_1, pinout_2, clk_1, f_full, flag_T, Dir, LS_temp;
//initial							//Khoi dong
//begin
//	acc <= N;
//end
always @(posedge clk)		//Tao xung clk_1
begin
if(temp_1 < 50)
	temp_1 = temp_1 + 1;
else
begin
	clk_1 = ~clk_1;
	temp_1 = 1;
end
end
//-------------------------
always @(posedge clk_1)		//Tao xung flag_T
begin
if(temp_2 < 10)
	temp_2 = temp_2 + 1; 
else
begin
	flag_T = ~flag_T;
	temp_2 = 1;
end
end
//----------------------------------------
always @(posedge clk)		//Xu ly data
begin		
pre_WR <= WR;
pre_flag_T <= flag_T;
if(LS == 1)
	LS_temp = 1;
begin
	if({pre_WR,WR} == 2'b01 && f_full == 0 && LS_temp == 0)
		case(cnt_1)
			1: 
			begin
				Nbuff_1 = D;
				cnt_1 = cnt_1 + 1;
				f_full = 0;
			end
			2: 
			begin
				Nbuff_2 = D;
				cnt_1 = cnt_1 + 1;
				f_full = 0;
			end
			3:
			begin
				Nbuff_3 = D;
				cnt_1 = cnt_1 + 1;
				f_full = 0;
			end
			4:	
			begin
				Nbuff_4 = D;
				cnt_1 = cnt_1 + 1;
				f_full = 1;
			end
			default: cnt_1 = 0;
		endcase
end
if(pre_flag_T != flag_T)
	begin
		if(LS_temp != LS)
		begin
			pinout_1 = 0;
			data = 0;
			Nbuff_1 = 0;
			Nbuff_2 = 0;
			Nbuff_3 = 0;
			Nbuff_4 = 0;
			cnt_1 = 1;
			LS_temp = 0;
			f_full = 0;
		end
		else
		begin
			pinout_1 = 1;
			cnt_1 = cnt_1 - 1;
			f_full = 0;
			data = Nbuff_1;
			Nbuff_1 = Nbuff_2;
			Nbuff_2 = Nbuff_3;
			Nbuff_3 = Nbuff_4;
			Nbuff_4 = 0;
		end
	end
	Dir = data[7];
end
//-------------------------------
always @(posedge clk_1)			//Rai xung
begin
acc = acc + data[6:0];
begin
if(acc > 10)
	begin
		acc = acc - 10;
		pinout_2 = 1;
	end
else
	pinout_2 = 0;
end
end
	assign Pulse = clk_1&pinout_1&pinout_2;
endmodule
