# Implementing New Levels: MazeGame

This document will describe how to create and implement new levels to the MazeGame project.

### 1. Create a new design source for your new level

* You may call it whatever you want. For simplicity sake, I would name them level__.vhd 

* Using _level0.vhd_ or _level1.vhd_ as a template, copy paste either code into your new design source.

* Using the section that is marked out and the given format, mark each cell with the component you want to place at that cell

* Save the file.

###### NOTE: If you wish to change the map size, the parameters are at the beginning of the architecture section. Just know that you will also have to change similar parameters in top level should you wish to do so.

### 2. At the top level, MazeGame.vhd, create new signals for the level, add the level as a component, and map the ports between the signals and the components

* For each level, eight signals are required (for each of its outputs)
	* The signals are as follows (just replace the 0 with your level number)
	```
	SIGNAL ball_x_init_0, ball_y_init_0 : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL cell_size_0, start_x_0, start_y_0 : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL end_x_0, end_y_0 : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL cell_arr_0 : CELL_MATRIX(0 TO amount, 0 TO amount);
	```

* The component block is as follows (again replace the 0 in the component name with your level number):
	``` 
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
	```

* The port mapping is as follows (again replace the 0s with your level number) :
	``` 
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
	```

* Be sure to add onto the if block in the process so that the program will cycle to your level given a certain level count. For example:
	```
		if (level_count = "000") then
			cell_size_pass <= cell_size_0;
			start_x_pass <= start_x_0;
			start_y_pass <= start_y_0;
			end_x_pass <= end_x_0;
			end_y_pass <= end_y_0;
			ball_x_init_pass <= ball_x_init_0;
			ball_y_init_pass <= ball_y_init_0;
			cell_arr_pass <= cell_arr_0;
		elsif [INSERT ANOTHER CONDITOIN]
			cell_size_pass <= [ANOTHER LEVEL'S SIGNALS];
			...
		end if;
	```

### 3. Build the project and play!

###### NOTE: If you intend on adding more components into the game, then you might want to increase the number of bits in each cell of cell_arr so you can designate unique symbols to each component.
