ENTITY multiplier IS
	PORT (clk, start, reset : IN BIT; a, b : IN BIT_VECTOR(15 DOWNTO 0); mult : OUT BIT_VECTOR(31 DOWNTO 0); ready : OUT BIT);
END ENTITY;

ARCHITECTURE mix OF multiplier IS
	COMPONENT counter IS
		PORT(clk, rst, en : IN BIT; count : OUT BIT_VECTOR(3 DOWNTO 0));
	END COMPONENT;
	FOR ALL : counter USE ENTITY WORK.counter(mix);

	COMPONENT data_path IS
		PORT (clk, rst, regs_we, regs_sh, mult_we : IN BIT; a, b : IN BIT_VECTOR(15 DOWNTO 0); mult : OUT BIT_VECTOR(31 DOWNTO 0));
	END COMPONENT;
	FOR ALL : data_path USE ENTITY WORK.data_path(struct);

	COMPONENT controller IS
		PORT(clk, reset, start, count_done : IN BIT; rst, regs_we, regs_sh, ready, count_rst, mult_we : OUT BIT);
	END COMPONENT;
	FOR ALL : controller USE ENTITY WORK.controller(behavioral);

	SIGNAL count_out : BIT_VECTOR(3 DOWNTO 0);
	SIGNAL rst, count_done, regs_we, regs_sh, count_rst, mult_we : BIT;
BEGIN
	my_counter : counter PORT MAP(clk, count_rst, '1', count_out);
	count_done <= '1' WHEN (count_out = X"F") ELSE '0';
	dp : data_path PORT MAP (clk, rst, regs_we, regs_sh,mult_we, a, b, mult);
	ctrl : controller PORT MAP(clk, reset, start, count_done, rst, regs_we, regs_sh, ready, count_rst, mult_we);

END ARCHITECTURE;