ENTITY test_multiplier IS 
END ENTITY;

ARCHITECTURE test OF test_multiplier IS

	COMPONENT multiplier IS
		PORT (clk, start, reset : IN BIT; a, b : IN BIT_VECTOR(15 DOWNTO 0); mult : OUT BIT_VECTOR(31 DOWNTO 0); ready : OUT BIT);
	END COMPONENT;
	FOR ALL : multiplier USE ENTITY WORK.multiplier(mix);

	SIGNAL a, b : BIT_VECTOR(15 DOWNTO 0);
	SIGNAL mult : BIT_VECTOR(31 DOWNTO 0);
	SIGNAL clk, start, reset, ready : BIT;
BEGIN
	my_mult : multiplier PORT MAP (clk, start, reset ,a, b , mult,  ready);
	clk <= NOT clk AFTER 5 NS;
	reset <= '1', '0' AFTER 10 NS;
	a <= X"DEFC";
	b <= X"7FE9";
	start <= '0', '1' AFTER 10 NS, '0' AFTER 20 Ns;

END ARCHITECTURE;