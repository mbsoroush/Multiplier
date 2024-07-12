ENTITY data_path IS
	PORT (clk, rst, regs_we, regs_sh, mult_we : IN BIT; a, b : IN BIT_VECTOR(15 DOWNTO 0); mult : OUT BIT_VECTOR(31 DOWNTO 0));
END ENTITY;

ARCHITECTURE struct OF data_path IS
	COMPONENT adder IS
		GENERIC (size : INTEGER:= 32);
		PORT(a, b : IN BIT_VECTOR(size-1 DOWNTO 0); cin : IN BIT;
			    s : OUT BIT_VECTOR(size-1 DOWNTO 0); cout : OUT BIT);
	END COMPONENT;
	FOR ALL : adder USE ENTITY WORK.n_bit_adder(struct);

	COMPONENT reg IS
		GENERIC (size : INTEGER := 32);
		PORT(clk, rst, we : IN BIT; din : IN BIT_VECTOR(size-1 DOWNTO 0); dout : OUT BIT_VECTOR(size-1 DOWNTO 0));
	END COMPONENT;
	FOR ALL : reg USE ENTITY WORK.n_BitRegSynch(behavioral);

	COMPONENT PIPO IS
		GENERIC (size : INTEGER := 32);
		PORT(clk, rst, we, sh : IN BIT; din : IN BIT_VECTOR(size-1 DOWNTO 0); dout : OUT BIT_VECTOR(size-1 DOWNTO 0));
	END COMPONENT;
	FOR ALL : PIPO USE ENTITY WORK.n_BitPipo(behavioral);

	COMPONENT PISO IS
		GENERIC (size : INTEGER := 32);
		PORT(clk, rst, we, sh : IN BIT; din : IN BIT_VECTOR(size-1 DOWNTO 0); x, y : OUT BIT);
	END COMPONENT;
	FOR ALL : PISO USE ENTITY WORK.n_BitPiso(behavioral);
	
	SIGNAL adder_ina, adder_inb, adder_out, and_out, PIPO_in,PIPO_out : BIT_VECTOR(31 DOWNTO 0);
	SIGNAL PISO_in : BIT_VECTOR(16 DOWNTO 0);
	SIGNAL x, y, xor_out : BIT;
	
	
BEGIN
	mult <= adder_ina;
	my_adder : adder GENERIC MAP(32) PORT MAP(adder_ina, adder_inb, x, adder_out, OPEN);
	adder_inb <= NOT and_out WHEN (x = '1') ELSE and_out;
	xor_out <= x XOR y;
	PISO_in <= b & '0';
	my_PISO : PISO GENERIC MAP(17) PORT MAP(clk, rst, regs_we, regs_sh, PISO_in, x, y);
	my_reg : reg GENERIC MAP(32) PORT MAP(clk, rst, mult_we, adder_out,  adder_ina);
	my_PIPO : PIPO GENERIC MAP(32) PORT MAP(clk, rst, regs_we, regs_sh, PIPO_in, PIPO_out);
	PIPO_in <= a(15) & a(15) & a(15) & a(15) & a(15) & a(15) & a(15) & a(15) & a(15) & 
	a(15) & a(15) & a(15) & a(15) & a(15) & a(15) & a(15) & a;
	g0 : FOR i IN 0 TO 31 GENERATE
		and_out(i) <= PIPO_out(i) AND xor_out;
	END GENERATE;
	

END ARCHITECTURE;