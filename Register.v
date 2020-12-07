module Register (

	input clock,
	input [31:0] instrucao,
	output [31:0] reginst
	);
	
	reg [31:0] register;
	
	always @(negedge clock) begin

		register <= instrucao;
	end
	
	assign reginst = register;
endmodule 