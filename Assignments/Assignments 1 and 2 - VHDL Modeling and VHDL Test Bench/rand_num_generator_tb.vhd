-- CPE 487 Spring 2022 Assignment 2: VHDL Test Bench
-- Calvin Zheng
-- Based on the Simple testbench for half adder (found at https://vhdlguide.readthedocs.io/en/latest/vhdl/testbench.html) as well as example testbench code from dsd/ghdl on GitHub.
-- Plus additional research on testbench clocks

-- rand_num_generator_tb.vhd


library ieee;
use ieee.std_logic_1164.all;


entity rand_num_generator_tb is
    generic (N :integer := 3);
end rand_num_generator_tb;

architecture tb of rand_num_generator_tb is
    signal clk : std_logic := '1'; -- initialize clock
	signal finished : std_logic; -- initialize finish signal to stop clock
	
	signal reset : std_logic; -- inputs
    signal q : std_logic_vector(N downto 0); -- outputs
	
	constant clk_half_period : time := 10 ns;
begin
    -- connecting testbench signals with rand_num_generator.vhd
    UUT : entity work.rand_num_generator port map (clk => clk, reset => reset, q => q);

    clk <= not clk after clk_half_period when finished /= '1' else '0';
    reset <= '1', '0' after 40 ns;
	finished <= '1' after 300 ns;

end tb ;
