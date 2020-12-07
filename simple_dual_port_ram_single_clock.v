	// Quartus Prime Verilog Template
// Simple Dual Port RAM with separate read/write addresses and
// single read/write clock

module simple_dual_port_ram_single_clock
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=9, parameter num = 200)
(	
	input mux,
	input [(DATA_WIDTH-1):0] dado,
	input [(ADDR_WIDTH-1):0] enderecoPC, enderecoALUOut,
	input sinalEscritaMemoria, clock,
	output [(DATA_WIDTH-1):0] instrucao, 
	output [(DATA_WIDTH-1):0] memoryData
);
	
	integer endereco;
	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

	// Specify the initial contents.  You can also use the $readmemb
	// system task to initialize the RAM variable from a text file.
	// See the $readmemb template page for details.
	initial 
	begin : INIT 	
			ram[512'd0] = {6'd0,5'd1,5'd0,16'd2}; // r[1] = r[0] + 02
			ram[512'd4] = {6'd16,5'd1,5'd11,16'd5}; // if( r[1] < r[11])? PC + 4 : PC + (5 * 4)
			ram[512'd8] = {6'd0,5'd1,5'd1,16'd1}; // r[1] = r[1] + 1
			ram[512'd12] = {6'd63,5'd10,5'd1,5'd0,5'd0,6'd0}; // r[10] = r[1] + r[0]
			ram[512'd16] = {6'd23,5'd0,5'd0,5'd0,5'd0,6'd0}; // Out = r[10]
			ram[512'd20] = {6'd19,26'd1}; // jump to mem[4*1]
			ram[512'd24] = {6'd22,5'd0,5'd0,5'd0,5'd0,6'd0}; // r[5] = In
			ram[512'd28] = {6'd63,5'd1,5'd1,5'd5,5'd0,6'd2}; // r[1] = r[1] * r[5]
			ram[512'd32] = {6'd20,5'd0,5'd1,16'd60}; // mem[50 + r[0]] = r[1]
			ram[512'd36] = {6'd63,5'd1,5'd21,5'd7,5'd0,6'd3}; // r[1] = r[21] / r[7]
			ram[512'd40] = {6'd21,5'd7,5'd0,16'd60}; // r[7] = mem[50 + r[0]]
			ram[512'd44] = {6'd63,5'd10,5'd7,5'd1,5'd0,6'd0}; // r[10] = r[7] + r[1]
			ram[512'd48] = {6'd23,5'd0,5'd7,5'd7,5'd0,6'd0}; // Out = r[10]*/
			//ram[512'd16] = 32'b010101 00000 00000 00000 00000 000000;
	end 

	always @ (posedge clock)
	begin
		// Write
		if (sinalEscritaMemoria == 1'b1)
			ram[enderecoALUOut] <= dado;
	end

	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.  
	assign instrucao = ram[enderecoPC];
	assign memoryData = ram[enderecoALUOut];

endmodule

