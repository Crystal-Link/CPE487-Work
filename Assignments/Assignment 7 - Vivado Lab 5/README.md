# Assignment 7: Vivado Lab 5
###### Note: Each of these labs are referenced from Professor Kevin Lu's [dsd repository](https://github.com/kevinwlu/dsd).

###### Since I am using a [NI Digilent Nexys A7-100T FPGA Trainer Board](https://digilent.com/reference/programmable-logic/nexys-a7/start?redirect=1), the relevant labs are [here](https://github.com/kevinwlu/dsd/tree/master/Nexys-A7). To go straight to Lab 5, [click here](https://github.com/kevinwlu/dsd/tree/master/Nexys-A7/Lab-5).

Open Vivado and create VHDL projects to synthesize, implement, generate bitstream, and program FPGA for
1. Lab 5: Digital-to-analog siren
2. Lab 5 modifications

Program Outcome 2: (*Design*)

2.2 The student will be able to build VHDL models of complex digital circuits suitable for synthesis where the target platform is an FPGA or ASIC logic library.

### Submission:

- Lab 5: Digital-to-analog siren
	- For this lab, I was to program the FPGA on the Nexys A7-100T board to generate a wailing audio siren using a 24-bit [digital-to-analog converter](https://en.wikipedia.org/wiki/Digital-to-analog_converter) (DAC) called [Pmod I2S2](https://digilent.com/reference/pmod/pmodi2s2/start) connected to Pmod port JA (See Section 10 of the [Reference Manual](https://reference.digilentinc.com/_media/reference/programmable-logic/nexys-a7/nexys-a7_rm.pdf))
	- WARNING: The siren is loud.
	- Very similar procedure to that of the Vivado Labs done previously
		- Created a new project in Vivado called `siren`
		- Followed the instructions from [Lab 5: DAC Siren](https://github.com/kevinwlu/dsd/tree/master/Nexys-A7/Lab-5#lab-5-dac-siren) to set up the Vivado project
		- Using code provided, edited the Design Sources and Constraints of the project
		- Ran synthesis, implementation, and generated bitstream
		- Programmed the Nexys A7-100T board with the generated `siren.bit` file
		- Listen to the siren
		- NOTE: The warning was a false alarm. Even at 1:30 AM in a quiet room, the siren was not that loud.
		- Download and watch (or listen... you might have to turn the volume up to hear it) [siren.mp4](./siren.mp4)
		
		![siren GIF](./siren.gif)
	

- Lab 5 modifications
	- Same exact procedure as Lab 5 above, except using a different set of VHDL and XDC files
		- Created new Design Sources `siren_1.vhd`, `tone_1.vhd`, and `wail_1.vhd`, as well as a new Constraint file `siren_1.xdc` to include the modified design
		- Disabled `siren.vhd`, `tone.vhd`, `wail.vhd`, and `siren.xdc` by unchecking "Enabled" under the Source File Properties when selecting it in Sources
			- This way I can keep both designs within the Vivado project and toggle between them by just enabling/disabling the design files
		- Reran synthesis, implementation, and generated bitstream to apply the modifications
		- Reprogrammed the Nexys A7-100T board with the re-generated `siren.bit` file
		- Play around with the wailing speed and tone limits and listen to the modified siren
	- The files can be found under the [Modifications](https://github.com/kevinwlu/dsd/tree/master/Nexys-A7/Lab-5/Modifications) directory in Lab-5
		- Change the upper and lower tone limits
			- Modify the tone module to create a square wave instead of a triangle wave when the upper push button (BTNU) is pressed
			- Note the difference in the quality of the tone when switching to a square wave tone
				- The square wave tone is considerably louder and higher pitched than the triangle wave
		- Change the wailing speed
			- Use the eight slide switches (SW0-SW7) on the Nexys A7-100T board to set the wailing speed
		- Add a second wail instance to drive the right audio channel
			- Use different high and low tone limits and wailing speed for the right audio channel
				- The tone range is much wider now compared to the pre-modified version
		- Download and watch (or listen) [siren_modifications.mp4](./siren_modifications.mp4)
		
		![siren_modifications GIF](./siren_modifications.gif)

