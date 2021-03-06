module ConversorBCD (Entrada, Milhao, CentMilhar, DezMilhar, UniMilhar, Centena, Dezena, Unidade);

	input [31:0] Entrada;
	output reg [3:0] Milhao;
	output reg [3:0] CentMilhar;
	output reg [3:0] DezMilhar; 
	output reg [3:0] UniMilhar;
	output reg [3:0] Centena;
	output reg [3:0] Dezena;
	output reg [3:0] Unidade;
	
	integer contador;
		
	always @(Entrada) begin
	
		Milhao = 4'd0; 
		CentMilhar = 4'd0; 
		DezMilhar = 4'd0; 
		UniMilhar = 4'd0;
		Centena = 4'd0;
		Dezena = 4'd0;
		Unidade = 4'd0;
		
		for(contador = 31 ; contador >=0 ; contador = contador-1) begin
			
			if(Milhao >= 5)
				Milhao = Milhao + 4'd3;		
			if(CentMilhar >= 5)
				CentMilhar = CentMilhar + 4'd3;	
			if(DezMilhar >= 5)
				DezMilhar = DezMilhar + 4'd3;
			if(UniMilhar >= 5)
				UniMilhar = UniMilhar + 4'd3;
			if(Centena >= 5)
				Centena = Centena + 4'd3;
			if(Dezena >= 5)
				Dezena = Dezena + 4'd3;
			if(Unidade >= 5)
				Unidade = Unidade + 4'd3;
			
			Milhao = Milhao << 1; 
			Milhao[0] = CentMilhar[3];
			
			CentMilhar = CentMilhar << 1; 
			CentMilhar[0] = DezMilhar[3];
			
			DezMilhar = DezMilhar << 1; 
			DezMilhar[0] = UniMilhar[3];
			
			UniMilhar = UniMilhar << 1; 
			UniMilhar[0] = Centena[3];
			
			Centena = Centena << 1;
			Centena[0] = Dezena[3];	
		
			Dezena = Dezena << 1; 
			Dezena[0] = Unidade[3];
			
			Unidade = Unidade << 1; 
			Unidade[0] = Entrada[contador];
		end 
	end
endmodule