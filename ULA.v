/*
Nesse módulo irei colocar:
A ULA, responsável por todo cálculo aritmético e todas as operações lógicas
O ULAOut, um registrador que armazenará o valor da saída aritmético

- sinalMuxI
	Sinal proveniente da UC
	Escolhe entre o entradaI  e o PC
	A segunda opção só escolhida quando há atualização do Program Counter e desvios
	
- MuxULAII
	Sinal proveniente da UC
	Escolhe entre o RegB, uma constante 4, o Sinal Extendido e o Sinal Extendido e Descolado
	
- entradaI 
	Dado que vem do Banco de registradores, pode representar o Rp e o Rs
	Escolhido na grande maioria das vezes
	
- programCounter
	Dado que vem do Program Counter
	Escolhido em funções de desvio (brenchs) e ataulizações do PC

- regB
	Dado que vem do Banco de registradores, pode representar o Rs e o Rd
	Escolhido na grande maioria das vezes

- imediato
	Esse imediato vem de uma parte do registrador do Pc
	Ele dará origem a duas variaveis: o imediato extendido e o Imediato extendido e deslocado

- Sinal de controle, sinal proveniente da Unidade de Controle (UC)
	Esse sinal define qual operação será realizado pela ULA

As saida dos Mux serão:
- A entradaI, que é uma escolha que o mux faz entre o PC e o entradaI 
	Caso escolha o PC, ocorrerá uma atualização no Program Counter para ir para próxima linha de comando
	caso escolha o entradaI  ocorrerá uma operação lógica/aritmética
	
- A entradaII. Ela é uma esoclha que o mux faz entre o RegB, a constante 4, o imediato extendido (IE) e o 
imediato extendido e deslocado (ID):
	Caso escolha o RegB ocorrerá uma operação lógica/aritmética
	Caso escolha a constante ocorrerá uma atualização no Program Counter
	Caso escolha o IE será feito calculos com o Imediato ou o cálculo para saber o endereço para guardar 
o dado (load word)
	Caso escolha o ID será usado para fazer o cálculo de desvio do endereço 
	
Em cada parte do case será dito o que o comando fará


OBS: note que nas operações lógicas são deixados lixos de memória na saída que irá para parte aritmética e nas
operações aritméticas são deixados lixos de memória na saida que irá para parte lógica. Isso não interfere em
nada pois a UC não dará acesso a essas saídas
*/


module ULA 
	(
	
	input clock,
	
	input muxULA,
	input [1:0]muxULAII,
	
	input [31:0] regA,
	input [31:0] programCounter,
	
	input [31:0] regB,
	//Há uma constante 4
	input [4:0] shamit,
	input [15:0] imediato, //esse imediato dara origem a duas variaveis no MuxII
	
	input [5:0] sinalControle,	
	
	output reg saidaLogicaULA,
	output [31:0] saidaAritmeticaULA
	);
	
	integer entradaI;
	integer entradaII;
	
	reg [31:0] ALUOut;
	
	always @(posedge clock) begin
		if(muxULA)
			entradaI = regA;
		else
			entradaI = programCounter;
			
		case(muxULAII)	
			2'b00: begin
				entradaII = regB;
			end
			
			2'b01: begin
				entradaII = 32'd4;
			end
			
			2'b10: begin
				entradaII = imediato;
			end
			
			2'b11: begin
				entradaII = imediato << 2'b10;
			end
		endcase

		case (sinalControle)
			6'd0:  begin //Adição                            
				ALUOut = entradaI + entradaII;
			end	
			
			6'd1:    begin //Subtração                          
				ALUOut = entradaI - entradaII;
			end
			
			6'd2:   begin //Multiplicação                           
				ALUOut = entradaI * entradaII;
			end
			
			6'd3:    begin //Divisão                          	
				ALUOut = entradaI / entradaII;
			end
			
			6'd4:    begin //Função Mod                          
				ALUOut = entradaI % entradaII;
			end
			
			6'd5: begin //AND                           
			ALUOut = entradaI && entradaII;
			saidaLogicaULA = 0;
			end
			
			6'd6: begin //NAND                            
			ALUOut = !(entradaI && entradaII);
			saidaLogicaULA = 0;
			end
			
			6'd7: begin //OR                           
			ALUOut = entradaI || entradaII;
			saidaLogicaULA = 0;
			end
			
			6'd8: begin //NOR                            
			ALUOut = !(entradaI || entradaII);
			saidaLogicaULA = 0;
			end
			
			6'd9: begin //NOT                            
			ALUOut = !(0 + entradaII);
			saidaLogicaULA = 0;
			end
			
			6'd10: begin //Concatena
			ALUOut = {entradaI[15:0],entradaII[15:0]};         
			saidaLogicaULA = 0;
			end
			
			6'd11: begin //Deslocamento para Esquerda
			ALUOut = entradaI << imediato;         
			saidaLogicaULA = 0;
			end
			
			6'd12: begin //Deslocamento para Direita
			ALUOut = entradaI >> imediato;         
			saidaLogicaULA = 0;
			end
			
			6'd13: begin //Igual     
				if(entradaI == entradaII) begin
					ALUOut = programCounter + 3'b100;
				end
				else begin
					ALUOut = programCounter + (imediato << 2'd10);
				end
			end
			
			6'd14: begin //Diferença  
				if(entradaI != entradaII)begin
					ALUOut = programCounter + 3'b100;
				end
				else begin
					ALUOut = programCounter + (imediato << 2'd10);
				end
			end
			
			6'd15: begin //Maior que  
				if(entradaI > entradaII)begin
					ALUOut = programCounter + 3'b100;
				end
				else begin
					ALUOut = programCounter + (imediato << 2'd10);
				end
			end
			
			6'd16: begin //Menor que
				if(entradaI < entradaII)begin
					ALUOut = programCounter + 3'b100;
				end
				else begin
					ALUOut = programCounter + (imediato << 2'd10);
				end
			end
			
			6'd17: begin //Maior ou Igual                         
				if(entradaI >= entradaII)begin
					ALUOut = programCounter + 3'b100;
				end
				else begin
					ALUOut = programCounter + (imediato << 2'd10);
				end
			end
			
			6'd18: begin //Menor ou Igual                         
			if(entradaII <= regA)begin
					ALUOut = programCounter + 3'b100;
				end
				else begin
					ALUOut = programCounter + (imediato << 2'd10);
				end
			end
			
			default: begin //resto
			ALUOut = ALUOut;
			saidaLogicaULA = saidaLogicaULA;
			end
		endcase
	end

	assign saidaAritmeticaULA = ALUOut;
	
endmodule  