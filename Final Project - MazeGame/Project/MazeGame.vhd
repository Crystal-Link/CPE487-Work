----------------------------------------------------------------------------------
-- Company: Stevens Institute of Technology
-- Engineer: Calvin Zheng
-- 
-- Create Date: 04/16/2022 11:30:00 PM
-- Design Name: 
-- Module Name: MazeGame - Behavioral
-- Project Name: CPE 487 Final Project MazeGame 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.02 - Adding buttons
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY MazeGame IS
    PORT (
        clk_in      : IN STD_LOGIC; -- system clock
        
        -- VGA outputs
        VGA_red     : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        VGA_green   : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        VGA_blue    : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        VGA_hsync   : OUT STD_LOGIC;
        VGA_vsync   : OUT STD_LOGIC;
        
        -- buttons for movement
        buttonL     : IN STD_LOGIC; -- left button (BTNL)
        buttonR     : IN STD_LOGIC; -- right button (BTNR)
        buttonU     : IN STD_LOGIC; -- up button (BTNU)
        buttonD     : IN STD_LOGIC; -- down button (BTND)
        buttonC     : IN STD_LOGIC -- center button for interactions (BTNC)
    );
END MazeGame;

ARCHITECTURE Behavioral OF MazeGame IS
    SIGNAL pxl_clk : STD_LOGIC;
	
    -- internal signals to connect modules
    SIGNAL S_red, S_green, S_blue : STD_LOGIC;
    SIGNAL S_vsync : STD_LOGIC;
    SIGNAL S_pixel_row, S_pixel_col : STD_LOGIC_VECTOR (10 DOWNTO 0);
    
    COMPONENT ball IS
        PORT (
            v_sync : IN STD_LOGIC;
            pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            red : OUT STD_LOGIC;
            green : OUT STD_LOGIC;
            blue : OUT STD_LOGIC;
			
			moveL : IN STD_LOGIC;
			moveR : IN STD_LOGIC;
			moveU : IN STD_LOGIC;
			moveD : IN STD_LOGIC;
			interact : IN STD_LOGIC
        );
    END COMPONENT;
    
    COMPONENT vga_sync IS
        PORT (
            pixel_clk : IN STD_LOGIC;
            red_in    : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            green_in  : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            blue_in   : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            red_out   : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            green_out : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            blue_out  : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            hsync 	  : OUT STD_LOGIC;
            vsync     : OUT STD_LOGIC;
            pixel_row : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
            pixel_col : OUT STD_LOGIC_VECTOR (10 DOWNTO 0)
        );
    END COMPONENT;
    
    COMPONENT clk_wiz_0 IS
    PORT (
      clk_in1  : IN STD_LOGIC;
      clk_out1 : OUT STD_LOGIC
    );
    END COMPONENT;
    
BEGIN
    add_ball : ball
    PORT MAP(
        --instantiate ball component
        v_sync    => S_vsync, 
        pixel_row => S_pixel_row, 
        pixel_col => S_pixel_col, 
        red       => S_red, 
        green     => S_green, 
        blue      => S_blue,
		
		moveL	  => buttonL,
		moveR	  => buttonR,
		moveU	  => buttonU,
		moveD	  => buttonD,
		interact  => buttonC
    );

    vga_driver : vga_sync
    PORT MAP(
        --instantiate vga_sync component
        pixel_clk => pxl_clk, 
        red_in    => S_red & "000", 
        green_in  => S_green & "000", 
        blue_in   => S_blue & "000", 
        red_out   => VGA_red,
        green_out => VGA_green, 
        blue_out  => VGA_blue, 
        pixel_row => S_pixel_row, 
        pixel_col => S_pixel_col, 
        hsync     => VGA_hsync, 
        vsync     => S_vsync
    );
    VGA_vsync <= S_vsync; -- connect output vsync
        
    clk_wiz_0_inst : clk_wiz_0
    PORT MAP (
      clk_in1 => clk_in,
      clk_out1 => pxl_clk
    );
    
END Behavioral;
