----------------------------------------------------------------------------------
-- Company: Stevens Institute of Technology
-- Engineer: Calvin Zheng
-- 
-- Create Date: 04/15/2022 11:50:38 PM
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
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY MazeGame IS
    PORT (
        clk_in      : IN STD_LOGIC; -- system clock
        VGA_red     : OUT STD_LOGIC_VECTOR (2 DOWNTO 0); -- VGA outputs
        VGA_green   : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        VGA_blue    : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
        VGA_hsync   : OUT STD_LOGIC;
        VGA_vsync   : OUT STD_LOGIC);
        --button0   : IN STD_LOGIC; -- buttons for movement
        --button1   : IN STD_LOGIC;
        --button2   : IN STD_LOGIC;
        --button3   : IN STD_LOGIC;
        --button4   : IN STD_LOGIC
    --);
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
            blue : OUT STD_LOGIC
        );
    END COMPONENT;
    COMPONENT vga_sync IS
        PORT (
            pixel_clk : IN STD_LOGIC;
            red_in    : IN STD_LOGIC;
            green_in  : IN STD_LOGIC;
            blue_in   : IN STD_LOGIC;
            red_out   : OUT STD_LOGIC;
            green_out : OUT STD_LOGIC;
            blue_out  : OUT STD_LOGIC;
            hsync     : OUT STD_LOGIC;
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
    -- vga_driver only drives MSB of red, green & blue
    -- so set other bits to zero
    VGA_red(1 DOWNTO 0) <= "00";
    VGA_green(1 DOWNTO 0) <= "00";
    VGA_blue(0) <= '0';

    add_ball : ball
    PORT MAP(
        --instantiate ball component
        v_sync    => S_vsync, 
        pixel_row => S_pixel_row, 
        pixel_col => S_pixel_col, 
        red       => S_red, 
        green     => S_green, 
        blue      => S_blue
    );

    vga_driver : vga_sync
    PORT MAP(
        --instantiate vga_sync component
        pixel_clk => pxl_clk, 
        red_in    => S_red, 
        green_in  => S_green, 
        blue_in   => S_blue, 
        red_out   => VGA_red(2), 
        green_out => VGA_green(2), 
        blue_out  => VGA_blue(1), 
        pixel_row => S_pixel_row, 
        pixel_col => S_pixel_col, 
        hsync     => VGA_hsync, 
        vsync     => S_vsync
    );
    VGA_vsync <= S_vsync; -- connect output vsync
        
    clk_wiz_0_inst : clk_wiz_0
    port map (
      clk_in1 => clk_in,
      clk_out1 => pxl_clk
    );
    
END Behavioral;
