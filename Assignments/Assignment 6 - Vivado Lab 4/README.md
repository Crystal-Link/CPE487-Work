# Assignment 6: Vivado Lab 4
###### Note: Each of these labs are referenced from Professor Kevin Lu's [dsd repository](https://github.com/kevinwlu/dsd).

###### Since I am using a [NI Digilent Nexys A7-100T FPGA Trainer Board](https://digilent.com/reference/programmable-logic/nexys-a7/start?redirect=1), the relevant labs are [here](https://github.com/kevinwlu/dsd/tree/master/Nexys-A7). To go straight to Lab 4, [click here](https://github.com/kevinwlu/dsd/tree/master/Nexys-A7/Lab-4).

Open Vivado and create VHDL project to synthesize, implement, generate bitstream, and program FPGA for
1. Lab 4: Hex calculator
2. Lab 4 modifications

Program Outcome 2: (*Design*)

2.4 The student will be able to use VHDL to design complex synthesizable state machines using Mealy and/or Moore architectures.

### Submission:

- Lab 4: Hex calculator
	- For this lab, I was to program the FPGA to function as a simple hexadecimal calculator capable of adding and subtracting four-digit hexadecimal numbers using a 16-button keypad module ([Pmod KYPD](https://store.digilentinc.com/pmod-kypd-16-button-keypad/) ) connected to the Pmod port JA (See Section 10 of the [Reference Manual](https://reference.digilentinc.com/_media/reference/programmable-logic/nexys-a7/nexys-a7_rm.pdf) ) directly or via an optional [2x6-pin cable](https://digilent.com/shop/2x6-pin-pmod-cable/) with three dots (or VDD/GND) facing up on both ends
	- Very similar procedure to that of the Vivado Labs done previously
		- Created a new project in Vivado called `hexcalc`
		- Followed the instructions from [Lab 4: Hex Calculator](https://github.com/kevinwlu/dsd/tree/master/Nexys-A7/Lab-4#lab-4-hex-calculator) to set up the Vivado project
		- Using code provided, edited the Design Sources and Constraints of the project
		- Ran synthesis, implementation, and generated bitstream
		- Programmed the Nexys A7-100T board with the generated `hexcalc.bit` file
		- Use the PMOD keypad and buttons on the Nexys A7-100T board to perform calculations
			- Keypad for hex numbers
			- BTNU button for "+"
			- BTNL button for "="
			- BTNC button for "clear"
		- Note that the hex calculator only takes up to 4 digits, therefore inputting more digits will continue to shift the digits to the left, but will not produce a value of higher digits. The calculator will perform the operations only with what is on the display. If the resulting value is greater than FFFF, the calculator will roll over back to 0000. Meaning, if I input FFFF + 1111, the returned value is 1110.
		- Download and watch [hexcalc.mp4](./hexcalc.mp4)
		
		![hexcalc GIF](./hexcalc.gif)
	

- Lab 4 modifications
	- Same exact procedure as Lab 4 above, except using a different set of VHDL and XDC files
		- Created new Design Sources `hexcalc_1.vhd` and `leddec16_1.vhd`, as well as a new Constraint file `hexcalc_1.xdc` to include the modified design
		- Disabled `hexcalc.vhd`, `leddec16.vhd`, and `hexcalc.xdc` by unchecking "Enabled" under the Source File Properties when selecting it in Sources
			- This way I can keep both designs within the Vivado project and toggle between them by just enabling/disabling the design files
		- Reran synthesis, implementation, and generated bitstream to apply the modifications
		- Reprogrammed the Nexys A7-100T board with the re-generated `hexcalc.bit` file
		- Use the PMOD keypad and buttons on the Nexys A7-100T board to perform calculations
			- Same buttons as mentioned in Lab 4 above, with the addition of BTND button for "-"
		- As noted in the Lab 4, the calculator only takes up to 4 digits. Similar to the "+" operation, if a calculated value using the "-" operation is less than 0000, the calculator will roll over to FFFF. Meaning, if I input 1111 - 2222, the returned value is EEEF.
	- The files can be found under the [Modifications](https://github.com/kevinwlu/dsd/tree/master/Nexys-A7/Lab-4/Modifications) directory in Lab-4
		- leddec16_1.vhd: leading zero suppression
		- hexcalc_1.vhd: subtraction operations
		- hexcalc_1.xdc: the BTND (P18) button for substraction
		- Download and watch [hexcalc_modifications.mp4](./hexcalc_modifications.mp4)
		
		![hexcalc_modifications GIF](./hexcalc_modifications.gif)

