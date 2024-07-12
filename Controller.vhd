ENTITY controller IS
	PORT(clk, reset, start, count_done : IN BIT; rst, regs_we, regs_sh, ready, count_rst, mult_we : OUT BIT);
END ENTITY;

ARCHITECTURE behavioral OF controller IS
	TYPE state IS (rst_start, init, multipling, finished);
	SIGNAL current_state, next_state : state;
BEGIN
	PROCESS(clk)
	BEGIN
		IF (clk'EVENT AND clk = '1') THEN
			IF (reset = '1') THEN
				current_state <= rst_start;
			ELSE
				current_state <= next_state;
			END IF;
		END IF;
	END PROCESS;
	
	PROCESS(current_state , start, count_done)
	BEGIN
		CASE current_state IS
			WHEN rst_start =>
				IF (start = '1') THEN
					next_state <= init;
				ELSE
					next_state <= rst_start;
				END IF;
				
			WHEN init =>
				IF (start = '1') THEN
					next_state <= init;
				ELSE
					next_state <= multipling;
				END IF;
				
			WHEN multipling =>
				IF (count_done = '1') THEN
					next_state <= finished;
				ELSE
					next_state <= multipling;
				END IF;
				
			WHEN finished =>
				IF (start = '1') THEN
					next_state <= rst_start;
				ELSE
					next_state <= finished;
				END IF;
				
			WHEN OTHERS =>
				next_state <= rst_start;
		END CASE;
	END PROCESS;
	rst <= '1' WHEN (current_state = rst_start) ELSE '0';
	regs_we <= '1' WHEN (current_state = init) OR (current_state = multipling) ELSE '0';
	regs_sh <= '1' WHEN (current_state = multipling) ELSE '0';
	ready <= '1' WHEN (current_state = finished) ELSE '0';
	count_rst <= '1' WHEN (current_state = init) ELSE '0';
	mult_we <= '1' WHEN (current_state = multipling) ELSE '0';
	
	
	
	
	
	
	
	
	
	
END ARCHITECTURE;