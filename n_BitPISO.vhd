ENTITY n_BitPiso IS
	GENERIC (size : INTEGER := 32);
	PORT(clk, rst, we, sh : IN BIT; din : IN BIT_VECTOR(size-1 DOWNTO 0); x, y : OUT BIT);
END ENTITY;

ARCHITECTURE behavioral OF n_BitPiso IS
	SIGNAL temp : BIT_VECTOR(size-1 DOWNTO 0);
	CONSTANT zero : BIT_VECTOR(size-1 DOWNTO 0) := (OTHERS => '0');
BEGIN
	x <= temp(1);
	y <= temp(0);
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
						temp <= temp(size-1) & temp(size-1 DOWNTO 1);
					END IF;
				END IF;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;