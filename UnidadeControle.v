module UnidadeControle (
	
	input clock,
	input confirmaEntrada, // botão para confirmar a escrita de dado
	input [5:0] opcode,
	input [5:0] funct,
	input SaidaULAAritmetica,
	
	output reg [1:0] muxPC,
	
	output reg escritaMemoria,
	
	output reg muxMemData,
	
	output reg sinalTroca,
	output reg sinalIn,
	output reg sinalOut,
	output reg muxBancoReg,
	output reg escritaBanco,
	
	output reg muxULA,
	output reg [1:0] muxULAII,
	output reg [5:0] sinalULA,
	
	output reg sinalDisplay,
	output reg [2:0] proxEstado
   );
	
	//reg [3:0] proxEstado;
	
	initial
	begin: INIT
		proxEstado = 3'b000;
	end	
	
	parameter CICLOI = 3'b000;
	parameter CICLOII = 3'b001;
	parameter CICLOIII = 3'b010;
	parameter CICLOIV = 3'b011; 
	parameter CICLOV = 3'b100; 
	parameter CICLOVI = 3'b101;
	

	
	always @ (posedge clock) begin
		case (proxEstado)
		CICLOI: begin //PRIMEIRA ETAPA IGUAL PARA TODOS
			sinalDisplay <= 1'b0;
			muxMemData <= 1'b0;
			muxPC <= 2'b00; //Mantem o PC com o mesmo resultado
			escritaMemoria <= 1'b0; //Desabilita a escrita na memoria
			sinalTroca <= 1'b0; 
			sinalIn <= 1'b0;
			sinalOut <= 1'b0;
			muxBancoReg <= 1'b0;
			escritaBanco <= 1'b0; //Desabilita a escrita no Banco de Registradores
			muxULA <= 1'b0; 
			muxULAII <= 2'b00;
			sinalULA <= 6'd0;
			proxEstado <= CICLOII;
			
			// O ENDERECO CONTIDO NO PC É ACESSADO NA MEMORIA
			//A MEMORIA PASSA A INSTRUÇÃO PARA O REGINST
		end
		
		CICLOII: begin	
			
			if(opcode == 6'd63)begin //OPERAÇÃO DO TIPO R
				muxPC <= 2'b00; //Mantem o PC com o mesmo resultado
				escritaMemoria <= 1'b0; //Desabilita a escrita na memoria
				muxMemData <= 1'b0;
				sinalTroca <= 1'b0; //Faz o RegA receber o RP e o RegB receber o Rs
				sinalIn <= 1'b0; // Desabilita a função de entrada
				sinalOut <= 1'b0; //Desabilita a função de saida
				muxBancoReg <= 1'b0; 
				escritaBanco <= 1'b0; //Desabilita a escrita no Banco de Registradores
				muxULA <= 1'b0; 
				muxULAII <= 2'b00;
				sinalULA <= 6'd0;
				sinalDisplay <= 1'b0;
				proxEstado <= CICLOIII;
			end
			
			if (opcode == 6'd0 || opcode == 6'd1 || opcode == 6'd2 || opcode == 6'd3 || opcode == 6'd4 || opcode == 6'd5 || opcode == 6'd6 || opcode == 6'd7 || opcode == 6'd8 || opcode == 6'd9 || opcode == 6'd10 || opcode == 6'd11 || opcode == 6'd12) begin //TIPO LOGICO E ARITMETICO
				muxPC <= 2'b00; //Mantem o PC com o mesmo resultado
				escritaMemoria <= 1'b0; //Desabilita a escrita na memoria
				muxMemData <= 1'b0;
				sinalTroca <= 1'b0; //Faz o RegA receber o RP e o RegB receber o Rs
				sinalIn <= 1'b0; // Desabilita a função de entrada
				sinalOut <= 1'b0; //Desabilita a função de saida
				muxBancoReg <= 1'b0; 
				escritaBanco <= 1'b0; //Desabilita a escrita no Banco de Registradores
				muxULA <= 1'b0; 
				muxULAII <= 2'b00;
				sinalULA <= 6'd0;
				sinalDisplay <= 1'b0;
				proxEstado <= CICLOIII;
			end
			
			if (opcode == 6'd13 || opcode == 6'd14 || opcode == 6'd15 || opcode == 6'd16 || opcode == 6'd17 || opcode == 6'd18) begin //DESVEIO
				muxPC <= 2'b00; //Mantem o PC com o mesmo resultado
				escritaMemoria <= 1'b0; //Desabilita a escrita na memoria
				muxMemData <= 1'b0;
				sinalTroca <= 1'b1; //Faz o RegA receber o Rd e o RegB receber o Rp
				sinalIn <= 1'b0; // Desabilita a função de entrada
				sinalOut <= 1'b0; //Desabilita a função de saida
				muxBancoReg <= 1'b0; 
				escritaBanco <= 1'b0; //Desabilita a escrita no Banco de Registradores
				muxULA <= 1'b0; 
				muxULAII <= 2'b00;
				sinalULA <= 6'd0;
				sinalDisplay <= 1'b0;
				proxEstado <= CICLOIII;
			end
			
			if (opcode == 6'd19) begin //JUMP
				muxPC <= 2'b01; //Mantem o PC com o mesmo resultado
				escritaMemoria <= 1'b0; //Desabilita a escrita na memoria
				muxMemData <= 1'b0;
				sinalTroca <= 1'b0; //Faz o RegA receber o Rd e o RegB receber o Rp
				sinalIn <= 1'b0; // Desabilita a função de entrada
				sinalOut <= 1'b0; //Desabilita a função de saida
				muxBancoReg <= 1'b0; 
				escritaBanco <= 1'b0; //Desabilita a escrita no Banco de Registradores
				muxULA <= 1'b0; 
				muxULAII <= 2'b00;
				sinalULA <= 6'd0;	
				sinalDisplay <= 1'b0;
				proxEstado <= CICLOI;
			end
			
			if(opcode == 6'd20) begin //STORE WORD   => mem[Rp + Imed] = Rd
				muxPC <= 2'b00; //Mantem o PC com o mesmo resultado
				escritaMemoria <= 1'b0; //Desabilita a escrita na memoria
				muxMemData <= 1'b0;
				sinalTroca <= 1'b1; //Faz o RegA receber o Rd e o RegB receber o Rp
				sinalIn <= 1'b0; // Desabilita a função de entrada
				sinalOut <= 1'b0; //Desabilita a função de saida
				muxBancoReg <= 1'b0; 
				escritaBanco <= 1'b0; //Desabilita a escrita no Banco de Registradores
				muxULA <= 1'b0; 
				muxULAII <= 2'b00;
				sinalULA <= 6'd0;	
				sinalDisplay <= 1'b0;
				proxEstado <= CICLOIII;
			end
			if(opcode == 6'd21)begin //LOAD WORD   => Rd = mem[Rp + Imed]
				muxPC <= 2'b00; //Mantem o PC com o mesmo resultado
				escritaMemoria <= 1'b0; //Desabilita a escrita na memoria
				muxMemData <= 1'b0;
				sinalTroca <= 1'b0; //Faz o RegA receber o Rp e o RegB receber o Rs
				sinalIn <= 1'b0; // Desabilita a função de entrada
				sinalOut <= 1'b0; //Desabilita a função de saida
				muxBancoReg <= 1'b0; 
				escritaBanco <= 1'b0; //Desabilita a escrita no Banco de Registradores
				muxULA <= 1'b0; 
				muxULAII <= 2'b00;
				sinalULA <= 6'd0;	
				sinalDisplay <= 1'b0;
				proxEstado <= CICLOIII;
			end
			if(opcode == 6'd22)begin //IN
				muxPC <= 2'b00; //Mantem o PC com o mesmo resultado
				escritaMemoria <= 1'b0; //Desabilita a escrita na memoria
				muxMemData <= 1'b1;
				sinalTroca <= 1'b0; //Faz o RegA receber o Rp e o RegB receber o Rs
				sinalIn <= 1'b1; // Desabilita a função de entrada
				sinalOut <= 1'b0; //Desabilita a função de saida
				muxBancoReg <= 1'b0; 
				escritaBanco <= 1'b0; //Desabilita a escrita no Banco de Registradores
				muxULA <= 1'b0; 
				muxULAII <= 2'b00;
				sinalULA <= 6'd0;	
				sinalDisplay <= 1'b0;
				if(confirmaEntrada)
					proxEstado <= CICLOIII;
				else
					proxEstado <= CICLOII;
			end
			if(opcode == 6'd23)begin //OUT
				muxPC <= 2'b00; //Mantem o PC com o mesmo resultado
				escritaMemoria <= 1'b0; //Desabilita a escrita na memoria
				muxMemData <= 1'b0;
				sinalTroca <= 1'b0; //Faz o RegA receber o Rp e o RegB receber o Rs
				sinalIn <= 1'b0; // Desabilita a função de entrada
				sinalOut <= 1'b1; //Desabilita a função de saida
				muxBancoReg <= 1'b0; 
				escritaBanco <= 1'b0; //Desabilita a escrita no Banco de Registradores
				muxULA <= 1'b0; 
				muxULAII <= 2'b00;
				sinalULA <= 6'd0;	
				sinalDisplay <= 1'b0;
				proxEstado <= CICLOIII;
			end
		end
		
		CICLOIII: begin
			muxMemData <= 1'b0;
			if(opcode == 6'd63)begin //OPERAÇÃO DO TIPO R
				muxPC <= 2'b00; //Mantem o PC com o mesmo resultado
				sinalDisplay <= 1'b0;
				escritaMemoria <= 1'b0; //Desabilita a escrita na memoria
				sinalTroca <= 1'b0; 
				sinalIn <= 1'b0; // Desabilita a função de entrada
				sinalOut <= 1'b0; //Desabilita a função de saida
				muxBancoReg <= 1'b0; 
				escritaBanco <= 1'b0; //Desabilita a escrita no Banco de Registradores
				muxULA <= 1'b1; 
				muxULAII <= 2'b00; // Escolhe o RegB como segunda entrada da ULA
				sinalULA <= funct; //A ULA irá fazer a operação que está descrita no funct
				proxEstado <= CICLOIV;
			end
			
			if (opcode == 6'd0 || opcode == 6'd1 || opcode == 6'd2 || opcode == 6'd3 || opcode == 6'd4 || opcode == 6'd5 || opcode == 6'd6 || opcode == 6'd7 || opcode == 6'd8 || opcode == 6'd9 || opcode == 6'd10 || opcode == 6'd11 || opcode == 6'd12) begin //TIPO LOGICO E ARITMETICO
				muxPC <= 2'b00; //Mantem o PC com o mesmo resultado
				sinalDisplay <= 1'b0;
				escritaMemoria <= 1'b0; //Desabilita a escrita na memoria
				sinalTroca <= 1'b0;
				sinalIn <= 1'b0; // Desabilita a função de entrada
				sinalOut <= 1'b0; //Desabilita a função de saida
				muxBancoReg <= 1'b0; 
				escritaBanco <= 1'b0; //Desabilita a escrita no Banco de Registradores
				muxULA <= 1'b1; 
				muxULAII <= 2'b10; //Escolhe o Imediato como a segunda entrada da ULA
				sinalULA <= opcode;
				proxEstado <= CICLOIV;
			end
			
			if (opcode == 6'd13 || opcode == 6'd14 || opcode == 6'd15 || opcode == 6'd16 || opcode == 6'd17 || opcode == 6'd18) begin //DESVEIO
				muxPC <= 2'b00; //Mantem o PC com o mesmo resultado
				sinalDisplay <= 1'b0;
				escritaMemoria <= 1'b0; //Desabilita a escrita na memoria
				sinalTroca <= 1'b1; 
				sinalIn <= 1'b0; // Desabilita a função de entrada
				sinalOut <= 1'b0; //Desabilita a função de saida
				muxBancoReg <= 1'b0; 
				escritaBanco <= 1'b0; //Desabilita a escrita no Banco de Registradores
				muxULA <= 1'b1;
				muxULAII <= 2'b00;
				sinalULA <= opcode;
				proxEstado <= CICLOIV;
			end
			
			if(opcode == 6'd20) begin //STORE WORD
				muxPC <= 2'b00; //Mantem o PC com o mesmo resultado
				sinalDisplay <= 1'b0;
				escritaMemoria <= 1'b0; //Desabilita a escrita na memoria
				sinalTroca <= 1'b1; //Faz o RegA receber o Rp e o RegB receber o Rs
				sinalIn <= 1'b0; // Desabilita a função de entrada
				sinalOut <= 1'b0; //Desabilita a função de saida
				muxBancoReg <= 1'b0; 
				escritaBanco <= 1'b0; //Desabilita a escrita no Banco de Registradores
				muxULA <= 1'b1; 
				muxULAII <= 2'b10;
				sinalULA <= 6'd0;	
				proxEstado <= CICLOIV;
			end
			if(opcode == 6'd21)begin //LOAD WORD
				muxPC <= 2'b00; //Mantem o PC com o mesmo resultado
				sinalDisplay <= 1'b0;
				escritaMemoria <= 1'b0; //Desabilita a escrita na memoria
				muxMemData <= 1'b0;
				sinalTroca <= 1'b0; //Faz o RegA receber o Rp e o RegB receber o Rs
				sinalIn <= 1'b0; // Desabilita a função de entrada
				sinalOut <= 1'b0; //Desabilita a função de saida
				muxBancoReg <= 1'b1; 
				escritaBanco <= 1'b0; //Desabilita a escrita no Banco de Registradores
				muxULA <= 1'b1; 
				muxULAII <= 2'b10;
				sinalULA <= 6'd0;	
				proxEstado <= CICLOIV;
			end
			
			if(opcode == 6'd22)begin //IN
				muxPC <= 2'b00; //Mantem o PC com o mesmo resultado
				escritaMemoria <= 1'b0; //Desabilita a escrita na memoria
				muxMemData <= 1'b1;
				sinalTroca <= 1'b0; //Faz o RegA receber o Rp e o RegB receber o Rs
				sinalIn <= 1'b1; // Desabilita a função de entrada
				sinalOut <= 1'b0; //Desabilita a função de saida
				muxBancoReg <= 1'b0; 
				escritaBanco <= 1'b1; //Desabilita a escrita no Banco de Registradores
				muxULA <= 1'b0; 
				muxULAII <= 2'b00;
				sinalULA <= 6'd0;	
				sinalDisplay <= 1'b0;
				proxEstado <= CICLOVI;
			end
			
			if(opcode == 6'd23)begin //OUT
				muxPC <= 2'b00; //Mantem o PC com o mesmo resultado
				escritaMemoria <= 1'b0; //Desabilita a escrita na memoria
				muxMemData <= 1'b0;
				sinalTroca <= 1'b0	; //Faz o RegA receber o Rp e o RegB receber o Rs
				sinalIn <= 1'b0; // Desabilita a função de entrada
				sinalOut <= 1'b1; //Desabilita a função de saida
				muxBancoReg <= 1'b0; 
				escritaBanco <= 1'b0; //Desabilita a escrita no Banco de Registradores
				muxULA <= 1'b0; 
				muxULAII <= 2'b00;
				sinalULA <= 6'd0;	
				sinalDisplay <= 1'b1;
				proxEstado <= CICLOVI;
			end
		end
		
		CICLOIV: begin
			if(opcode == 6'd63)begin //OPERAÇÃO DO TIPO R
				muxPC <= 2'b00; //Mantem o PC com o mesmo resultado
				escritaMemoria <= 1'b0; //Desabilita a escrita na memoria
				muxMemData <= 1'b0;
				sinalTroca <= 1'b0; 
				sinalIn <= 1'b0; // Desabilita a função de entrada
				sinalOut <= 1'b0; //Desabilita a função de saida
				muxBancoReg <= 1'b1; //Escolhe o dado do ALUOut para ser salvo em Rd
				escritaBanco <= 1'b1; //Habilita a escrita no Banco de Registradores
				muxULA <= 1'b1; 
				muxULAII <= 2'b00; 
				sinalULA <= funct;
				sinalDisplay <= 1'b0;
				proxEstado <= CICLOVI;
			end
			if (opcode == 6'd0 || opcode == 6'd1 || opcode == 6'd2 || opcode == 6'd3 || opcode == 6'd4 || opcode == 6'd5 || opcode == 6'd6 || opcode == 6'd7 || opcode == 6'd8 || opcode == 6'd9 || opcode == 6'd10 || opcode == 6'd11 || opcode == 6'd12) begin //TIPO LOGICO E ARITMETICO
				muxPC <= 2'b00; //Mantem o PC com o mesmo resultado
				escritaMemoria <= 1'b0; //Desabilita a escrita na memoria
				muxMemData <= 1'b0;
				sinalTroca <= 1'b0; 
				sinalIn <= 1'b0; // Desabilita a função de entrada
				sinalOut <= 1'b0; //Desabilita a função de saida
				muxBancoReg <= 1'b1; //Escolhe o dado do ALUOut para ser salvo em Rd
				escritaBanco <= 1'b1; //Habilita a escrita no Banco de Registradores
				muxULA <= 1'b0; //escolhe o Program counter como primeira entrada da ULA
				muxULAII <= 2'b10; //escolhe o imediato estendido e deslocado como segunda entrada da ULA
				sinalULA <= opcode;
				sinalDisplay <= 1'b0;
				proxEstado <= CICLOVI;
			end
			if (opcode == 6'd13 || opcode == 6'd14 || opcode == 6'd15 || opcode == 6'd16 || opcode == 6'd17 || opcode == 6'd18) begin //DESVEIO
				muxPC <= 2'b10; //Mantem o PC com o mesmo resultado
				sinalDisplay <= 1'b0;
				escritaMemoria <= 1'b0; //Desabilita a escrita na memoria
				sinalTroca <= 1'b1; 
				sinalIn <= 1'b0; // Desabilita a função de entrada
				sinalOut <= 1'b0; //Desabilita a função de saida
				muxBancoReg <= 1'b0; 
				escritaBanco <= 1'b0; //Desabilita a escrita no Banco de Registradores
				muxULA <= 1'b1;
				muxULAII <= 2'b00;
				sinalULA <= opcode;
				sinalDisplay <= 1'b0;
				proxEstado <= CICLOI;
			end
			if(opcode == 6'd20) begin //STORE WORD
				muxPC <= 2'b00; //Mantem o PC com o mesmo resultado
				escritaMemoria <= 1'b1; //Habilita a escrita na memoria
				muxMemData <= 1'b0;
				sinalTroca <= 1'b0; //Faz o RegA receber o Rd e o RegB receber o Rp
				sinalIn <= 1'b0; // Desabilita a função de entrada
				sinalOut <= 1'b0; //Desabilita a função de saida
				muxBancoReg <= 1'b0; 
				escritaBanco <= 1'b0; //Desabilita a escrita no Banco de Registradores
				muxULA <= 1'b1; 
				muxULAII <= 2'b10;
				sinalULA <= 6'd0;	
				sinalDisplay <= 1'b0;
				proxEstado <= CICLOVI;
			end
			if(opcode == 6'd21)begin //LOAD WORD
				muxPC <= 2'b00; //Mantem o PC com o mesmo resultado
				escritaMemoria <= 1'b0; //Desabilita a escrita na memoria
				muxMemData <= 1'b0; 
				sinalTroca <= 1'b0; //Faz o RegA receber o Rp e o RegB receber o Rs
				sinalIn <= 1'b0; // Desabilita a função de entrada
				sinalOut <= 1'b0; //Desabilita a função de saida
				muxBancoReg <= 1'b0; 
				escritaBanco <= 1'b0; //Desabilita a escrita no Banco de Registradores
				muxULA <= 1'b1; 
				muxULAII <= 2'b10;
				sinalULA <= 6'd0;	
				sinalDisplay <= 1'b0;							
				proxEstado <= CICLOV;
			end
		end
		
		CICLOV: begin			
			if(opcode == 6'd21)begin //LOAD WORD
				muxPC <= 2'b00; //Mantem o PC com o mesmo resultado
				escritaMemoria <= 1'b0; //Desabilita a escrita na memoria
				muxMemData <= 1'b0; 
				sinalTroca <= 1'b0; //Faz o RegA receber o Rp e o RegB receber o Rs
				sinalIn <= 1'b0; // Desabilita a função de entrada
				sinalOut <= 1'b0; //Desabilita a função de saida
				muxBancoReg <= 1'b0; 
				escritaBanco <= 1'b1; //Desabilita a escrita no Banco de Registradores
				muxULA <= 1'b0; 
				muxULAII <= 2'b00;
				sinalULA <= 6'd0;	
				muxMemData <= 1'b1;
				sinalDisplay <= 1'b0;
				proxEstado <= CICLOVI;
			end
		end
		
		CICLOVI: begin
			muxMemData <= 1'b0;
			sinalDisplay <= 1'b0;
			muxPC <= 2'b11; //Depois de toda operação ser realizada, o Program counter será atualizado
			escritaMemoria <= 1'b0; //Desabilita a escrita na memoria
			sinalTroca <= 1'b0; 
			sinalIn <= 1'b0; // Desabilita a função de entrada
			sinalOut <= 1'b0; //Desabilita a função de saida
			muxBancoReg <= 1'b0; 
			escritaBanco <= 1'b0; //Desabilita a escrita no Banco de Registradores
			//muxULA <= 1'b0; 
			//muxULAII <= 2'b00; 
			sinalULA <= 6'd0;
			proxEstado <= CICLOI;
		end
		endcase
	
	end
endmodule
