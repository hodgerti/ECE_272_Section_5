module LED_top_module( 
	/**************************/
	/* Set inputs and outputs */
	/* to the whole FPGA here */
	/**************************/
	input logic reset_n, //be sure to set this input to PullUp, or connect the pin to 3.3V
	input logic [15:0] buttons,
	output logic [2:0] state,
	output logic led_segs [0:6],
	input logic clock_in,
	output logic [7:0] LEDS
	);

		logic clk_slow;	//used for slowed down, 5 Hz clock
		logic [3:0] parser_to_decoder; //wire from parser to decoder
		

		clock_counter counter_1(
			.clk_i(clock_in),
			.reset_n(reset_n),
			.clk_o(clk_slow));

		state_machine FSM_1(
			.clk_i(clk_slow),
			.reset_n(reset_n),
			.state(state));
			
		ShumanParser parser(
			.displayValue(buttons),
			.digitSelect(state),
			.displayDigit(parser_to_decoder),
			.LEDs(LEDS));
			
		sevenseg decoder(
			.data(parser_to_decoder),
			.segments(led_segs));
		
endmodule
