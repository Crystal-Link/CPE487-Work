LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- package definition from MazeGame.vhd
use work.all;
use work.cell_matrix_def.all;

ENTITY ball IS
	PORT (
		v_sync    : IN STD_LOGIC;
		pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		red       : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		green     : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		blue      : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		
		ball_on_out		 : OUT STD_LOGIC;
		level_count_out	 : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
		cell_arr_in		 : IN CELL_MATRIX;
		
		cell_size_in	: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		start_x_in 		: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		start_y_in 		: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		end_x_in		: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		end_y_in		: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		
		ball_x_init_in : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		ball_y_init_in : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		
		button_reset: IN STD_LOGIC;
		moveL     : IN STD_LOGIC;
		moveR     : IN STD_LOGIC;
		moveU     : IN STD_LOGIC;
		moveD     : IN STD_LOGIC;
		interact  : IN STD_LOGIC
	);
END ball;

ARCHITECTURE Behavioral OF ball IS
	SIGNAL level_count : STD_LOGIC_VECTOR(2 DOWNTO 0) := (others => '0');
	-- intentionally set old counter to be different to
	-- force reset ball initial position
	SIGNAL level_count_old : STD_LOGIC_VECTOR(2 DOWNTO 0) := (others => '1');
	
	CONSTANT size  : INTEGER := 8;
	SIGNAL ball_on : STD_LOGIC; -- indicates whether ball is over current pixel position
	
	-- current ball position - intitialized to center of screen
	SIGNAL ball_x  : STD_LOGIC_VECTOR(10 DOWNTO 0) := ball_x_init_in;
	SIGNAL ball_y  : STD_LOGIC_VECTOR(10 DOWNTO 0) := ball_y_init_in;
	
	constant cell_size  : integer := conv_integer(cell_size_in);
	constant start_x	: integer := conv_integer(start_x_in);
	constant start_y	: integer := conv_integer(start_y_in);
	constant end_x		: integer := conv_integer(end_x_in);
	constant end_y		: integer := conv_integer(end_y_in);
	
	signal fill_x, fill_y   : integer;
	
BEGIN
	red   <= "1000"; -- color setup for red ball
	green <= "0000";
	blue  <= "0000";
	-- process to draw ball current pixel address is covered by ball position
	bdraw : PROCESS (ball_x, ball_y, pixel_row, pixel_col) IS
	BEGIN
        IF ((CONV_INTEGER(pixel_col) - CONV_INTEGER(ball_x))*
        (CONV_INTEGER(pixel_col) - CONV_INTEGER(ball_x))+
        (CONV_INTEGER(pixel_row) - CONV_INTEGER(ball_y))*
        (CONV_INTEGER(pixel_row) - CONV_INTEGER(ball_y)) <= (size*size)) THEN
