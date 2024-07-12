ENTITY n_BitRegSynch IS
	GENERIC (size : INTEGER := 32);
	PORT(clk, rst, we : IN BIT; din : IN BIT_VECTOR(size-1 DOWNTO 0); dout : OUT BIT_VECTOR(size-1 DOWNTO 0));
END ENTITY;

ARCHITECTURE behavioral OF n_BitRegSynch IS
	CONSTANT zero : BIT_VECTOR(size-1 DOWNTO 0) := (OTHERS => '0');
BEGIN
	PROCESS(clk)
	BEGIN
		IF (clk'EVENT AND clk = '1') THEN
			IF (rst = '1') THEN 
				dout <= zero;
			ELSE
				IF (we = '1') THEN
					dout <= din;
				END IF;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;