----------------------------------------------------------------------------------
--
-- Level 0 of MazeGame
-- 
-- Defines the properties of the game for this level
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- package definition from MazeGame.vhd
use work.all;
use work.cell_matrix_def.all;

entity level0 is
	Port ( 
		pixel_row : in std_logic_vector(10 downto 0); -- pixel y position
		pixel_col : in std_logic_vector(10 downto 0); -- pixel x position
		
		cell_size_out	: out std_logic_vector(10 downto 0);
		start_x_out		: out std_logic_vector(10 downto 0);
		start_y_out		: out std_logic_vector(10 downto 0);
		end_x_out		: out std_logic_vector(10 downto 0);
		end_y_out		: out std_logic_vector(10 downto 0);
		
		ball_x_init_out : out std_logic_vector(10 downto 0);
		ball_y_init_out : out std_logic_vector(10 downto 0);
		
		cell_arr_out	: out cell_matrix
	);
end level0;

architecture Behavioral of level0 is
	-- map dimensions and cell size (pixels)
	constant size		: integer := 24;   	-- please make sure h/size is an integer
	constant w			: integer := 1280;
	constant h			: integer := 720;
	
	-- starting and ending pixels
	-- this maps a square at the center of the screen
	constant start_x	: integer := w/2 - h/2;
	constant start_y	: integer := 0;
	constant end_x		: integer := w/2 + h/2;
	constant end_y		: integer := h;
	
	-- ball starting positions (center of ball)
	constant ball_x		: integer := start_x + 2*size + size/2;
	constant ball_y		: integer := start_y + 2*size + size/2;
	
	-- grid definition and mapping
	-- cell_matrix was defined in MazeGame.vhd
	constant amount		: integer := end_y/size; -- number of cells in each row/column
	signal cell_arr : cell_matrix(0 to amount, 0 to amount) := (others => (others => (others => '0')));
	
