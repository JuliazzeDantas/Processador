// bloqueante a = b  --> Procedual, Estruturado
// não-bloqueante a <= b  --> Paralelismo
// abrir bloco de execução: alawys @("Condição de entrada") begin{ "Texto" }end
// abrir for: for("variavel" = "valorFinal" ; "variavel" = "valorFinal" ; "Condição de valor ir de inicial para final") begin { "Texto" } end
// inicializar variavel fora do always: initial begin { "Texto inicializando variaveis" } end
// inicializando ifelse em uma linha:  ("Variavel" == "Condição")?"Se sim, faz essa parte":"Caso não, faz essa parte";
//



module Processador(
	input clock,
	
	input reset,
	
	input [15:0] dispositivoDeEntrada,
	input confirmaEntrada,
	
	output reg [31:0] dispositivoDeSaida,
	
	output reg [5:0] opcode, //teste
	output reg saidaLogicaULA,
	
	output reg [31:0] saidaPC,
	output reg [31:0] saidaMemoria,
	
	output reg [31:0]RA,
	output reg [31:0]RB,
	output reg [31:0]regInst,
	
	output reg [15:0]imed,
	
	output reg [5:0]controleULA,
	
	output reg [1:0]muxPC,
	
	output reg [2:0]estado,
	
	output reg sinalInst,
	
	output reg [31:0] Data,
	output reg [31:0] RData,
	output reg [31:0] saidaUla,
	output reg sinalDisplay
	);
	
	initial begin:INIT
		sinalDisplay = 0;
	end
	
	wire [1:0] MUXPC;
	
	wire MUXMEMORIA;
	wire ESCRITAMEMORIA;
	
	wire MUXMEMDATA;
	wire [31:0] MEMORYDATA;
	wire [31:0] REGMEMORYDATA;
	
	wire [3:0] Estado;
	
	wire SINALTROCA;
	wire SINALIN;
	wire SINALOUT;
	
	wire MUXBANCOREG;
	wire ESCRITABANCO;
	
	wire MUXULA;
	wire [1:0]MUXULAII;
	wire [5:0]SINALULA;
	
	wire SINALDISPLAY;
	
	wire [31:0] ENDERECO; //O Program Counter guarda o endereço que será acessado na memória
	wire [31:0] INSTRUCAO; //o endereço acessado contém um código que será usado nas demais etapas
	wire [31:0] REGINST;	
	wire [31:0] JUMPER;
	
	wire [31:0] REGA;
	wire [31:0] REGB;
	
	wire [31:0] SAIDAULA;
	wire LOGICAULA;
	
	wire [31:0] SAIDADISPLAY;
	
	UnidadeControle UC (.proxEstado(Estado), .clock(clock), .confirmaEntrada(confirmaEntrada), .opcode(INSTRUCAO[31:26]), .funct(INSTRUCAO[5:0]), .SaidaULAAritmetica(LOGICAULA), .muxPC(MUXPC), .escritaMemoria(ESCRITAMEMORIA), .muxMemData(MUXMEMDATA),	.sinalTroca(SINALTROCA), .sinalIn(SINALIN), .sinalOut(SINALOUT), .muxBancoReg(MUXBANCOREG), .escritaBanco(ESCRITABANCO), .muxULA(MUXULA), .muxULAII(MUXULAII), .sinalULA(SINALULA), .sinalDisplay(SINALDISPLAY));
	
	//DivisorDeFrequencia DF (.clockPlaca(clk), .clock(clock));
	
	PC ProgramCounter(.clock(clock), .reset(reset), .controladorMuxPC(MUXPC), .jump(JUMPER), .desvio(SAIDAULA), .saidaPC(ENDERECO));
	
	simple_dual_port_ram_single_clock Memoria (.mux(MUXMEMORIA), .dado(REGB), .enderecoPC(ENDERECO), .enderecoALUOut(SAIDAULA), .sinalEscritaMemoria(ESCRITAMEMORIA), .clock(clock), .instrucao(REGINST), .memoryData(MEMORYDATA));
	
	Register Reg (.clock(clock), .instrucao(REGINST), .reginst(INSTRUCAO));
	
	MemData MemData (.mux(MUXMEMDATA), .entrada(dispositivoDeEntrada), .clock(clock), .dado(MEMORYDATA), .regMemoryData(REGMEMORYDATA));
	
	BancoDeRegistradores BancoRegistradores (.saidaDisplay(SAIDADISPLAY), .clock(clock), .apontaRegPrimario(INSTRUCAO[20:16]), .apontaRegSecundario(INSTRUCAO[15:11]), .apontaRegDestino(INSTRUCAO[25:21]), .sinalDeTroca(SINALTROCA), .sinalDado(MUXBANCOREG), .dadoULA(SAIDAULA), .dadoMemory(REGMEMORYDATA), .sinalEscritaBancoReg(ESCRITABANCO), .sinalDoIn(SINALIN), .sinalDoOut(SINALOUT), .reset(reset), .saidaRegA(REGA), .saidaRegB(REGB));
	
	Jumper Jump(.clock(clock), .endereco((INSTRUCAO[25:0] << 2'b10)), .programCounter(ENDERECO), .jump(JUMPER));
	
	ULA ULA (.clock(clock), .muxULA(MUXULA), .muxULAII(MUXULAII), .regA(REGA), .programCounter(ENDERECO), .regB(REGB), .shamit(INSTRUCAO[10:6]), .imediato(INSTRUCAO[15:0]), .sinalControle(SINALULA), .saidaLogicaULA(LOGICAULA), .saidaAritmeticaULA(SAIDAULA));
	
	DISP DISP (.Disp0(), .Disp1(), .Disp2(), .Disp3(), .Disp4(), .Disp5(), .Disp6(), .SinalUC(), .clock(clock), .mod0(), .mod1(), .mod2(), .mod3(), .mod4(), .mod5(), .mod6());
	
	always @(clock) begin
		regInst <= INSTRUCAO;
		saidaLogicaULA <= LOGICAULA;
		opcode <= INSTRUCAO[31:26];
		imed <= INSTRUCAO[15:0];
		saidaUla <= SAIDAULA;
		saidaPC <= ENDERECO;
		saidaMemoria <= REGINST;
		RA <= REGA;
		RB <= REGB;
		controleULA <= SINALULA;
		muxPC <= MUXPC;
		estado <= Estado;
		Data <= MEMORYDATA;
		RData <= REGMEMORYDATA;
		sinalInst <= MUXMEMDATA;
		sinalDisplay <= SINALDISPLAY;
		if (SINALDISPLAY)
			dispositivoDeSaida <= SAIDADISPLAY;
	end
	
	
endmodule
