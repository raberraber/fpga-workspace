LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY clock IS
port(
	output_segments: out std_logic_vector(0 to 6);
	led_out: out std_logic;
	clk: in std_logic
);
END clock;




ARCHITECTURE counter_implementation of clock is


COMPONENT segment IS
		PORT (
	inputs: in std_logic_vector(3 downto 0);
	output_segments: out std_logic_vector(0 to 6);
	output_led: out std_logic_vector(3 downto 0);
	segment_enable: in std_logic

     );
	END COMPONENT;

	signal status_leds: STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal turn_on_segment: STD_LOGIC:= '1';
	signal counter: std_logic_vector(3 DOWNTO 0);
	signal sig_led_out: std_logic := '0';

begin


outputSegment: segment PORT MAP (inputs => counter, output_led => status_leds, segment_enable => turn_on_segment, output_segments => output_segments);
led_out<=sig_led_out;


process(clk)

variable var_counter: integer range 0 to 11;
variable var_clk: integer range 0 to 50000001;
 
begin

	if rising_edge(clk) then 
		var_clk:= var_clk +1;


		if (var_clk = 25) then
			sig_led_out<= not sig_led_out;
			
		end if;

		if (var_clk = 50) then 
			var_counter:=var_counter+1;
			sig_led_out<= not sig_led_out;
			if (var_counter=11) then
				var_counter:=0;
			end if;
			var_clk := 0;		
		end if;

	end if;
	
	counter<= std_logic_vector(to_unsigned(var_counter, counter'length));
end process;


end counter_implementation;