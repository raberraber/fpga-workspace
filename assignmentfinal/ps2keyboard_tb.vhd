LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
-- The entity of your testbench. No ports declaration in this case.
ENTITY ps2keyboard_tb IS
END ENTITY;



ARCHITECTURE testbench OF ps2keyboard_tb IS
 -- The component declaration should match your entity.
-- It is very important that the name of the component and the ports
-- (remember direction of ports!) match your entity! Please notice that
-- the code below probably does not work for your design without
-- modifications.
 COMPONENT ps2keyboard IS
 PORT (
	clk: in std_logic;
	clk_keyb: in std_logic;
	ps2_data: in std_logic;
	output_to_segment: out std_logic_vector(0 to 6);
	error_led: out std_logic; --debugging
	idle_led: out std_logic --debugging
);

 END COMPONENT;


 -- Signal declaration. These signals are used to drive your inputs and
 -- store results (if required).
	signal clk_tb: std_logic;
	signal clk_keyb_tb: std_logic;
	signal ps2_data_tb: std_logic;
	signal output_to_segment_tb: std_logic_vector(0 to 6);
	signal error_led_tb: std_logic; --debugging
	signal idle_led_tb: std_logic; --debugging

	signal data_0_correct: std_logic_vector(10 downto 0); 
	signal data_1_correct: std_logic_vector(10 downto 0); 
	signal data_2_error: std_logic_vector(10 downto 0);
 BEGIN
 -- A port map is in this case nothing more than a construction to
-- connect your entity ports with your signals.
tb: ps2keyboard PORT MAP (clk => clk_tb, clk_keyb => clk_keyb_tb, ps2_data => ps2_data_tb, output_to_segment => output_to_segment_tb, error_led => error_led_tb, idle_led => idle_led_tb);


PROCESS
BEGIN
 -- Initialize signals.
	data_0_correct<= "00100010111";
	data_1_correct<= "00001011011";
	data_2_error<= "00001111000";
	idle_led_tb <= '1';
 -- Loop through values.





	
 FOR I IN 0 TO 512 LOOP

   
 WAIT FOR 10 ns;
 -- Increment by one.
 	if(clk_tb = '0') THEN
			clk_tb <= '1';
		ELSE
			clk_tb <= '0';
	END IF;

	if(clk_keyb_tb = '0') THEN
			ps2_data_tb<= data_0_correct(i);
			--var_counter := var_counter + 1;

		
			clk_keyb_tb <= '1';
		ELSE
			clk_keyb_tb <= '0';
	END IF;

	
 END LOOP;

 REPORT "Test completed.";
 -- Wait forever.
 WAIT;
END PROCESS;
END ARCHITECTURE; 