begin
	---------------------------------------------------------------------------
	-- EDIT THIS SECTION TO DEFINE MAP COMPONENTS
	-- marking which cells are which components
	-- 00 = nothing (default), 01 = wall, 10 = exit
	-- Format is cell_arr(y_pos, x_pos) <= [value];
	---------------------------------------------------------------------------
	cell_arr(1,1) 	<= "01";
	cell_arr(2,1) 	<= "01";
	cell_arr(3,1) 	<= "01";
	cell_arr(4,1)	<= "01";
	cell_arr(5,1) 	<= "01";
	cell_arr(6,1) 	<= "01";
	cell_arr(7,1) 	<= "01";
	cell_arr(8,1) 	<= "01";
	cell_arr(9,1) 	<= "01";
	cell_arr(10,1) 	<= "01";
	cell_arr(11,1) 	<= "01";
	cell_arr(12,1) 	<= "01";
	cell_arr(13,1) 	<= "01";
	cell_arr(14,1) 	<= "01";
	cell_arr(15,1) 	<= "01";
	cell_arr(16,1) 	<= "01";
	cell_arr(17,1) 	<= "01";
	cell_arr(18,1) 	<= "01";
	cell_arr(19,1) 	<= "01";
	cell_arr(20,1) 	<= "01";
	cell_arr(21,1) 	<= "01";
	cell_arr(22,1) 	<= "01";
	cell_arr(23,1) 	<= "01";
	cell_arr(24,1) 	<= "01";
	cell_arr(25,1) 	<= "01";
	cell_arr(26,1) 	<= "01";
	cell_arr(27,1) 	<= "01";
	cell_arr(28,1) 	<= "01";
	
	cell_arr(1,2) 	<= "01";
	cell_arr(1,3) 	<= "01";
	cell_arr(1,4) 	<= "01";
	cell_arr(1,5) 	<= "01";
	cell_arr(1,6) 	<= "01";
	cell_arr(1,7) 	<= "01";
	cell_arr(1,8) 	<= "01";
	cell_arr(1,9) 	<= "01";
	cell_arr(1,10) 	<= "01";
	cell_arr(1,11) 	<= "01";
	cell_arr(1,12) 	<= "01";
	cell_arr(1,13) 	<= "01";
	cell_arr(1,14) 	<= "01";
	cell_arr(1,15) 	<= "01";
	cell_arr(1,16) 	<= "01";
	cell_arr(1,17) 	<= "01";
	cell_arr(1,18) 	<= "01";
	cell_arr(1,19) 	<= "01";
	cell_arr(1,20) 	<= "01";
	cell_arr(1,21) 	<= "01";
	cell_arr(1,22) 	<= "01";
	cell_arr(1,23) 	<= "01";
	cell_arr(1,24) 	<= "01";
	cell_arr(1,25) 	<= "01";
	cell_arr(1,26) 	<= "01";
	cell_arr(1,27) 	<= "01";
	cell_arr(1,28) 	<= "01";

	cell_arr(2,28) 	<= "01";
	cell_arr(3,28) 	<= "01";
	cell_arr(4,28) 	<= "01";
	cell_arr(5,28) 	<= "01";
	cell_arr(6,28) 	<= "01";
	cell_arr(7,28) 	<= "01";
	cell_arr(8,28) 	<= "01";
	cell_arr(9,28) 	<= "01";
	cell_arr(10,28) <= "01";
	cell_arr(11,28) <= "01";
	cell_arr(12,28) <= "01";
	cell_arr(13,28) <= "01";
	cell_arr(16,28) <= "01";
	cell_arr(17,28) <= "01";
	cell_arr(18,28) <= "01";
	cell_arr(19,28) <= "01";
	cell_arr(20,28) <= "01";
	cell_arr(21,28) <= "01";
	cell_arr(22,28) <= "01";
	cell_arr(23,28) <= "01";
	cell_arr(24,28) <= "01";
	cell_arr(25,28) <= "01";
	cell_arr(26,28) <= "01";
	cell_arr(27,28) <= "01";
	cell_arr(28,28) <= "01";
	
	cell_arr(28,2) 	<= "01";
	cell_arr(28,3) 	<= "01";
	cell_arr(28,4) 	<= "01";
	cell_arr(28,5) 	<= "01";
	cell_arr(28,6) 	<= "01";
	cell_arr(28,7) 	<= "01";
	cell_arr(28,8) 	<= "01";
	cell_arr(28,9) 	<= "01";
	cell_arr(28,10) <= "01";
	cell_arr(28,11) <= "01";
	cell_arr(28,12) <= "01";
	cell_arr(28,13) <= "01";
	cell_arr(28,14) <= "01";
	cell_arr(28,15) <= "01";
	cell_arr(28,16) <= "01";
	cell_arr(28,17) <= "01";
	cell_arr(28,18) <= "01";
	cell_arr(28,19) <= "01";
	cell_arr(28,20) <= "01";
	cell_arr(28,21) <= "01";
	cell_arr(28,22) <= "01";
	cell_arr(28,23) <= "01";
	cell_arr(28,24) <= "01";
	cell_arr(28,25) <= "01";
	cell_arr(28,26) <= "01";
	cell_arr(28,27) <= "01";
	
	cell_arr(13,29) <= "01";
	cell_arr(16,29) <= "01";
	
	cell_arr(14,29) <= "10";
	cell_arr(15,29) <= "10";

	---------------------------------------------------------------------------
	
	cell_size_out 	<= conv_std_logic_vector(size, 11);
	start_x_out 	<= conv_std_logic_vector(start_x, 11);
	start_y_out		<= conv_std_logic_vector(start_y, 11);
	end_x_out 		<= conv_std_logic_vector(end_x, 11);
	end_y_out		<= conv_std_logic_vector(end_y, 11);
	
	ball_x_init_out <= conv_std_logic_vector(ball_x, 11);
	ball_y_init_out <= conv_std_logic_vector(ball_y, 11);

	cell_arr_out	<= cell_arr;
	
end Behavioral;
