LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ball IS
	PORT (
		v_sync    : IN STD_LOGIC;
		pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		red       : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		green     : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		blue      : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		
		ball_on_out		 : OUT STD_LOGIC;
		components_in	 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		
		moveL     : IN STD_LOGIC;
		moveR     : IN STD_LOGIC;
		moveU     : IN STD_LOGIC;
		moveD     : IN STD_LOGIC;
		interact  : IN STD_LOGIC
	);
END ball;

ARCHITECTURE Behavioral OF ball IS
	CONSTANT size  : INTEGER := 8;
	SIGNAL ball_on : STD_LOGIC; -- indicates whether ball is over current pixel position
	
	-- current ball position - intitialized to center of screen
	SIGNAL ball_x  : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(640, 11);
	SIGNAL ball_y  : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(360, 11);
	
BEGIN
	red   <= "1000"; -- color setup for red ball
	green 	<= "0000";
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
		
		-- collision check
		IF x_pos + size >= 1280 THEN
			x_pos := 1280 - size;
			ball_x_motion := 0;
		ELSIF x_pos <= size THEN
			x_pos := 0 + size;
			ball_x_motion := 0;
		END IF;
		
		IF y_pos + size >= 720 THEN
			y_pos := 720 - size;
			ball_y_motion := 0;
		ELSIF y_pos <= size THEN
			y_pos := 0 + size;
			ball_y_motion := 0;
		END IF;
		
		IF interact = '1' THEN
			x_pos := 640;
			y_pos := 360;
		END IF;
		
		ball_x  <= CONV_STD_LOGIC_VECTOR(x_pos, 11);
		ball_y  <= CONV_STD_LOGIC_VECTOR(y_pos, 11);
		
	END PROCESS;
END Behavioral;