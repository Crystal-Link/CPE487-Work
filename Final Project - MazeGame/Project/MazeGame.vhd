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
-- Revision 0.06 - Added level transition
-- Additional Comments:
-- Made the map making process more abstract so levels can be created and edited
-- more easily.
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- grid definition
-- defines the grid as a N by N 2d array where each cell contains a std_logic_vector
package cell_matrix_def is
	-- # of bits depends on # of components in the game
	type cell_matrix is array (natural range <>, natural range <>) of std_logic_vector(1 downto 0);
end package;

----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
-- package definition above
use work.all;
use work.cell_matrix_def.all;

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
		buttonReset : IN STD_LOGIC; -- reset button (CPU_RESETN)
        buttonL     : IN STD_LOGIC; -- left button (BTNL)
        buttonR     : IN STD_LOGIC; -- right button (BTNR)
        buttonU     : IN STD_LOGIC; -- up button (BTNU)
        buttonD     : IN STD_LOGIC; -- down button (BTND)
        buttonC     : IN STD_LOGIC -- center button for interactions (BTNC)
    );
END MazeGame;

ARCHITECTURE Behavioral OF MazeGame IS
    SIGNAL pxl_clk : STD_LOGIC;
	
	-------------------------------------------------------
	-- VGA sync signals
	-------------------------------------------------------
    -- internal signals to connect modules
    SIGNAL S_red, S_green, S_blue : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL S_vsync : STD_LOGIC;
    SIGNAL S_pixel_row, S_pixel_col : STD_LOGIC_VECTOR (10 DOWNTO 0);
	
	-------------------------------------------------------
	-- ball signals
	-------------------------------------------------------
	SIGNAL ball_red, ball_green, ball_blue : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL ball_on : STD_LOGIC;
	SIGNAL ball_x_init_pass, ball_y_init_pass : STD_LOGIC_VECTOR(10 DOWNTO 0);
	
	-------------------------------------------------------
	-- mazeMap signals
	-------------------------------------------------------
	SIGNAL map_red, map_green, map_blue : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL cell_size_pass, start_x_pass, start_y_pass : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL end_x_pass, end_y_pass : STD_LOGIC_VECTOR(10 DOWNTO 0);
	
	
	-- NOTE: PLEASE MAKE SURE THE AMOUNT HERE = AMOUNT VALUE DEFINED IN THE LEVELS.
	
	-- I wanted to make the level grid/cell sizes dynamic, but if I want to pass the entire
	-- array through this top level (which is necessary for collision detection), 
	-- I don't think I can. The array definition here MUST HAVE A CONSTANT SIZE since the
	-- hardware cannot change in the middle of the program (it's still HARDWARE).
	
	-- This also means the grid/cell sizes for ALL levels must be the same... sad

	-- CONSTANT amount : INTEGER := CONV_INTEGER(end_y_pass) / CONV_INTEGER(cell_size_pass);
	CONSTANT amount : INTEGER := 30;
	SIGNAL cell_arr_pass : CELL_MATRIX(0 TO amount, 0 TO amount);
	
	-------------------------------------------------------
	-- level signals
	-------------------------------------------------------
	-- level transition counter
	SIGNAL level_count : STD_LOGIC_VECTOR(2 DOWNTO 0);
	
	-- level0 signals
	SIGNAL ball_x_init_0, ball_y_init_0 : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL cell_size_0, start_x_0, start_y_0 : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL end_x_0, end_y_0 : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL cell_arr_0 : CELL_MATRIX(0 TO amount, 0 TO amount);
	
	-- level1 signals
	SIGNAL ball_x_init_1, ball_y_init_1 : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL cell_size_1, start_x_1, start_y_1 : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL end_x_1, end_y_1 : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL cell_arr_1 : CELL_MATRIX(0 TO amount, 0 TO amount);
	
	-------------------------------------------------------
	-------------------------------------------------------
	
    COMPONENT ball IS
        PORT (
            v_sync 		: IN STD_LOGIC;
            pixel_row 	: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            pixel_col 	: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            red 		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            green 		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            blue 		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
			
			ball_on_out 	: OUT STD_LOGIC;
			level_count_out : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
			cell_arr_in		: IN CELL_MATRIX;
			
			cell_size_in	: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
			start_x_in		: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
			start_y_in		: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
			end_x_in		: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
			end_y_in		: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
			
			ball_x_init_in : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
			ball_y_init_in : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
			
			button_reset : IN STD_LOGIC;
			moveL 		: IN STD_LOGIC;
			moveR 		: IN STD_LOGIC;
			moveU 		: IN STD_LOGIC;
			moveD 		: IN STD_LOGIC;
			interact 	: IN STD_LOGIC
        );
    END COMPONENT;
	
	COMPONENT mazeMap IS
		PORT ( 
            pixel_row 	: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            pixel_col 	: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            red 		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            green 		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            blue 		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
			
			cell_size_in	: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
			start_x_in		: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
			start_y_in		: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
			end_x_in		: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
			end_y_in		: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
			
			cell_arr_in		: IN CELL_MATRIX
		);
	END COMPONENT;
	
	COMPONENT level0 IS
		PORT (
			pixel_row 	: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            pixel_col 	: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
			
			cell_size_out	: OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
			start_x_out		: OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
			start_y_out		: OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
			end_x_out		: OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
			end_y_out		: OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
			
			ball_x_init_out : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
			ball_y_init_out : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
			
			cell_arr_out	: OUT CELL_MATRIX
		);
	END COMPONENT;
	
	COMPONENT level1 IS
		PORT (
			pixel_row 	: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            pixel_col 	: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
			
			cell_size_out	: OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
			start_x_out		: OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
			start_y_out		: OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
			end_x_out		: OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
			end_y_out		: OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
			
			ball_x_init_out : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
			ball_y_init_out : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
			
			cell_arr_out	: OUT CELL_MATRIX
		);
	END COMPONENT;
	
	-- To add more levels, additional level components must be added
	
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
        red       => ball_red, 
        green     => ball_green, 
        blue      => ball_blue,
		
		ball_on_out => ball_on,
		level_count_out => level_count,
		cell_arr_in	=> cell_arr_pass,
		
		cell_size_in => cell_size_pass,
		start_x_in 	=> start_x_pass,
		start_y_in 	=> start_y_pass,
		end_x_in 	=> end_x_pass,
		end_y_in	=> end_y_pass,
		
		ball_x_init_in => ball_x_init_pass,
		ball_y_init_in => ball_y_init_pass,
		
		button_reset => buttonReset,
		moveL	  => buttonL,
		moveR	  => buttonR,
		moveU	  => buttonU,
		moveD	  => buttonD,
		interact  => buttonC
    );
	
	display_mazeMap : mazeMap
	PORT MAP( 
        pixel_row => S_pixel_row, 
        pixel_col => S_pixel_col, 
        red       => map_red, 
        green     => map_green, 
        blue      => map_blue,
		
		cell_size_in => cell_size_pass,
		start_x_in 	=> start_x_pass,
		start_y_in 	=> start_y_pass,
		end_x_in 	=> end_x_pass,
		end_y_in	=> end_y_pass,
		
		cell_arr_in	  => cell_arr_pass
	);
	
	define_level0 : level0
	PORT MAP(
		pixel_row => S_pixel_row,
		pixel_col => S_pixel_col,
		
		cell_size_out => cell_size_0,
		start_x_out => start_x_0,
		start_y_out => start_y_0,
		end_x_out	=> end_x_0,
		end_y_out	=> end_y_0,
		
		ball_x_init_out => ball_x_init_0,
		ball_y_init_out => ball_y_init_0,
		
		cell_arr_out   => cell_arr_0
	);
	
	define_level1 : level1
	PORT MAP(
		pixel_row => S_pixel_row,
		pixel_col => S_pixel_col,
		
		cell_size_out => cell_size_1,
		start_x_out => start_x_1,
		start_y_out => start_y_1,
		end_x_out	=> end_x_1,
		end_y_out	=> end_y_1,
		
		ball_x_init_out => ball_x_init_1,
		ball_y_init_out => ball_y_init_1,
		
		cell_arr_out   => cell_arr_1
	);
	
	-- Process to determine final VGA signals and which level is being played
	process
	begin
		wait until rising_edge(pxl_clk);
			
		if (level_count = "000") then
			cell_size_pass <= cell_size_0;
			start_x_pass <= start_x_0;
			start_y_pass <= start_y_0;
			end_x_pass <= end_x_0;
			end_y_pass <= end_y_0;
			ball_x_init_pass <= ball_x_init_0;
			ball_y_init_pass <= ball_y_init_0;
			cell_arr_pass <= cell_arr_0;
		else
			cell_size_pass <= cell_size_1;
			start_x_pass <= start_x_1;
			start_y_pass <= start_y_1;
			end_x_pass <= end_x_1;
			end_y_pass <= end_y_1;
			ball_x_init_pass <= ball_x_init_1;
			ball_y_init_pass <= ball_y_init_1;
			cell_arr_pass <= cell_arr_1;
		end if;
		
		if (ball_on = '1') then
			S_red <= ball_red;
			S_green <= ball_green;
			S_blue <= ball_blue;
		else
			S_red <= map_red;
			S_green <= map_green;
			S_blue <= map_blue;
		end if;
			
	end process;
		
    vga_driver : vga_sync
    PORT MAP(
        --instantiate vga_sync component
        pixel_clk => pxl_clk, 
        red_in    => S_red, 
        green_in  => S_green, 
        blue_in   => S_blue, 
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
