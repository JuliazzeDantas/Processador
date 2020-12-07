module MemData (
	input mux,
	input [15:0] entrada,
	input clock,
	input [31:0] dado,
	output [31:0] regMemoryData
	);
	
	reg [31:0] MemoryData;
	
	always @(negedge clock) begin
	
		if(mux)
			MemoryData <= entrada;
		else
			MemoryData <= dado;
			
	end
	
	assign regMemoryData = MemoryData;
	
endmodule 