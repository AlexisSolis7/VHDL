library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity cron_dec is
generic ( CLOCK_FREQ : integer := 25_000_000 );
port (
	clock: in std_logic;
	carga: in std_logic := '0';
	reset: in std_logic := '0';
	conta: in std_logic := '0';
	chaves: in std_logic_vector(6 downto 0);
	signal an: std_logic := '0';
	signal dec_ddp: std_logic := '0'
);
end cron_dec;

architecture Behavioral of cron_dec is
	signal clock_1seg: std_logic;

	signal contador_seg  : std_logic_vector(7 downto 0) := "00000000";
	signal Segundos_BCD: std_logic_vector(7 downto 0);

	signal contador_min  : std_logic_vector(6 downto 0) := "0000000";
	signal Minutos_BCD: std_logic_vector(7 downto 0);

	signal d1: std_logic_vector(5 downto 0);
	signal d2: std_logic_vector(5 downto 0);
	signal d3: std_logic_vector(5 downto 0);
	signal d4: std_logic_vector(5 downto 0);

	signal count_25K: integer range 0 to 25000000;

	type ROM is array (0 to 99) of std_logic_vector (7 downto 0);
constant conv_to_BCD : ROM:=(
"00000000", "00000001", "00000010", "00000011", "00000100",
"00000101", "00000110", "00000111", "00001000", "00001001",
"00010000", "00010001", "00010010", "00010011", "00010100",
"00010101", "00010110", "00010111", "00011000", "00011001",
"00100000", "00100001", "00100010", "00100011", "00100100",
"00100101", "00100110", "00100111", "00101000", "00101001",
"00110000", "00110001", "00110010", "00110011", "00110100",
"00110101", "00110110", "00110111", "00111000", "00111001",
"01000000", "01000001", "01000010", "01000011", "01000100",
"01000101", "01000110", "01000111", "01001000", "01001001",
"01010000", "01010001", "01010010", "01010011", "01010100",
"01010101", "01010110", "01010111", "01011000", "01011001",
"01100000", "01100001", "01100010", "01100011", "01100100",
"01100101", "01100110", "01100111", "01101000", "01101001",
"01110000", "01110001", "01110010", "01110011", "01110100",
"01110101", "01110110", "01110111", "01111000", "01111001",
"10000000", "10000001", "10000010", "10000011", "10000100",
"10000101", "10000110", "10000111", "10001000", "10001001",
"10010000", "10010001", "10010010", "10010011", "10010100",
"10010101", "10010110", "10010111", "10011000", "10011001");
type states is (REP, LOAD, COUNT);
signal current_state, next_state : states;

begin

-- P1: divisor de clock para gerar o ck1seg
process (reset, clock)
begin
		if reset='1' then
			count_25K <= 0;
			clock_1seg <= '0';
		elsif (clock'event and clock='1') then
			count_25K <= count_25K + 1;
			if (count_25K =  CLOCK_FREQ - 1) then
				count_25K <= 0;
				clock_1seg <= not clock_1seg;
			end if;
		end if;
end process;

-- máquina de estados
process(clock_1seg, reset)
begin
	current_state <= next_state;
end process;

process(clock_1seg, reset)
begin
	if (carga = '1' and current_state = REP) then
		next_state <= LOAD;
	elsif (current_state = LOAD) then
		next_state <= COUNT;
		-- contador_seg <= 60;
	elsif (current_state = COUNT) then
	end if;
end process;

-- contador de segundos
process(clock_1seg, reset)
begin
	if (current_state = LOAD) then
		contador_seg <= "00111011"; -- 59;
	end if;
	if (current_state = COUNT) then
		if (contador_seg > 0) then
			contador_seg <= contador_seg - '1';
		else contador_seg <= "00111011";
		end if;
	end if;
end process;

-- contador de minutos
process(clock_1seg, reset)
begin
	if (current_state = LOAD) then
		contador_min <= chaves;
	end if;
	if (current_state = COUNT and contador_seg = 0) then
		contador_min <= contador_min - '1';
	end if;
end process;

-- instanciação das ROMs
Segundos_BCD <= conv_to_BCD(conv_integer(contador_seg));
Minutos_BCD <= conv_to_BCD(conv_integer(contador_min));

-- display driver
d1 <= '1' & Segundos_BCD(3 downto 0) & '1';
-- d2 <= ...
-- d3 <= ...
-- d4 <= ...
-- ...
display_driver : entity work.dspl_drv port map (
	  clock => clock_1seg,
	  reset => reset,
		d4 => d4,
		d3 => d3,
		d2 => d2,
		d1 => d1
);
end Behavioral;