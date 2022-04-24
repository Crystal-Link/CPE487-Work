----------------------------------------------------------------------------------
--
-- Level 0 of MazeGame
-- 
-- Defines the properties of the game for this level
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity level0 is
	Port ( 
		pixel_row : in std_logic_vector(10 downto 0); -- pixel y position
		pixel_col : in std_logic_vector(10 downto 0); -- pixel x position
		
		cell_size_out	: out integer;
		start_x_out		: out integer;
		start_y_out		: out integer;
		end_x_out		: out integer;
		end_y_out		: out integer;
		
		-- you might have to increase number of bits depending on how many components there are
		components_out	: out std_logic_vector(1 downto 0) -- bit string for component definition
	);
end level0;

architecture Behavioral of level0 is
	-- map dimensions and cell size
	constant size		: integer := 24;   	-- please make sure h/size is an integer
	constant w			: integer := 1280;
	constant h			: integer := 720;
	
	-- starting and ending pixels
	-- this maps a square at the center of the screen
	constant start_x	: integer := w/2 - h/2;
	constant start_y	: integer := 0;
	constant end_x		: integer := w/2 + h/2;
	constant end_y		: integer := h;
	
	-- grid definition and mapping
	-- defines the grid as a N by N 2d array where each cell contains a std_logic_vector
	constant amount		: integer := h/size; -- number of cells in each row/column
	type cell_matrix is array (0 to amount, 0 to amount) of std_logic_vector(1 downto 0); -- # of bits depends on # of components
	signal cell_arr : cell_matrix := (others => (others => (others => '0')));
	
	signal fill_x, fill_y   : integer;
	
begin
	---------------------------------------------------------------------------
	-- EDIT THIS SECTION TO DEFINE MAP COMPONENTS
	-- marking which cells are which components
	-- 00 = nothing (default), 01 = wall, 10 = exit
	---------------------------------------------------------------------------
	cell_arr(1,1) <= "01";
	cell_arr(2,2) <= "01";
	cell_arr(3,3) <= "10";

	cell_arr(10, 0) <= "01";
	cell_arr(10, 1) <= "01";
	cell_arr(10, 2) <= "01";
	cell_arr(10, 3) <= "01";
	cell_arr(10, 4) <= "01";
	cell_arr(10, 5) <= "01";
	
	cell_arr(0, 10) <= "01";
	cell_arr(1, 10) <= "01";
	cell_arr(2, 10) <= "01";
	cell_arr(3, 10) <= "01";
	cell_arr(4, 10) <= "01";
	cell_arr(5, 10) <= "01";

	---------------------------------------------------------------------------
	
	-- determines the vector output for each pixel
	determine_cell : process (pixel_row, pixel_col) is
		-- initiate pixel position variables
		constant x_pos : integer := conv_integer(pixel_col);
		constant y_pos : integer := conv_integer(pixel_row);
	begin
		-- integer math maps each cell area to its respective corner
		-- therefore, every pixel in a cell area maps to the same value at the corner
		fill_x <= (x_pos - start_x) / size;
		fill_y <= (y_pos - start_y) / size;
		
		components_out <= cell_arr(fill_y, fill_x); 	
	end process;
	
	cell_size_out 	<= size;
	start_x_out 	<= start_x;
	start_y_out		<= start_y;
	end_x_out 		<= end_x;
	end_y_out		<= end_y;

end Behavioral;
