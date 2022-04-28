----------------------------------------------------------------------------------
--
-- Level 1 of MazeGame
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

entity level1 is
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
end level1;

architecture Behavioral of level1 is
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
	constant ball_x		: integer := start_x + 14*size;
	constant ball_y		: integer := start_y + 29*size + size/2;
	
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
	
	-- I used this map as reference for this level:
	-- https://www.reddit.com/r/dndmaps/comments/inphp7/hedge_maze_30x30/

	cell_arr(0,26)	<= "10";
	cell_arr(0,27)	<= "10";
	
	cell_arr(0,0) 	<= "01";
	cell_arr(0,1) 	<= "01";
	cell_arr(0,2) 	<= "01";
	cell_arr(0,3) 	<= "01";
	cell_arr(0,4) 	<= "01";
	cell_arr(0,5) 	<= "01";
	cell_arr(0,6) 	<= "01";
	cell_arr(0,7) 	<= "01";
	cell_arr(0,8) 	<= "01";
	cell_arr(0,9) 	<= "01";
	cell_arr(0,10) 	<= "01";
	cell_arr(0,11) 	<= "01";
	cell_arr(0,12) 	<= "01";
	cell_arr(0,13) 	<= "01";
	cell_arr(0,14) 	<= "01";
	cell_arr(0,15) 	<= "01";
	cell_arr(0,16) 	<= "01";
	cell_arr(0,17) 	<= "01";
	cell_arr(0,18) 	<= "01";
	cell_arr(0,19) 	<= "01";
	cell_arr(0,20) 	<= "01";
	cell_arr(0,21) 	<= "01";
	cell_arr(0,22) 	<= "01";
	cell_arr(0,23) 	<= "01";
	cell_arr(0,24) 	<= "01";
	cell_arr(0,25) 	<= "01";
	cell_arr(0,28) 	<= "01";
	cell_arr(0,29) 	<= "01";
	
	cell_arr(1,0) 	<= "01";
	cell_arr(1,17) 	<= "01";
	cell_arr(1,20) 	<= "01";
	cell_arr(1,25) 	<= "01";
	cell_arr(1,28) 	<= "01";
	cell_arr(1,29) 	<= "01";
	
	cell_arr(2,0) 	<= "01";
	cell_arr(2,17) 	<= "01";
	cell_arr(2,20) 	<= "01";
	cell_arr(2,25) 	<= "01";
	cell_arr(2,28) 	<= "01";
	cell_arr(2,29) 	<= "01";
	
	cell_arr(3,0) 	<= "01";
	cell_arr(3,3) 	<= "01";
	cell_arr(3,6) 	<= "01";
	cell_arr(3,7) 	<= "01";
	cell_arr(3,8) 	<= "01";
	cell_arr(3,9) 	<= "01";
	cell_arr(3,12) 	<= "01";
	cell_arr(3,15) 	<= "01";
	cell_arr(3,16) 	<= "01";
	cell_arr(3,17) 	<= "01";
	cell_arr(3,20) 	<= "01";
	cell_arr(3,23) 	<= "01";
	cell_arr(3,24) 	<= "01";
	cell_arr(3,25) 	<= "01";
	cell_arr(3,28) 	<= "01";
	cell_arr(3,29) 	<= "01";
	
	cell_arr(4,0) 	<= "01";
	cell_arr(4,3) 	<= "01";
	cell_arr(4,4) 	<= "01";
	cell_arr(4,5) 	<= "01";
	cell_arr(4,6) 	<= "01";
	cell_arr(4,9) 	<= "01";
	cell_arr(4,10) 	<= "01";
	cell_arr(4,11) 	<= "01";
	cell_arr(4,12) 	<= "01";
	cell_arr(4,20) 	<= "01";
	cell_arr(4,28) 	<= "01";
	cell_arr(4,29) 	<= "01";
	
	cell_arr(5,0) 	<= "01";
	cell_arr(5,12) 	<= "01";
	cell_arr(5,20) 	<= "01";
	cell_arr(5,28) 	<= "01";
	cell_arr(5,29) 	<= "01";
	
	cell_arr(6,0) 	<= "01";
	cell_arr(6,9) 	<= "01";
	cell_arr(6,10) 	<= "01";
	cell_arr(6,12) 	<= "01";
	cell_arr(6,13) 	<= "01";
	cell_arr(6,14) 	<= "01";
	cell_arr(6,17) 	<= "01";
	cell_arr(6,18) 	<= "01";
	cell_arr(6,19) 	<= "01";
	cell_arr(6,20) 	<= "01";
	cell_arr(6,23) 	<= "01";
	cell_arr(6,24) 	<= "01";
	cell_arr(6,25) 	<= "01";
	cell_arr(6,26) 	<= "01";
	cell_arr(6,27) 	<= "01";
	cell_arr(6,28) 	<= "01";
	cell_arr(6,29) 	<= "01";
	
	cell_arr(7,0) 	<= "01";
	cell_arr(7,1) 	<= "01";
	cell_arr(7,2) 	<= "01";
	cell_arr(7,3) 	<= "01";
	cell_arr(7,4) 	<= "01";
	cell_arr(7,5) 	<= "01";
	cell_arr(7,6) 	<= "01";
	cell_arr(7,9) 	<= "01";
	cell_arr(7,10) 	<= "01";
	cell_arr(7,12) 	<= "01";
	cell_arr(7,14) 	<= "01";
	cell_arr(7,17) 	<= "01";
	cell_arr(7,23) 	<= "01";
	cell_arr(7,29) 	<= "01";
	
	cell_arr(8,0) 	<= "01";
	cell_arr(8,6) 	<= "01";
	cell_arr(8,9) 	<= "01";
	cell_arr(8,12) 	<= "01";
	cell_arr(8,17) 	<= "01";
	cell_arr(8,23) 	<= "01";
	cell_arr(8,29) 	<= "01";
	
	cell_arr(9,0) 	<= "01";
	cell_arr(9,6) 	<= "01";
	cell_arr(9,9) 	<= "01";
	cell_arr(9,12) 	<= "01";
	cell_arr(9,13) 	<= "01";
	cell_arr(9,14) 	<= "01";
	cell_arr(9,17) 	<= "01";
	cell_arr(9,23) 	<= "01";
	cell_arr(9,26) 	<= "01";
	cell_arr(9,29) 	<= "01";
	
	cell_arr(10,0) 	<= "01";
	cell_arr(10,3) 	<= "01";
	cell_arr(10,6) 	<= "01";
	cell_arr(10,9) 	<= "01";
	cell_arr(10,10) <= "01";
	cell_arr(10,11) <= "01";
	cell_arr(10,12) <= "01";
	cell_arr(10,13) <= "01";
	cell_arr(10,14) <= "01";
	cell_arr(10,17) <= "01";
	cell_arr(10,23) <= "01";
	cell_arr(10,26) <= "01";
	cell_arr(10,29) <= "01";
	
	cell_arr(11,0) 	<= "01";
	cell_arr(11,3) 	<= "01";
	cell_arr(11,14) <= "01";
	cell_arr(11,17) <= "01";
	cell_arr(11,23) <= "01";
	cell_arr(11,24) <= "01";
	cell_arr(11,25) <= "01";
	cell_arr(11,26) <= "01";
	cell_arr(11,29) <= "01";
	
	cell_arr(12,0) 	<= "01";
	cell_arr(12,3) 	<= "01";
	cell_arr(12,14) <= "01";
	cell_arr(12,17) <= "01";
	cell_arr(12,23) <= "01";
	cell_arr(12,24) <= "01";
	cell_arr(12,25) <= "01";
	cell_arr(12,26) <= "01";
	cell_arr(12,29) <= "01";
	
	cell_arr(13,0) 	<= "01";
	cell_arr(13,2) 	<= "01";
	cell_arr(13,3) 	<= "01";
	cell_arr(13,6) 	<= "01";
	cell_arr(13,7) 	<= "01";
	cell_arr(13,8) 	<= "01";
	cell_arr(13,9) 	<= "01";
	cell_arr(13,10) <= "01";
	cell_arr(13,11) <= "01";
	cell_arr(13,14) <= "01";
	cell_arr(13,17) <= "01";
	cell_arr(13,18) <= "01";
	cell_arr(13,19) <= "01";
	cell_arr(13,22) <= "01";
	cell_arr(13,23) <= "01";
	cell_arr(13,26) <= "01";
	cell_arr(13,29) <= "01";
	
	cell_arr(14,0) 	<= "01";
	cell_arr(14,11) <= "01";
	cell_arr(14,14) <= "01";
	cell_arr(14,22) <= "01";
	cell_arr(14,23) <= "01";
	cell_arr(14,26) <= "01";
	cell_arr(14,29) <= "01";
	
	cell_arr(15,0) 	<= "01";
	cell_arr(15,11) <= "01";
	cell_arr(15,14) <= "01";
	cell_arr(15,22) <= "01";
	cell_arr(15,29) <= "01";
	
	cell_arr(16,0) 	<= "01";
	cell_arr(16,1) 	<= "01";
	cell_arr(16,2) 	<= "01";
	cell_arr(16,3) 	<= "01";
	cell_arr(16,4) 	<= "01";
	cell_arr(16,5) 	<= "01";
	cell_arr(16,6) 	<= "01";
	cell_arr(16,7) 	<= "01";
	cell_arr(16,8) 	<= "01";
	cell_arr(16,11) <= "01";
	cell_arr(16,14) <= "01";
	cell_arr(16,15) <= "01";
	cell_arr(16,16) <= "01";
	cell_arr(16,17) <= "01";
	cell_arr(16,18) <= "01";
	cell_arr(16,19) <= "01";
	cell_arr(16,20) <= "01";
	cell_arr(16,21) <= "01";
	cell_arr(16,22) <= "01";
	cell_arr(16,29) <= "01";
	
	cell_arr(17,0) 	<= "01";
	cell_arr(17,8) 	<= "01";
	cell_arr(17,11) <= "01";
	cell_arr(17,22) <= "01";
	cell_arr(17,23) <= "01";
	cell_arr(17,24) <= "01";
	cell_arr(17,25) <= "01";
	cell_arr(17,26) <= "01";
	cell_arr(17,29) <= "01";
	
	cell_arr(18,0) 	<= "01";
	cell_arr(18,8) 	<= "01";
	cell_arr(18,11) <= "01";
	cell_arr(18,22) <= "01";
	cell_arr(18,23) <= "01";
	cell_arr(18,24) <= "01";
	cell_arr(18,25) <= "01";
	cell_arr(18,26) <= "01";
	cell_arr(18,29) <= "01";
	
	cell_arr(19,0) 	<= "01";
	cell_arr(19,3) 	<= "01";
	cell_arr(19,4) 	<= "01";
	cell_arr(19,5) 	<= "01";
	cell_arr(19,6) 	<= "01";
	cell_arr(19,7) 	<= "01";
	cell_arr(19,8) 	<= "01";
	cell_arr(19,11) <= "01";
	cell_arr(19,12) <= "01";
	cell_arr(19,13) <= "01";
	cell_arr(19,14) <= "01";
	cell_arr(19,15) <= "01";
	cell_arr(19,16) <= "01";
	cell_arr(19,17) <= "01";
	cell_arr(19,18) <= "01";
	cell_arr(19,19) <= "01";
	cell_arr(19,22) <= "01";
	cell_arr(19,23) <= "01";
	cell_arr(19,29) <= "01";
	
	cell_arr(20,0) 	<= "01";
	cell_arr(20,3) 	<= "01";
	cell_arr(20,11) <= "01";
	cell_arr(20,12) <= "01";
	cell_arr(20,19) <= "01";
	cell_arr(20,22) <= "01";
	cell_arr(20,23) <= "01";
	cell_arr(20,29) <= "01";
	
	cell_arr(21,0) 	<= "01";
	cell_arr(21,3) 	<= "01";
	cell_arr(21,11) <= "01";
	cell_arr(21,12) <= "01";
	cell_arr(21,19) <= "01";
	cell_arr(21,26) <= "01";
	cell_arr(21,29) <= "01";
	
	cell_arr(22,0) 	<= "01";
	cell_arr(22,3) 	<= "01";
	cell_arr(22,6) 	<= "01";
	cell_arr(22,7) 	<= "01";
	cell_arr(22,8) 	<= "01";
	cell_arr(22,9) 	<= "01";
	cell_arr(22,10) <= "01";
	cell_arr(22,11) <= "01";
	cell_arr(22,12) <= "01";
	cell_arr(22,15) <= "01";
	cell_arr(22,17) <= "01";
	cell_arr(22,18) <= "01";
	cell_arr(22,19) <= "01";
	cell_arr(22,26) <= "01";
	cell_arr(22,29) <= "01";
	
	cell_arr(23,0) 	<= "01";
	cell_arr(23,3) 	<= "01";
	cell_arr(23,6) 	<= "01";
	cell_arr(23,15) <= "01";
	cell_arr(23,17) <= "01";
	cell_arr(23,18) <= "01";
	cell_arr(23,19) <= "01";
	cell_arr(23,20) <= "01";
	cell_arr(23,21) <= "01";
	cell_arr(23,22) <= "01";
	cell_arr(23,23) <= "01";
	cell_arr(23,26) <= "01";
	cell_arr(23,27) <= "01";
	cell_arr(23,28) <= "01";
	cell_arr(23,29) <= "01";
	
	cell_arr(24,0) 	<= "01";
	cell_arr(24,3) 	<= "01";
	cell_arr(24,6) 	<= "01";
	cell_arr(24,15) <= "01";
	cell_arr(24,23) <= "01";
	cell_arr(24,29) <= "01";
	
	cell_arr(25,0) 	<= "01";
	cell_arr(25,3) 	<= "01";
	cell_arr(25,6) 	<= "01";
	cell_arr(25,7) 	<= "01";
	cell_arr(25,8) 	<= "01";
	cell_arr(25,9) 	<= "01";
	cell_arr(25,10) <= "01";
	cell_arr(25,11) <= "01";
	cell_arr(25,12) <= "01";
	cell_arr(25,15) <= "01";
	cell_arr(25,23) <= "01";
	cell_arr(25,29) <= "01";
	
	cell_arr(26,0) 	<= "01";
	cell_arr(26,15) <= "01";
	cell_arr(26,16) <= "01";
	cell_arr(26,17) <= "01";
	cell_arr(26,18) <= "01";
	cell_arr(26,19) <= "01";
	cell_arr(26,20) <= "01";
	cell_arr(26,23) <= "01";
	cell_arr(26,24) <= "01";
	cell_arr(26,25) <= "01";
	cell_arr(26,26) <= "01";
	cell_arr(26,29) <= "01";
	
	cell_arr(27,0) 	<= "01";
	cell_arr(27,15) <= "01";
	cell_arr(27,29) <= "01";
	
	cell_arr(28,0) 	<= "01";
	cell_arr(28,1) 	<= "01";
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
	cell_arr(28,15) <= "01";
	cell_arr(28,29) <= "01";
	
	cell_arr(29,0) 	<= "01";
	cell_arr(29,1) 	<= "01";
	cell_arr(29,2) 	<= "01";
	cell_arr(29,3) 	<= "01";
	cell_arr(29,4) 	<= "01";
	cell_arr(29,5) 	<= "01";
	cell_arr(29,6) 	<= "01";
	cell_arr(29,7) 	<= "01";
	cell_arr(29,8) 	<= "01";
	cell_arr(29,9) 	<= "01";
	cell_arr(29,10) <= "01";
	cell_arr(29,11) <= "01";
	cell_arr(29,12) <= "01";
	cell_arr(29,15) <= "01";
	cell_arr(29,16) <= "01";
	cell_arr(29,17) <= "01";
	cell_arr(29,18) <= "01";
	cell_arr(29,19) <= "01";
	cell_arr(29,20) <= "01";
	cell_arr(29,21) <= "01";
	cell_arr(29,22) <= "01";
	cell_arr(29,23) <= "01";
	cell_arr(29,24) <= "01";
	cell_arr(29,25) <= "01";
	cell_arr(29,26) <= "01";
	cell_arr(29,27) <= "01";
	cell_arr(29,28) <= "01";
	cell_arr(29,29) <= "01";
	
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
