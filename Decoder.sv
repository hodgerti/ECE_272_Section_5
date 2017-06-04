module sevenseg( input [3:0] data,
					output reg [6:0] segments );
	always @(*)
		case( data ) // 7'bABCDEFG
			0: segments = 7'b0000001;
			1: segments = 7'b1001111;
			2: segments = 7'b0010010;
			3: segments = 7'b0000110;
			4: segments = 7'b1001100;
			5: segments = 7'b0100100;
			6: segments = 7'b0100000;
			7: segments = 7'b0001111;
			8: segments = 7'b0000000;
			9: segments = 7'b0001100;
			default:segments = 7'b0000000;
		endcase
endmodule