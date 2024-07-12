ENTITY counter IS
	PORT(clk, rst, en : IN BIT; count : OUT BIT_VECTOR(3 DOWNTO 0));
END ENTITY;

ARCHITECTURE mix OF counter IS
	COMPONENT four_bit_adder IS
		PORT(a, b : IN BIT_VECTOR(3 DOWNTO 0); cin : IN BIT;
			    s : OUT BIT_VECTOR(3 DOWNTO 0); cout : OUT BIT);
	END COMPONENT;
	FOR ALL : four_bit_adder USE ENTITY WORK.four_bit_adder(struct);

	COMPONENT FourBitRegSynch IS
		PORT(clk, rst, we : IN BIT; din : IN BIT_VECTOR(3 DOWNTO 0); dout : OUT BIT_VECTOR(3 DOWNTO 0));
	END COMPONENT;
	FOR ALL : FourBitRegSynch USE ENTITY WORK.FourBitRegSynch(behavioral);

	SIGNAL adder_out, reg_out : BIT_VECTOR(3 DOWNTO 0);
BEGIN
	adder : four_bit_adder PORT MAP(reg_out, X"1", '0', adder_out, OPEN);
	reg : FourBitRegSynch PORT MAP(clk, rst, en, adder_out, reg_out);
	count <= reg_out;
END ARCHITECTURE;