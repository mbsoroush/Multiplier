ENTITY full_adder IS
	PORT(a, b, cin : IN BIT; s, cout : OUT BIT);
END ENTITY;

ARCHITECTURE struct OF full_adder IS
--	SIGNAL t1, t2, t3 : BIT;
BEGIN
	s <= a  XOR b XOR cin;
	cout <= (a AND b) OR (a AND cin) OR (b AND cin);
----	s <= a  XOR b XOR cin AFTER 5 NS;
----	cout <= (a AND b) OR (a AND cin) OR (b AND cin) AFTER 3 NS;
--	cout <= t1 OR t2 OR t3 AFTER 1 NS;
--	t1 <= a AND b AFTER 2 NS;
--	t2 <= a AND cin AFTER 2 NS;
--	t3 <= b AND cin AFTER 2 NS;
END ARCHITECTURE;