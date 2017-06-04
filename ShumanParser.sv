//////////////////////////////////////////////////////////////////////////////////
// Company:        Oregon State University
// Engineer:       Matthew Shuman
// 
// Create Date:    05/01/2017 
// Design Name:    Student Nudge
// Module Name:    FourDigitParser
// Project Name:   Educate Students
// Target Devices: MachX03
// Tool versions:  Lattice Diamond 3.7
// Description:    This is given to students to help them finish lab 4, one week sooner, due to a 
// 		   sooner than expected ENGR Expo in Spring 2017.   
//
// Dependencies:   One of the synthesizers with Lattice SE will not synthesize the / or % by 10 operator
//		   correctly.  I recommend using Synplify Pro for the project synthesis.
// Revision: 
// Revision 0.01 - File Created
// additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ShumanParser(
 input logic [15:0] displayValue,  	// The value that gets split and displayed on the display, number ranges go 0-9999.
 output logic [3:0] displayDigit,     	// The split value 
 input logic [2:0] digitSelect,   	// 00 -> LSB, 01, 10, 11 <- MSB
 output logic [7:0] LEDs
 );
 
logic [3:0] thousands;
logic [3:0] hundreds;
logic [3:0] tens;
logic [3:0] ones;

DigitSeparator i3(
	.displayValue	(displayValue),
	.thousands	(thousands),
	.hundreds	(hundreds),
	.tens		(tens),
	.ones		(ones)
);

FourToOneMux i4(
	.thousands	(thousands),
	.hundreds	(hundreds),
	.tens		(tens),
	.ones		(ones),
	.digitCount	(digitSelect),
	.value		(displayDigit)
);
	
	always_comb begin
		if (digitSelect === 3'd4) begin	//out most signficant digit onto board LEDS
			LEDs[0] = displayValue[15];
			LEDs[1] = displayValue[14];
			LEDs[2] = displayValue[13];
			LEDs[3] = displayValue[12];
			LEDs[4] = displayValue[11];
			LEDs[5] = displayValue[10];
			LEDs[6] = displayValue[9];
			LEDs[7] = displayValue[8];
		end
	end


endmodule


//__________________________________________________


module DigitSeparator(
 input logic [15:0] displayValue, //
 output logic [3:0] thousands,     //the MSB digit
 output logic [3:0] hundreds,      //the 100's digit
 output logic [3:0] tens,          //the 10's digit
 output logic [3:0] ones          //the LSB digit
 ); 

   assign thousands = (displayValue / 1000) % 10; //MSB Display
   assign hundreds = (displayValue / 100) % 10;
   assign tens = (displayValue / 10) % 10;
   assign ones = displayValue % 10;

endmodule


//__________________________________________________


module FourToOneMux(
 input logic [2:0] digitCount,    //11 -> MSB, 00 -> LSB 
 input logic [3:0] thousands,     //the MSB digit
 input logic [3:0] hundreds,      //the 100's digit
 input logic [3:0] tens,          //the 10's digit
 input logic [3:0] ones,          //the LSB digit
 output logic [3:0] value  //the selected digit
 ); 

  always_comb
    case(digitCount)  		       
      3'd4 : value = thousands; //MSB Display
      3'd3 : value = hundreds;  //hundreds Display
      3'd1 : value = tens;      //tens Display
      3'd0 : value = ones;      //LSB Display
      default : value = ones;   //
    endcase
endmodule