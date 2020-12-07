module DivisorDeFrequencia (clockPlaca, clock);

	input clockPlaca; //Clock que vem da placa
	output reg clock; // Clock que será possível utilizar
	//##########Ficar atento ####################
	//Devo tirar o "reg"??
	// guardar em registradores podem me gerar em um delay 
	//talvez eu posso utilizar "output" somente para uma passagem direta
	
	integer contadorDeFrequencia;
	
	initial begin 
		contadorDeFrequencia = 0;
	end
	
	always @(posedge clockPlaca) begin
		
		if(contadorDeFrequencia < 100)
			contadorDeFrequencia = contadorDeFrequencia + 1;
		else begin
			clock = ~clock;
			contadorDeFrequencia = 0;
		end
	end 
endmodule
