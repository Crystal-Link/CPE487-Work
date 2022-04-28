# Building the Project: MazeGame

This project was created and built using [Vivado 2021.2](https://www.xilinx.com/support/download.html) so these instructions are for building it in your own Vivado instance.

### 1. Create a new RTL _MazeGame_ in Vivado Quick Start

* Create eight new source files of file type VHDL called **_ball_**, **_clk_wiz_0_**, **_clk_wiz_0_clk_wiz_**, **_level0_**, **_level1_**, **_MazeGame_**, **_mazeMap_**, and **_vga_sync_**

* Create a new constraint file of file type XDC called **_MazeGame_**

* Choose Nexys A7-100T board for the project

* Click 'Finish'

* Click design sources and copy the VHDL code from ball.vhd, clk_wiz_0.vhd, clk_wiz_0_clk_wiz.vhd, level0.vhd, level1.vhd, MazeGame.vhd, mazeMap.vhd, and vga_sync.vhd

* Click constraints and copy the code from MazeGame.xdc

### 2. Run synthesis

### 3. Run implementation and open implemented design

###### NOTE: Be sure to have your Nexys A7-100T board plugged into your computer as well as have a VGA output to a compatible monitor before programming the board!

### 4. Generate bitstream, open hardware manager, and program device

* Click 'Generate Bitstream'

* Click 'Open Hardware Manager' and click 'Open Target' then 'Auto Connect'

* Click 'Program Device' then xc7a100t_0 to download siren.bit to the Nexys A7-100T board

### 5. Enjoy MazeGame!