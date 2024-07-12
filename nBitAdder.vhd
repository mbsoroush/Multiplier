ENTITY n_bit_adder IS
	GENERIC (size : INTEGER:= 32);
	PORT(a, b : IN BIT_VECTOR(size-1 DOWNTO 0); cin : IN BIT;
		    s : OUT BIT_VECTOR(size-1 DOWNTO 0); cout : OUT BIT);
END ENTITY;
ARCHITECTURE struct OF n_bit_adder IS
	COMPONENT full_adder IS
		PORT(a, b, cin : IN BIT; s, cout : OUT BIT);
	END COMPONENT;
	FOR ALL : full_adder USE ENTITY WORK.full_adder(struct);
	SIGNAL t : BIT_VECTOR(size DOWNTO 0);	
BEGIN
	g0 : FOR i IN 0 TO size-1 GENERATE
		fas : full_adder PORT MAP(a => a(i) ,b => b(i), cin => t(i),s => s(i), cout => t(i+1));
	END GENERATE;
	t(0) <= cin;
	cout <= t(size);
END ARCHITECTURE;