ENTITY four_bit_adder IS
	PORT(a, b : IN BIT_VECTOR(3 DOWNTO 0); cin : IN BIT;
		    s : OUT BIT_VECTOR(3 DOWNTO 0); cout : OUT BIT);
END ENTITY;
ARCHITECTURE struct OF four_bit_adder IS
	COMPONENT fa IS
		PORT(a, b, cin : IN BIT; s, cout : OUT BIT);
	END COMPONENT;
	FOR ALL : fa USE ENTITY WORK.full_adder (struct);
--	SIGNAL t0, t1, t2 : BIT;
	SIGNAL t : BIT_VECTOR(2 DOWNTO 0);	
BEGIN
	fa0 : fa PORT MAP(a => a(0) ,b => b(0), cin => cin,s => s(0), cout => t(0));
	fa1 : fa PORT MAP(a => a(1) ,b => b(1), cin => t(0) , s => s(1), cout => t(1));
	fa2 : fa PORT MAP(a => a(2) ,b => b(2), cin => t(1) , s => s(2), cout => t(2));
	fa3 : fa PORT MAP(a => a(3) ,b => b(3), cin => t(2) , s => s(3), cout => cout);
--	fa0 : fa PORT MAP(a => a(0) ,b => b(0), cin => cin,s => s(0), cout => t0);
--	fa1 : fa PORT MAP(a => a(1) ,b => b(1), cin => t0 , s => s(1), cout => t1);
--	fa2 : fa PORT MAP(a => a(2) ,b => b(2), cin => t1 , s => s(2), cout => t2);
--	fa3 : fa PORT MAP(a => a(3) ,b => b(3), cin => t2 , s => s(3), cout => cout);

END ARCHITECTURE;