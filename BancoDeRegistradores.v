	/*
Nesse módulo será construído o banco de registradores. Nele haverá
- 32 registradores que formam uma matriz 2x2
- Os mux para escolha dos registradores (saidaRegA, saidaRegB) escolhidos para serem encaminhdos para o RegA e o RegB 
- O mux que escolherá o dado recebido pelo Registrador Destino (RD)

As entradas serão:

- clock
	Cock corrigido pelo divisor de frequencia

- apontaRegPrimario 
	escolhe qual dos Registradores representará o Rp

- apontaRegSecundario 
	escolhe qual dos Registradores representará o Rs

- apontaRegDestino 
	escolhe qual dos Registradores representará o Rd

- dadoULA
	Dado proveniente da ULA. Seu valor será armazenado no RegDestino
	Usado para guardar os resultados dos calculos da ULA nas funções aritméticas do tipo R e do tipo I
	
- dadoMemory
	Dado proveniente do Memory Data Register. 
	Usado para guardar as informações na função Load Word (lw)

- sinalEscritaBancoReg
	Proveniente da Unidade de Controle (UC)
	Usado nas funçãos aritméticas do tipo R e I, para gravar o valor em Rd ou pela função do tipo In para gravar o valor do dispositivo de entrada no Reg5
	Lembrar de Desligar esse Sinal durante a função Out

- sinalDoIn
	Sinal proveniente da UC
	Quando ligado, permite a escrita no banco de registradore pela função In, o valor do dispositivo de entrada é mandado direto para o Reg5
	Quando desligado, permite que o valor guardado no ULAOut e no Memory Data Register seja guardado no banco de Reg
	
- sinalDoOut
	Sinal proveniente da UC
	Quando ligado, ele manda  o valor contido no Reg10
	Quando desligao, pemirte a passagem de dados dos registradores selecionados para os registradores A e B

- sinalDado
	Um sinal proveniente da UC
	Funciona como um mux que escolhe entre os dados do ULAOut e do Memory Data Register (MDR)
	O MDR é utilizado para a função load word
	O ALUOut é utilizado para função logicas e aritméticas diversas

- sinalDeTroca
	Sinal proveniente da UC
	Quando acionado, ele fazo Rd ir para o A e o Rp ir para o B
	Ele é usado nas funções de desvio e nas store word para que se mantenha a ordem dos registradores na AULA

- reset
	zera todos os registradores do módulo
	Ele foi colocado no negedge para não ter problema de zera-lo no posedge e quando o clock resetar ser gravado algum lixo de memoria que estava nos outros registradores

OBS: 
- O registrador 0 (bancoReg[0]) sempre valerá 0 
*/ 
module BancoDeRegistradores
	(
	input clock, 
	
	input [4:0] apontaRegPrimario, 
	input [4:0] apontaRegSecundario, 
	input [4:0] apontaRegDestino, 	
	input sinalDeTroca,
		
	input sinalDado,
	input [32 - 1:0] dadoULA,
	input [32 - 1:0] dadoMemory,	
	
	input sinalEscritaBancoReg,
	input sinalDoIn,
	input sinalDoOut,	 
	input reset,
	
	output reg [32 - 1:0] saidaRegA, saidaRegB, saidaDisplay //Saídas com os dados retirados do banco de registradores	
	);
	
	reg [31:0] bancoReg [31 :0]; //Banco de registradores
	
	reg [31:0] RegA;
	reg [31:0] RegB;
	
	initial begin // Esse initial é usado para testes
		bancoReg[32'd0] = 32'd0;
		bancoReg[32'd1] = 32'd1;
		bancoReg[32'd2] = 32'd2;
		bancoReg[32'd3] = 32'd3;
		bancoReg[32'd4] = 32'd4;
		bancoReg[32'd5] = 32'd5;
		bancoReg[32'd6] = 32'd6;
		bancoReg[32'd7] = 32'd7;
		bancoReg[32'd8] = 32'd8;
		bancoReg[32'd9] = 32'd9;
		bancoReg[32'd10] = 32'd10;
		bancoReg[32'd11] = 32'd11;
		bancoReg[32'd12] = 32'd12;
		bancoReg[32'd13] = 32'd13;
		bancoReg[32'd14] = 32'd14;
		bancoReg[32'd15] = 32'd15;
		bancoReg[32'd16] = 32'd16;
		bancoReg[32'd17] = 32'd17;
		bancoReg[32'd18] = 32'd18;
		bancoReg[32'd19] = 32'd19;
		bancoReg[32'd20] = 32'd20;
		bancoReg[32'd21] = 32'd21;
		bancoReg[32'd22] = 32'd22;
		bancoReg[32'd23] = 32'd23;
		bancoReg[32'd24] = 32'd24;
		bancoReg[32'd25] = 32'd25;
		bancoReg[32'd26] = 32'd26;
		bancoReg[32'd27] = 32'd27;
		bancoReg[32'd28] = 32'd28;
		bancoReg[32'd29] = 32'd29;
		bancoReg[32'd30] = 32'd30;
		bancoReg[32'd31] = 32'd31;
	end 
	
	always @(posedge clock) begin //Durante a subida do clock o Banco de reg escolherá entra a função Out e as outras
		if (sinalDoOut)
			saidaDisplay <= bancoReg[32'd10]; // O reg10 é um registrador reservado para mandar o seu valor para o dispositivo de saída. 
		else begin
			if(sinalDeTroca) begin
				RegA <= bancoReg[apontaRegDestino];
				RegB <= bancoReg[apontaRegPrimario];
			end
			else begin
				RegA <= bancoReg[apontaRegPrimario];
				RegB <= bancoReg[apontaRegSecundario];
			end
		end
	end
	
	always @(negedge clock) begin
		if(reset) begin
			bancoReg[32'd0] <= 32'd0;
			bancoReg[32'd1] <= 32'd0;
			bancoReg[32'd2] <= 32'd0;
			bancoReg[32'd3] <= 32'd0;
			bancoReg[32'd4] <= 32'd0;
			bancoReg[32'd5] <= 32'd0;
			bancoReg[32'd6] <= 32'd0;
			bancoReg[32'd7] <= 32'd0;
			bancoReg[32'd8] <= 32'd0;
			bancoReg[32'd9] <= 32'd0;
			bancoReg[32'd10] <= 32'd0;
			bancoReg[32'd11] <= 32'd0;
			bancoReg[32'd12] <= 32'd0;
			bancoReg[32'd13] <= 32'd0;
			bancoReg[32'd14] <= 32'd0;
			bancoReg[32'd15] <= 32'd0;
			bancoReg[32'd16] <= 32'd0;
			bancoReg[32'd17] <= 32'd0;
			bancoReg[32'd18] <= 32'd0;
			bancoReg[32'd19] <= 32'd0;
			bancoReg[32'd20] <= 32'd0;
			bancoReg[32'd21] <= 32'd0;
			bancoReg[32'd22] <= 32'd0;
			bancoReg[32'd23] <= 32'd0;
			bancoReg[32'd24] <= 32'd0;
			bancoReg[32'd25] <= 32'd0;
			bancoReg[32'd26] <= 32'd0;
			bancoReg[32'd27] <= 32'd0;
			bancoReg[32'd28] <= 32'd0;
			bancoReg[32'd29] <= 32'd0;
			bancoReg[32'd30] <= 32'd0;
			bancoReg[32'd31] <= 32'd0;
		end
		else begin
			if(sinalEscritaBancoReg) begin 
				if(sinalDoIn)
					bancoReg[5'b00101] <= dadoMemory; 
				else begin
					if(sinalDado == 1'b0) begin 
						if(apontaRegDestino != 32'b0)
							bancoReg[apontaRegDestino] <= dadoMemory; 
					end
					else begin 
						if(apontaRegDestino != 32'b0)
								bancoReg[apontaRegDestino] <= dadoULA; 
					end
				end
			end
			else begin
				saidaRegA <= RegA;
				saidaRegB <= RegB;
			end
		end
	end
		
		
endmodule
