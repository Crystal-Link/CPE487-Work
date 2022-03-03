# Assignment 5: Vivado Labs 3 and 6
###### Note: Each of these labs are referenced from Professor Kevin Lu's [dsd repository](https://github.com/kevinwlu/dsd).

###### Since I am using a [NI Digilent Nexys A7-100T FPGA Trainer Board](https://digilent.com/reference/programmable-logic/nexys-a7/start?redirect=1), the relevant labs are [here](https://github.com/kevinwlu/dsd/tree/master/Nexys-A7). To go straight to Lab 3, [click here](https://github.com/kevinwlu/dsd/tree/master/Nexys-A7/Lab-3). To go straight to Lab 6, [click here](https://github.com/kevinwlu/dsd/tree/master/Nexys-A7/Lab-6).

Open Vivado and create projects to synthesize, implement, generate bitstream, and program FPGA for
1. Lab 3: Bouncing ball
2. Lab 3 modifications
3. Lab 6: Video game PONG
4. Lab 6 modifications


Program Outcome 1: (*Complex Problem Solving*)

1.2 The student will be able to efficiently model a complex digital system as a hierarchy of interconnected components, taking advantage of regularity and component re-use.

### Submission:

- Lab 3: Bouncing ball
	- For this lab, I was to program the FPGA to display a "bouncing ball" on a 800x600 [Video Graphics Array](https://en.wikipedia.org/wiki/Video_Graphics_Array) (VGA) monitor.
	- Very similar procedure to that of Vivado Labs 1 and 2 done previously
		- Created a new project in Vivado called `vgaball`
		- Followed the instructions from [Lab 3: Bouncing Ball](https://github.com/kevinwlu/dsd/tree/master/Nexys-A7/Lab-3#lab-3-bouncing-ball) to set up the Vivado project
		- Using code provided, edited the Design Sources and Constraints of the project
		- Ran synthesis, implementation, and generated bitstream
		- Programmed the Nexys A7-100T board with the generated `vga_top.bit` file
		- Watch the "bouncing ball" on the monitor
	- Unfortunately, I do not have a VGA monitor so I used an [High-Definition Multimedia Interface](https://en.wikipedia.org/wiki/HDMI) (HDMI) monitor instead. Therefore, using a [VGA-to-HDMI converter](https://www.ventioncable.com/product/vga-to-hdmi-converter/) with a [micro-B USB](https://en.wikipedia.org/wiki/USB_hardware) power supply, I connected the Digilent Nexys A7-100T board to the HDMI monitor to see the resulting "bouncing ball."
		- At the time of doing this lab, I did not bring an [AC adapter](https://en.wikipedia.org/wiki/AC_adapter) with me so I used my laptop's USB port for power.
		- Download and watch [vgaball.mp4](./videos/vgaball.mp4)
		
		![vgaball GIF](./vgaball.gif)
	

- Lab 3 modifications
	- Same exact procedure as Lab 3 above, except using a different set of VHDL and XDC files
		- Created a new Design Source `ball_1.vhd` to include the modified design
		- Disabled `ball.vhd` by unchecking "Enabled" under the Source File Properties when selecting it in Sources
			- This way I can keep both designs within the Vivado project and toggle between them by just enabling/disabling the design files
		- Reran synthesis, implementation, and generated bitstream to apply the modifications
		- Reprogrammed the Nexys A7-100T board with the re-generated `vga_top.bit` file
		- Watch the modified "bouncing ball" on the monitor
	- The files can be found under the [Modifications](https://github.com/kevinwlu/dsd/tree/master/Nexys-A7/Lab-3/Modifications) directory in Lab-3
		- Change the size and color of the ball
		- Change the square ball to a round ball
		- Introduce a new signal ball_x_motion to allow the ball to move both horizontally and vertically
		- Download and watch [vgaball_modifications.mp4](./videos/vgaball_modifications.mp4)
		
		![vgaball_modifications GIF](./vgaball_modifications.gif)


- Lab 6: Video game PONG
	- For this lab, I was to extend the FPGA code developed in Lab 3 (Bouncing Ball) above to build a PONG game using a 5kΩ potentiometer with a 12-bit [analog-to-digital converter](https://en.wikipedia.org/wiki/Analog-to-digital_converter) (ADC) called [Pmod AD1](https://digilent.com/shop/pmod-ad1-two-12-bit-a-d-inputs/) connected to the top pins of the Pmod port JA (See Section 10 of the [Reference Manual](https://digilent.com/reference/_media/reference/programmable-logic/nexys-a7/nexys-a7_rm.pdf) )
	- Very similar procedure to that of Vivado Lab 3 above
		- Created a new project in Vivado called `pong`
		- Followed the instructions from [Lab 6: Video Game PONG](https://github.com/kevinwlu/dsd/tree/master/Nexys-A7/Lab-6#lab-6-video-game-pong) to set up the Vivado project
		- Using code provided, edited the Design Sources and Constraints of the project
		- Ran synthesis, implementation, and generated bitstream
		- Programmed the Nexys A7-100T board with the generated `pong.bit` file
		- Push the BTNC button to start the bouncing ball and use the bat to keep the ball in play
	- Same setup as Lab 3 above
		- Via a VGA-to-HDMI converter, I connected the Digilent Nexys A7-100T board to the HDMI monitor to play the PONG game
		- Download and watch [pong.mp4](./videos/pong.mp4) and [pong_play.mp4](./videos/pong_play.mp4)
		
		![pong GIF](./pong.gif)
		
		![pong_play GIF](./pong_play.gif)
	
	
- Lab 6 modifications
	- Same exact procedure as Lab 6 above, except using a different set of VHDL and XDC files
		- Created new Design Sources `bat_n_ball_1.vhd`, `leddec16.vhd`, and `pong_1.vhd`, as well as a new Constraint file `pong_1.xdc` to include the modified design
		- Disabled `bat_n_ball.vhd`, `pong.vhd`, and `pong.xdc` by unchecking "Enabled" under the Source File Properties when selecting it in Sources
			- This way I can keep both designs within the Vivado project and toggle between them by just enabling/disabling the design files
		- Reran synthesis, implementation, and generated bitstream to apply the modifications
		- Reprogrammed the Nexys A7-100T board with the re-generated `pong.bit` file
		- Play the modified PONG game
	- The files can be found under the [Modifications](https://github.com/kevinwlu/dsd/tree/master/Nexys-A7/Lab-6/Modifications) directory in Lab-6
		- Change ball speed
			- The ball speed is currently 6 pixels per video frame
			- Use the slide switches on the Nexys A7-100T board to program the ball speed in the range of 1-32 pixels per frame
			- Since we can only toggle in the range of 1-32 pixels per frame, that means the first 5 slide switches on the right (SW0, SW1, SW2, SW3, and SW4) controls this speed... in binary.
				- WARNING: Avoid setting the speed to zero as the ball will then never reach the bat or wall
				- Also do not set the speed to zero before spawning the ball... otherwise it will only move horizontally and never end.
			- See how fast to move the ball and still keep it in play
				- For me, **12 pixels per frame** was near the limit.
		- Change bat width and count hits
			- Double the width of the bat to make the game really easy
				- Sometimes I do see the ball clipping through the extended bat though (especially at the sides of the screen).
			- Modify the code so that the bat width decreases one pixel each time successfully hitting the ball and then resets to starting width when missing the ball
			- See how many times hitting the ball in a row as the bat slowly shrinks
				- At a speed of 6 pixels per frame, I hit the ball **25 times** in a row.
			- Count the number of successful hits after each serve and display the count in binary on the 7-segment displays of the Nexys A7-100T board
				- Noticed that the successful hit counter starts counting AFTER the first hit and it only goes up to F, or 15 in hex, before resetting to 0 on the next hit.
		- Download and watch [pong_modifications_play.mp4](./videos/pong_modifications_play.mp4)
			- Thanks to my friend Jack for playing the game while I took the video
		
		![pong_modifications_play GIF](./pong_modifications_play.gif)