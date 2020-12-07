// Quartus Prime Verilog Template
// Simple Dual Port RAM with separate read/write addresses and
// single read/write clock

/*
- dado
	É o valor que será escrito na pilha
	
- push
	É o sinal, proveniente da Unidade de Controle, que é responsável por permitir a escrita na pilha

- pop 
	É o sinal, proveniente da Unidade de COntrole, que será responsável por retirar o topo da pilha
	
- saidaPilha
	Saida de dado da pilha

- topo (reg)
	Marcador do topo da pilha 
	pode atingir as 512 posições

- pilha (reg)
	uma pilha que irá guardar os endereços de memória das intruções jal
	

*/
module Pilha
(
	input [(32-1):0] dado,
	input push, pop, clock,
	output reg [(32-1):0] saidaPilha,
	output reg [9:0] amostra
);

	// Declare the RAM variable
	reg [32-1:0] pilha[2**10-1:0];//Uma pilha com 512 posições
	
	reg [9:0]topo; //marcador 
	
	initial begin // Esse initial é usado para testes
		topo <= 9'b111111110;
	end 
	
	always @ (posedge clock)
	begin
	
		if (push)
			if(topo > 9'b000000000) begin //verifica se a pilha está cheia
				pilha[topo] <= dado; 
				topo <= topo  - 9'b000000001; //Atualização
			end
	
		if(pop) begin
			if(topo < 9'd511) begin //verifica se a pilha tá vazia
				saidaPilha <= pilha[topo];
				topo <= topo + 9'b000000001; //Atualização
			end
		end
		
		amostra <= topo;
	end

	
endmodule