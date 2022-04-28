# How to Play: MazeGame

MazeGame is your very typical... well, maze game. You control a ball and move through a maze to reach the exit, which is marked by green blocks. Reaching the exit will move you to the next level. Since I built this game on the [NI Digilent Nexys A7-100T FPGA Trainer Board](https://digilent.com/reference/programmable-logic/nexys-a7/start?redirect=1), the controls are using the buttons on the board and are as follows:

1. BTNU = move up
2. BTND = move down
3. BTNL = move left
4. BTNR = move right
5. BTNC = reset the ball to its starting position
6. CPU_RESET = return to the first level

Please try to only press one button at a time as that will provide the most "working" version of the game.

**NOTE: There are some known issues/bugs with the current setup, but it should not affect the way MazeGame is played. The issues are as such:**
1. *If the ball is against a "wall" component and the user continues to press the same directional button repeatedly, the ball will clip into the "wall" slightly, but stop at a certain point.*
	1. Should not affect the game since the ball is unable to completely go through the "wall" and must go in the opposite direction to get out of the "wall." Unfortunately, I am unsure of why this is possible and can not suggest a fix at the moment.
2. *Since only the 4 edge pixels of the ball are being checked, the ball is able to visually slide into the "wall" at corners if the edge pixel that is being checked is just slightly above the "wall".*
	1. Again, the ball is still unable to completely go through such "walls", thus this shouldn't be an issue. To fix this, the module would have to check every pixel along the ball's edge (which would be tedious).
3. *If the movement buttons are pressed in a certain manner, the ball is sometimes able to move diagonally and is able to bypass all components*
	1. Unfortunately, I am also unsure of why this is possible since I have made the motion `if` conditions strict. Only when one button is pressed and the other three are not should the ball gain motion in the corresponding direction. Usually, entering and exiting this "diagonal" state is hard to control and the user would most likely have to reset the ball's position to continue playing.
