ENTITY FourBitRegSynch IS
	PORT(clk, rst, we : IN BIT; din : IN BIT_VECTOR(3 DOWNTO 0); dout : OUT BIT_VECTOR(3 DOWNTO 0));
END ENTITY;

ARCHITECTURE behavioral OF FourBitRegSynch IS

BEGIN
	PROCESS(clk)
	BEGIN
		IF (clk'EVENT AND clk = '1') THEN
			IF (rst = '1') THEN 
				dout <= X"0";
			ELSE
				IF (we = '1') THEN
					dout <= din;
				END IF;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;