----------------------------------------------------------------------------------
-- Creation of the maze's map
-- 
-- First creates a grid, which will then get filled in
-- selectively by black squares which will act as "walls"
-- for the maze
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mazeMap is
	Port ( 
		v_sync    : IN STD_LOGIC;
		pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0); -- pixel y position
		pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0); -- pixel x position
		red       : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		green     : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		blue      : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
	);
end mazeMap;

architecture Behavioral of mazeMap is
	-- map dimensions and grid size
	constant size		: INTEGER := 25;
	constant w			: INTEGER := 1280;
	constant h			: INTEGER := 720;
	
	-- starting and ending pixels
	-- this maps a square at the center of the screen
	constant start_x	: INTEGER := w/2 - h/2;
	constant start_y	: INTEGER := 0;
	constant end_x		: INTEGER := w/2 + h/2;
	constant end_y		: INTEGER := h;
	
begin
	draw_grid : process (pixel_row, pixel_col) is
		-- initiate pixel position variables
		constant x_pos : integer := conv_integer(pixel_col);
		constant y_pos : integer := conv_integer(pixel_row);
	begin
		if (((x_pos >= start_x) and (x_pos <= end_x)) and ((y_pos >= start_y) and (y_pos <= end_y))) then
		  if (((x_pos - start_x) mod size) = 0) or (((y_pos - start_y) mod size) = 0) then
			red   <= "0000";
			green <= "0000";
			blue  <= "0000";
		  else
			red   <= "1000";
			green <= "1000";
			blue  <= "1000";
		  end if;
		else
		  red   <= "0000";
		  green <= "0000";
		  blue  <= "1000";
		end if;
	end process;

end Behavioral;
