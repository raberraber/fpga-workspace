LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


ENTITY calculations IS
PORT(

	inputs_first: in std_logic_vector(3 downto 0);
	segment_first: out std_logic_vector(0 to 6);
	status_leds_first: out std_logic_vector(3 downto 0);

	inputs_second: in std_logic_vector(3 downto 0);
	segment_second: out std_logic_vector(0 to 6);
	status_leds_second: out std_logic_vector(3 downto 0);
	
  	output_segment_left:	OUT std_logic_vector(0 to 6);
  	output_segment_right:	OUT std_logic_vector(0 to 6);

  	calc_button:	IN std_logic
);
END calculations;

ARCHITECTURE implementation OF calculations IS

	COMPONENT segment IS
		PORT (
	inputs: in std_logic_vector(3 downto 0);
	output_segments: out std_logic_vector(0 to 6);
	output_led: out std_logic_vector(3 downto 0);
	segment_enable: in std_logic
	
     );
	END COMPONENT;



	signal result_left: std_logic_vector(3 downto 0);
	signal result_right: std_logic_vector(3  downto 0);
	signal status_leds_not_using: std_logic_vector(3 downto 0);
	signal segment_on: std_logic := '1';
	signal left_segment_on: std_logic  := '1';
	 

BEGIN
	
	inputSegment1: segment PORT MAP (inputs => inputs_first, output_led => status_leds_first, segment_enable => segment_on, output_segments => segment_first);  
	inputSegment2: segment PORT MAP (inputs => inputs_second, output_led => status_leds_second,segment_enable => segment_on , output_segments => segment_second);  
	
	result_segment_left: segment PORT MAP (inputs => result_left, output_led=> status_leds_not_using, segment_enable => left_segment_on, output_segments => output_segment_left );
	result_segment_right: segment PORT MAP (inputs => result_right, output_led=> status_leds_not_using, segment_enable => segment_on, output_segments => output_segment_right );

	
	
	
	
	process(calc_button)
	variable var_total_result: unsigned(7 downto 0);
	variable var_left_result: std_logic_vector(3 downto 0);
	begin
		if rising_edge(calc_button) then
			var_total_result := unsigned("0000" & inputs_first) + unsigned("0000" & inputs_second);
			result_right <= std_logic_vector (var_total_result(3 downto 0));
			var_left_result := std_logic_vector(var_total_result(7 downto 4));
				
				if var_left_result = "0000" then
				left_segment_on <= '0';
			else
				left_segment_on <= '1';
			end if;
			
		end if;
		result_left<=var_left_result;
	end process;

END implementation;
