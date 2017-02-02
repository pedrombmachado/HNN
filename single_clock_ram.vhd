--! Simple Dual-Port RAM with different read/write addresses but
--! single read/write clock

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity single_clock_ram is

	port 
	(
		clk	: in std_logic;
		raddr	: in std_logic_vector(15 downto 0);
		waddr	: in std_logic_vector(15 downto 0);
		data	: in std_logic_vector(7 downto 0);
		we	: in std_logic := '1';
		q	: out std_logic_vector(7 downto 0)
	);

end single_clock_ram;

architecture rtl of single_clock_ram is

	--! Build a 2-D array type for the RAM
	subtype word_t is std_logic_vector(7 downto 0);
	type memory_t is array(511 downto 0) of word_t;

	--! Declare the RAM signal.	
	signal ram : memory_t;

begin

	process(clk)
	begin
	if(rising_edge(clk)) then 
		if(we = '1') then
			ram(to_integer(unsigned(waddr))) <= data;
		else
			-- nothing happens
		end if;
 
		--! On a read during a write to the same address, the read will
		--! return the OLD data at the address
	end if;
	end process;
	
	process(clk)
	begin
		if(rising_edge(clk)) then
			q <= ram(to_integer(unsigned(raddr)));
		else
			-- nothing happens
		end if;
	end process;

end rtl;