--		IF (pixel_col >= ball_x - size) AND
--		   	 (pixel_col <= ball_x + size) AND
--			 (pixel_row >= ball_y - size) AND
--			 (pixel_row <= ball_y + size) THEN
				ball_on <= '1';
		ELSE
			ball_on <= '0';
		END IF;
		ball_on_out <= ball_on;
	END PROCESS;
	
	-- process to move ball once every frame (i.e. once every vsync pulse)
	mball : PROCESS
		-- initiate position and motion variables
		VARIABLE x_pos : INTEGER := CONV_INTEGER(ball_x);
		VARIABLE y_pos : INTEGER := CONV_INTEGER(ball_y);
		VARIABLE ball_x_motion : INTEGER := 0;
		VARIABLE ball_y_motion : INTEGER := 0;

	BEGIN
		WAIT UNTIL rising_edge(v_sync);
		
		IF moveL = '1' AND moveR = '0' AND moveU = '0' AND moveD = '0' THEN
			ball_x_motion := -4; -- -4 pixels
		ELSIF moveL = '0' AND moveR = '1' AND moveU = '0' AND moveD = '0' THEN
			ball_x_motion := 4; -- +4 pixels
		ELSIF moveL = '0' AND moveR = '0' AND moveU = '1' AND moveD = '0' THEN
			ball_y_motion := -4; -- -4 pixels
		ELSIF moveL = '0' AND moveR = '0' AND moveU = '0' AND moveD = '1' THEN
			ball_y_motion := 4; -- +4 pixels
		ELSE
			ball_x_motion := 0; -- stop the ball
			ball_y_motion := 0;
		END IF;
		
		-- compute next intended ball position
		x_pos := x_pos + ball_x_motion;
		y_pos := y_pos + ball_y_motion;
		
		-----------------------------------------------------------------
		-- collision checks
		-----------------------------------------------------------------
		-- keep the ball within playing field
		IF x_pos + size >= end_x THEN
			x_pos := end_x - size;
			ball_x_motion := 0;
		ELSIF x_pos - size <= start_x THEN
			x_pos := start_x + size;
			ball_x_motion := 0;
		END IF;
		
		IF y_pos + size >= end_y THEN
			y_pos := end_y - size;
			ball_y_motion := 0;
		ELSIF y_pos - size <= start_y THEN
			y_pos := start_y + size;
			ball_y_motion := 0;
		END IF;
		
		
		-- check for collision with map components
		-- checks position for all 4 directions of the ball (4 points on the edges)
		-- NOTE: The top and left edges requires a slight offset
		IF moveL = '1' AND moveR = '0' AND moveU = '0' AND moveD = '0' THEN
			fill_x <= ((x_pos - size - 3) - start_x) / cell_size;
		ELSIF moveL = '0' AND moveR = '1' AND moveU = '0' AND moveD = '0' THEN
			fill_x <= ((x_pos + size) - start_x) / cell_size;
		ELSIF moveL = '0' AND moveR = '0' AND moveU = '1' AND moveD = '0' THEN
			fill_y <= ((y_pos - size - 3) - start_y) / cell_size;
		ELSIF moveL = '0' AND moveR = '0' AND moveU = '0' AND moveD = '1' THEN
			fill_y <= ((y_pos + size) - start_y) / cell_size;
		ELSE
			fill_x <= ((x_pos) - start_x) / cell_size;
			fill_y <= ((y_pos) - start_y) / cell_size;
		END IF;
		
		-- 00 = nothing (default), 01 = wall, 10 = exit
		IF (cell_arr_in(fill_y, fill_x) = "01") THEN -- wall
			y_pos := y_pos - ball_y_motion;
			ball_y_motion := 0;
			x_pos := x_pos - ball_x_motion;
			ball_x_motion := 0;
		ELSIF (cell_arr_in(fill_y, fill_x) = "10") THEN -- exit
			level_count <= conv_std_logic_vector((conv_integer(level_count) + 1),3);
		END IF;

		-----------------------------------------------------------------
		
		-- reset the ball to initial position
		IF interact = '1' THEN
			x_pos := conv_integer(ball_x_init_in);
			y_pos := conv_integer(ball_y_init_in);
		END IF;
		
		-- reset to level0
		-- CPU_RESETN is inverse to the other buttons
		IF button_reset = '0' THEN
			level_count <= (others => '0');
			level_count_old <= (others => '1');
		END IF;
		
		-- Since signals do not update until the process is finished,
		-- I am adding a second count signal so that once a level change
		-- occurs, this statement triggers and sets the ball to its real
		-- initial position.
		IF level_count_old /= level_count THEN
			x_pos := conv_integer(ball_x_init_in);
			y_pos := conv_integer(ball_y_init_in);
			level_count_old <= level_count;
		END IF;
		
		ball_x  <= CONV_STD_LOGIC_VECTOR(x_pos, 11);
		ball_y  <= CONV_STD_LOGIC_VECTOR(y_pos, 11);
		level_count_out <= level_count;
	END PROCESS;
	
END Behavioral;