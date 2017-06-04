module top (
	output logic RST_ADC,
	input logic DOUT_ADC,
	output logic DIN_ADC,
	output logic SCK_ADC,
	input logic reset,
	output logic [6:0] segs,
	output logic [2:0] state_sel,
	output logic [7:0] board_LEDs);
	
	logic [15:0] raw_in;
	logic [15:0] button_in;
	logic clk_signal;
	
	adc ADC (
		.reset(reset),
		.clk_2Mhz(clk_signal),
		.MISO(DOUT_ADC),
		.raw_data(raw_in),
		.MOSI(DIN_ADC),
		.adc_reset(RST_ADC),
		.SCK(SCK_ADC));
	
	LED_top_module led_display (
		.buttons(button_in),
		.reset_n(reset),
		.state(state_sel),
		.led_segs(segs),
		.clock_in(clk_signal),
		.LEDS(board_LEDs));
		
	ADC_normalizer adx(
		.raw_input(raw_in),
		.raw_output(button_in));
		
	OSCH #("2.08") osc_int (				
			.STDBY(1'b0),		
			.OSC(clk_signal),		
			.SEDSTDBY());	
endmodule
	