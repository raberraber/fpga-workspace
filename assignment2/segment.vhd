LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY segment IS
port(
	inputs: in std_logic_vector(3 downto 0);
	output_segments: out std_logic_vector(0 to 6);
	output_led: out std_logic_vector(3 downto 0)
);
END segment;


ARCHITECTURE segment_implementation of segment is
begin
	output_led(0) <= inputs(0);
	output_led(1) <= inputs(1);
	output_led(2) <= inputs(2);
	output_led(3) <= inputs(3);
	with inputs select
		output_segments <= not("0111111") when "0000", --0
				not("0000110") when "0001", --1
				not ("1011011") when "0010", --2
				not ("1001111") when "0011", --3
				not ("1100110") when "0100", --4
				not ("1101101") when "0101", --5
				not ("1111101") when "0110", --6
				not ("0000111") when "0111", --7
				not ("1111111") when "1000", --8
				not ("1101111") when "1001", --9
				not ("1110111") when "1010", --A
				not ("1111100") when "1011", --B
				not ("0111001") when "1100", --C
				not ("1011110") when "1101", --D
				not ("1111001") when "1110", --E
				not ("1110001") when "1111", --F		
				not ("1111111") when others;
end segment_implementation;