module DISP (Disp0, Disp1, Disp2, Disp3, Disp4, Disp5, Disp6, SinalUC, clock, mod0, mod1, mod2, mod3, mod4, mod5, mod6);

	input SinalUC, clock;
	
	input [3:0]mod0;
	input [3:0]mod1;
	input [3:0]mod2;
	input [3:0]mod3;
	input [3:0]mod4;
	input [3:0]mod5;
	input [3:0]mod6;
	
	output reg [6:0] Disp0;
	output reg [6:0] Disp1;
	output reg [6:0] Disp2;
	output reg [6:0] Disp3; 
	output reg [6:0] Disp4;
	output reg [6:0] Disp5;
	output reg [6:0] Disp6;
	
	always @(posedge clock) begin
	
		if(SinalUC) begin
			case (mod0) 
			4'd0:
				Disp0 <= 7'b0000001;
			4'd1:
				Disp0 <= 7'b1001111;
			4'd2:
				Disp0 <= 7'b0010010;
			4'd3:
				Disp0 <= 7'b0000110;
			4'd4:
				Disp0 <= 7'b1001100;
			4'd5:
				Disp0 <= 7'b0100100;
			4'd6:
				Disp0 <= 7'b0100000;
			4'd7:
				Disp0 <= 7'b0001111;
			4'd8:
				Disp0 <= 7'b0000000;
			4'd9:
				Disp0 <= 7'b0000100;
			default: 
				Disp0 <= 7'b1111111;
			endcase
			
			case (mod1)
			4'd0:
				Disp1 <= 7'b0000001;
			4'd1:
				Disp1 <= 7'b1001111;
			4'd2:
				Disp1 <= 7'b0010010;
			4'd3:
				Disp1 <= 7'b0000110;
			4'd4:
				Disp1 <= 7'b1001100;
			4'd5:
				Disp1 <= 7'b0100100;
			4'd6:
				Disp1 <= 7'b0100000;
			4'd7:
				Disp1 <= 7'b0001111;
			4'd8:
				Disp1 <= 7'b0000000;
			4'd9:
				Disp1 <= 7'b0000100;
			default: 
				Disp1 <= 7'b1111111;
			endcase
			
			case (mod2)
			4'd0:
				Disp2 <= 7'b0000001;
			4'd1:
				Disp2 <= 7'b1001111;
			4'd2:
				Disp2 <= 7'b0010010;
			4'd3:
				Disp2 <= 7'b0000110;
			4'd4:
				Disp2 <= 7'b1001100;
			4'd5:
				Disp2 <= 7'b0100100;
			4'd6:
				Disp2 <= 7'b0100000;
			4'd7:
				Disp2 <= 7'b0001111;
			4'd8:
				Disp2 <= 7'b0000000;
			4'd9:
				Disp2 <= 7'b0000100;
			default: 
				Disp2 <= 7'b1111111;
			endcase
			
			case (mod3)
			4'd0:
				Disp3 <= 7'b0000001;
			4'd1:
				Disp3 <= 7'b1001111;
			4'd2:
				Disp3 <= 7'b0010010;
			4'd3:
				Disp3 <= 7'b0000110;
			4'd4:
				Disp3 <= 7'b1001100;
			4'd5:
				Disp3 <= 7'b0100100;
			4'd6:
				Disp3 <= 7'b0100000;
			4'd7:
				Disp3 <= 7'b0001111;
			4'd8:
				Disp3 <= 7'b0000000;
			4'd9:
				Disp3 <= 7'b0000100;
			default:
				Disp3 <= 7'b1111111;
			endcase
			
			case (mod4)
			4'd0:
				Disp4 <= 7'b0000001;
			4'd1:
				Disp4 <= 7'b1001111;
			4'd2:
				Disp4 <= 7'b0010010;
			4'd3:
				Disp4 <= 7'b0000110;
			4'd4:
				Disp4 <= 7'b1001100;
			4'd5:
				Disp4 <= 7'b0100100;
			4'd6:
				Disp4 <= 7'b0100000;
			4'd7:
				Disp4 <= 7'b0001111;
			4'd8:
				Disp4 <= 7'b0000000;
			4'd9:
				Disp4 <= 7'b0000100;
			default: 
				Disp4 <= 7'b1111111;
			endcase
			
			case (mod5)
			4'd0:
				Disp5 <= 7'b0000001;
			4'd1:
				Disp5 <= 7'b1001111;
			4'd2:
				Disp5 <= 7'b0010010;
			4'd3:
				Disp5 <= 7'b0000110;
			4'd4:
				Disp5 <= 7'b1001100;
			4'd5:
				Disp5 <= 7'b0100100;
			4'd6:
				Disp5 <= 7'b0100000;
			4'd7:
				Disp5 <= 7'b0001111;
			4'd8:
				Disp5 <= 7'b0000000;
			4'd9:
				Disp5 <= 7'b0000100;
			default: 
				Disp5 <= 7'b1111111;
			endcase	

		
			case (mod6) 
			4'd0:
				Disp6 <= 7'b0000001;
			4'd1:
				Disp6 <= 7'b1001111;
			4'd2:
				Disp6 <= 7'b0010010;
			4'd3:
				Disp6 <= 7'b0000110;
			4'd4:
				Disp6 <= 7'b1001100;
			4'd5:
				Disp6 <= 7'b0100100;
			4'd6:
				Disp6 <= 7'b0100000;
			4'd7:
				Disp6 <= 7'b0001111;
			4'd8:
				Disp6 <= 7'b0000000;
			4'd9:
				Disp6 <= 7'b0000100;
			default: 
				Disp6 <= 7'b1111111;
			endcase
			
		end
	end
endmodule