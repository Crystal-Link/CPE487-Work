----------------------------------------------------------------------------------
-- Creation of the maze's map
-- 
-- First creates a grid, which will then get filled in
-- selectively by black squares which will act as "walls"
-- and a green square as an "exit" for the maze
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- package definition from MazeGame.vhd
use work.all;
use work.cell_matrix_def.all;

entity mazeMap is
	Port ( 
		pixel_row : in std_logic_vector(10 downto 0); -- pixel y position
		pixel_col : in std_logic_vector(10 downto 0); -- pixel x position
		red       : out std_logic_vector (3 downto 0);
		green     : out std_logic_vector (3 downto 0);
		blue      : out std_logic_vector (3 downto 0);
		
		cell_size_in	: in std_logic_vector(10 downto 0);
		start_x_in		: in std_logic_vector(10 downto 0);
		start_y_in		: in std_logic_vector(10 downto 0);
		end_x_in		: in std_logic_vector(10 downto 0);
		end_y_in		: in std_logic_vector(10 downto 0);
		
		cell_arr_in		: in cell_matrix
	);
end mazeMap;

architecture Behavioral of mazeMap is
	-- cell size
	constant size		: integer := conv_integer(cell_size_in); -- is currently unused since we're not drawing the grid
	
	-- starting and ending pixels
	constant start_x	: integer := conv_integer(start_x_in);
	constant start_y	: integer := conv_integer(start_y_in);
	constant end_x		: integer := conv_integer(end_x_in);
	constant end_y		: integer := conv_integer(end_y_in);
	
	-- signals to calculate cell mapping
	signal fill_x, fill_y   : integer;
	
begin
	draw_map : process (pixel_row, pixel_col) is
		-- initiate pixel position constants
		constant x_pos : integer := conv_integer(pixel_col);
		constant y_pos : integer := conv_integer(pixel_row);
	begin		
		if (((x_pos >= start_x) and (x_pos < end_x)) and ((y_pos >= start_y) and (y_pos < end_y))) then
			
			-- integer math maps each cell area to its respective corner
			-- therefore, every pixel in a cell area maps to the same value at the corner
			fill_x <= (x_pos - start_x) / size;
			fill_y <= (y_pos - start_y) / size;
			
			-- uncomment if you want the grid
			--if (((x_pos - start_x) mod size) = 0) or (((y_pos - start_y) mod size) = 0) then
			--	red   <= "0000";
			--	green <= "0000";
			--	blue  <= "0000";
			--else
				-- 00 = nothing (default), 01 = wall, 10 = exit
				if (cell_arr_in(fill_y, fill_x) = "01") then  	-- walls are colored black
					red   <= "0000";
					green <= "0000";
					blue  <= "0000";
				elsif (cell_arr_in(fill_y, fill_x) = "10") then 	-- exits are colored green
					red   <= "0000";
					green <= "1000";
					blue  <= "0000";
				else								--  otherwise white
					red   <= "1000";
					green <= "1000";
					blue  <= "1000";
				end if;
			--end if;
		else
			-- out of bounds = black
			red   <= "0000";
			green <= "0000";
			blue  <= "0000";
		end if;
	end process;

end Behavioral;
