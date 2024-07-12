ENTITY n_BitPipo IS
	GENERIC (size : INTEGER := 32);
	PORT(clk, rst, we, sh : IN BIT; din : IN BIT_VECTOR(size-1 DOWNTO 0); dout : OUT BIT_VECTOR(size-1 DOWNTO 0));
END ENTITY;

ARCHITECTURE behavioral OF n_BitPipo IS
	SIGNAL temp : BIT_VECTOR(size-1 DOWNTO 0);
	CONSTANT zero : BIT_VECTOR(size-1 DOWNTO 0) := (OTHERS => '0');
BEGIN
	dout <= temp;
	PROCESS(clk)
	BEGIN
		IF (clk'EVENT AND clk = '1') THEN
			IF (rst = '1') THEN 
				temp <= zero;
			ELSE
				IF (we = '1') THEN
					IF (sh = '0') THEN 
						temp <= din;
					ELSE
						temp <= temp(size-2 DOWNTO 0) & '0';
					END IF;
				END IF;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;