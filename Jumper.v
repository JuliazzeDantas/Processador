/*
Nesse módulo usarei somente o valor do PC e o valor de uma parte do dado proveniente da memoria 
Eu concatenarei parte desses dois valores

- endereco
	Esse dado é retirado da memória
	Excluimos os seus 7 primeiros bits, pois eles são o Opcode
	para corrrigir essa defasagem concatenamos ele com os 7 primeiro bits do Program Counter
	
- programCOunter
	Esse é o valor atual do Program counter
	Seus 7 primeiros bits serão concatenados com o endereço (endereco)
	Tive que usar um registrador auxiliar para fazer isso
	
- jump 
	ele é o valor de saída que será gravado no PC
	é resultado da concatenação do PC com o Dado da memória

*/

module Jumper 
	(
	input clock,
	input [25:0] endereco,
	input [31:0] programCounter,
	
	output reg [31:0] jump
	);

	always @(posedge clock) begin
		jump <= {programCounter[31:28], endereco};
	end

endmodule