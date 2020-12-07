/* 
Nesse modulo irei colocar:
- O Registrador Program Counter (PC) que será responsável pela atualização do caminho buscado na memória 
- O Mux que será responsável por definir qual caminho o PC irá seguir
- O botão reset, que trará esse componente ao seu estado inicial

Os caminhos disponiveis são:
- pcAtualizado, ele é o PC antigo somado com 4 e será uma atualização natural e sem desvios 
- jump, ele será um pulo direto para qualquer outra parte da memória. Será utilizado em loops juntos com o Beq
- desvio, será o responsável por trazer o caminho dos brench. será utilizado quando houver um if
*/
module PC (
	input clock, reset,
	input [1:0] controladorMuxPC, //Sinal proeniente da Unidade de Controle
	input [31:0] jump, desvio, //entradas de 32 bits que serão escolhidas pelo Mux 
	
	output [31:0] saidaPC //saida do PC
	);
	
	reg [31:0] ProgramCounter;
	
	initial begin
		ProgramCounter = 32'd0;
	end
	
	
	
	always@ (posedge clock) begin
	
		if(reset == 1)begin
			ProgramCounter <= 32'd0;
		end
		else begin
			case(controladorMuxPC)
			
			2'b11: begin
				ProgramCounter <= ProgramCounter + 32'd4;
			end
			
			2'b01: begin
				ProgramCounter <= jump;
			end
			
			2'b10: begin
				ProgramCounter <= desvio;
			end
			
			2'b00: begin
				ProgramCounter <= ProgramCounter;
			end
			endcase
		end
	end 
	assign saidaPC = ProgramCounter;
endmodule
