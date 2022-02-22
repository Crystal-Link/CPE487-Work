# Assignment 3: Vivado Lab 1
###### Note: Each of these labs are referenced from Professor Kevin Lu's [dsd repository](https://github.com/kevinwlu/dsd).

###### Since I am using a NI Digilent Nexys A7-100T FPGA Trainer Board, the relevant labs are [here](https://github.com/kevinwlu/dsd/tree/master/Nexys-A7). To go straight to Lab 1, [click here](https://github.com/kevinwlu/dsd/tree/master/Nexys-A7/Lab-1).

Open Vivado and create VHDL projects to synthesize, implement, generate bitstream, and program FPGA for
1. Lab 1 Project 1: LED decoder
2. Lab 1 Project 2: Single-digit hex counter


Program Outcome 6: (*Experimentation*)

1.3 The student will be able to represent and document designs, perform simulations and synthesize implementations using software tools provided by an FPGA vendor.

### Submission:

- Lab 1 Project 1: LED decoder
	- Created a new project in Vivado called `leddec` (LED Decoder)
	- Followed the instructions from [Project 1 - LED Decoder](https://github.com/kevinwlu/dsd/tree/master/Nexys-A7/Lab-1#project-1---led-decoder) to set up the Vivado project
	- Using code provided, edited the Design Sources and Constraints of the project
	- Ran synthesis, implementation, and generated bitstream
	- Programmed the Nexys A7-100T board with the generated `leddec.bit` file
	- Watch the magic happen (Built a LED decoder)
		- Slide switches 0, 1, 2, and 3 to display the value of 4-bit hex digit from 0 to F
		- Slide switches 13, 14, and 15 to determine which display is illuminated
		- Download and watch [LED_Decoder.mp4](./LED_Decoder.mp4)
	

- Lab 1 Project 2: Single-digit hex counter
	- Similar steps from Project 1, but in reference with [Project 2 - Hex Counter](https://github.com/kevinwlu/dsd/tree/master/Nexys-A7/Lab-1#project-2---hex-counter)
	- Used code from different files, but still the same procedure
	- Programmed the Nexys A7-100T board with the generated `hexcount.bit` file
	- Built a 4-bit hex counter
		- The least significant 7-segment decoder cycles from 0 to F
		- Download and watch [4-bit_Hex_Counter.mp4](./4-bit_Hex_Counter.mp4)
