# Assignment 4: Vivado Lab 2
###### Note: Each of these labs are referenced from Professor Kevin Lu's [dsd repository](https://github.com/kevinwlu/dsd).

###### Since I am using a [NI Digilent Nexys A7-100T FPGA Trainer Board](https://digilent.com/reference/programmable-logic/nexys-a7/start?redirect=1), the relevant labs are [here](https://github.com/kevinwlu/dsd/tree/master/Nexys-A7). To go straight to Lab 2, [click here](https://github.com/kevinwlu/dsd/tree/master/Nexys-A7/Lab-2).

Open Vivado and create VHDL projects to synthesize, implement, generate bitstream, and program FPGA for
1. Lab 2: Four-digit hex counter, generate and boot from a memory configuration file
2. Lab 2 modifications: Eight-digit hex counter


Program Outcome 1: (*Complex Problem Solving*)

2.3 The student will be able to develop VHDL models of systems using behavioral, structural, and dataflow concepts to describe the internal behavior and/or structure of the design.

### Submission:

- Lab 2: Four-digit hex counter, generate and boot from a memory configuration file
	- Very similar procedure to that of Vivado Lab 1 from the previous assignment
		- Created a new project in Vivado called `hex4count` (4-digit Hex Counter)
		- Followed the instructions from [Lab 2: Four-Digit Hex Counter](https://github.com/kevinwlu/dsd/tree/master/Nexys-A7/Lab-2#lab-2-four-digit-hex-counter) to set up the Vivado project
		- Using code provided, edited the Design Sources and Constraints of the project
		- Ran synthesis, implementation, and generated bitstream
		- Programmed the Nexys A7-100T board with the generated `hexcount.bit` file
		- Watch the counter start
	- However, this time we also generated a Memory Configuration File and flash programmed the FPGA board so that program will automatically run on boot.
		- Followed the instructions from [Generate and boot from configuration memory](https://github.com/kevinwlu/dsd/tree/master/Nexys-A7/Lab-2#6-generate-and-boot-from-configuration-memory-and-close-project)
		- POWER OFF > POWER ON > Wait for 10 seconds > The program runs
		- Download and watch [hex4count.mp4](./hex4count.mp4)
		
		![hex4count GIF](./hex4count.gif)
	

- Lab 2 modifications: Eight-digit hex counter

	- Same exact procedure as Lab 2 above, except using a different set of VHDL and XDC files
	- The files can be found under the [Modifications](https://github.com/kevinwlu/dsd/tree/master/Nexys-A7/Lab-2/Modifications) directory in Lab-2
	- Built an Eight-digit hex counter
		- Download and watch [hex8count.mp4](./hex8count.mp4)
		
		![hex8count GIF](./hex8count.gif)
