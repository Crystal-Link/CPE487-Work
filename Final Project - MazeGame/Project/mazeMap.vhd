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

entity mazeMap is
	Port ( 
		v_sync    : in std_logic;
		pixel_row : in std_logic_vector(10 downto 0); -- pixel y position
		pixel_col : in std_logic_vector(10 downto 0); -- pixel x position
		red       : out std_logic_vector (3 downto 0);
		green     : out std_logic_vector (3 downto 0);
		blue      : out std_logic_vector (3 downto 0);
		
		cell_size_in	: in integer;
		start_x_in		: in integer;
		start_y_in		: in integer;
		end_x_in		: in integer;
		end_y_in		: in integer;
		
		components_in	: in std_logic_vector(1 downto 0)
	);
end mazeMap;

architecture Behavioral of mazeMap is
	-- cell size
	constant size		: integer := cell_size_in;
	
	-- starting and ending pixels
	constant start_x	: integer := start_x_in;
	constant start_y	: integer := start_y_in;
	constant end_x		: integer := end_x_in;
	constant end_y		: integer := end_y_in;
	
	
begin
	draw_map : process (pixel_row, pixel_col) is
		-- initiate pixel position variables
		constant x_pos : integer := conv_integer(pixel_col);
		constant y_pos : integer := conv_integer(pixel_row);
	begin		
		if (((x_pos >= start_x) and (x_pos <= end_x)) and ((y_pos >= start_y) and (y_pos <= end_y))) then
			-- uncomment if you want the grid
			--if (((x_pos - start_x) mod size) = 0) or (((y_pos - start_y) mod size) = 0) then
			--	red   <= "0000";
			--	green <= "0000";
			--	blue  <= "0000";
			--else
				-- 00 = nothing (default), 01 = wall, 10 = exit
				if (components_in = "01") then  	-- walls are colored black
					red   <= "0000";
					green <= "0000";
					blue  <= "0000";
				elsif (components_in = "10") then 	-- exits are colored green
					red   <= "0000";
					green <= "1000";
					blue  <= "0000";
				else							--  otherwise white
					red   <= "1000";
					green <= "1000";
					blue  <= "1000";
				end if;
			--end if;
		else
		  red   <= "0000";
		  green <= "0000";
		  blue  <= "1000";
		end if;
	end process;

end Behavioral;
