module ADC_normalizer (
	input logic [15:0] raw_input,
	output logic [15:0] raw_output
);

	assign raw_output = (raw_input * 3300)/((2**16)-1);
	 
endmodule