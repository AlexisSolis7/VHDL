library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity top_cron_basq is
generic ( MAXCOUNT : integer := 50_000_000 );
port ( 
clock: in STD_LOGIC;

--- 4 botões push-buttons -
reset: in STD_LOGIC;
carga: in STD_LOGIC;
para_continua: in STD_LOGIC;
novo_quarto: in STD_LOGIC;

--- valores de carga - 8 dip-switches -
c_quarto: in STD_LOGIC_VECTOR (1 downto 0);
c_minutos: in STD_LOGIC_VECTOR (3 downto 0);
c_segundos: in STD_LOGIC_VECTOR (5 downto 0);
quarto: in std_logic_vector(1 downto 0);
minutos: in std_logic_vector(3 downto 0);
segundos: in std_logic_vector(5 downto 0);
centesimos: std_logic_vector(6 downto 0);  

-- interface para os 8 displays de 7 segmentos
dec_ddp: out STD_LOGIC_VECTOR (7 downto 0);
an: out STD_LOGIC_VECTOR (3 downto 0) -- anodo
);
end top_cron_basq;

architecture Behavioral of top_cron_basq is
	signal enable_cent: std_logic;
	signal enable_segundo: std_logic;
	signal enable_minuto: std_logic;
	signal enable_quarto: std_logic;
	
	signal contador_clk  : std_logic_vector(7 downto 0);
	signal contador_seg  : std_logic_vector(7 downto 0);
	signal contador_min  : std_logic_vector(6 downto 0);
	signal contador_quarto  : std_logic_vector(6 downto 0);
	signal contador_centesimo  : std_logic_vector(6 downto 0);
	
	signal para_continua_int : std_logic;
	signal novo_quarto_int : std_logic;
	signal carga_int : std_logic;

	signal Centesimos_BCD: std_logic_vector(7 downto 0);
	signal Segundos_BCD: std_logic_vector(7 downto 0);
	signal Minutos_BCD: std_logic_vector(7 downto 0);
	signal Quarto_BCD: std_logic_vector(7 downto 0);
	
	

	signal d4_internal : std_logic_vector(5 downto 0);
   signal d3_internal : std_logic_vector(5 downto 0);
   signal d2_internal : std_logic_vector(5 downto 0);
   signal d1_internal : std_logic_vector(5 downto 0);
   signal an_internal : std_logic_vector(3 downto 0);
   signal dec_ddp_internal : std_logic_vector(7 downto 0);

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

type states is (REP, LOAD, COUNT, STOP);
signal current_state, next_state : states;

begin

-- máquina de estados
process(clock, reset)
begin
	if (reset='1') then
		current_state <= REP;
	elsif (clock'event and clock = '1') then
		current_state <= next_state;
	end if;
end process;

process(clock, reset)
begin
	if (carga = '1' and current_state = REP) then
		next_state <= LOAD;
	elsif (para_continua = '1') then
		next_state <= COUNT;
	elsif (current_state = COUNT) then
		if (contador_seg = 0 and contador_min = 0 and contador_centesimo = 0) then
			next_state <= STOP;
		else next_state <= COUNT;
		end if;
	end if;
end process;

-- contador de clocks
process (reset, clock)
begin
		if reset='1' then
			contador_clk <= (Others => '0');
		elsif (clock'event and clock='1') then
			count_25K <= count_25K + 1;
			if (count_25K =  MAXCOUNT - 1) then
				count_25K <= 0;
				if (current_state = COUNT) then
					enable_cent <= '1';
				else 
					enable_cent <= '0';
				end if;
			end if;
		end if;
end process;

-- contador de centesimos
process(clock, reset)
begin
	if (reset = '1') then
		contador_centesimo <= (Others =>'0');
	elsif (clock'event and clock = '1') then
		if (current_state = LOAD) then
			contador_centesimo <= (Others =>'0');
		end if;
		if (current_state = COUNT) then
			if (contador_centesimo > 0) then
				contador_centesimo <= contador_centesimo - '1';
				enable_segundo <= '0';
			else 		
				enable_segundo <= '1';
				contador_centesimo <= "1100011";
			end if;
		end if;
	end if;
end process;

-- contador de segundos
process(clock, reset)
begin
	if (reset = '1') then
		contador_seg <= (Others =>'0');
	elsif (clock'event and clock = '1') then
		if (current_state = LOAD) then
			contador_seg <= "00" & c_segundos;
		end if;
		if (current_state = COUNT) then
			enable_minuto <= '0';
			if (contador_seg > 0 and enable_segundo = '1') then
				contador_seg <= contador_seg - '1';
			elsif (enable_segundo = '1') then
				contador_seg <= "00111011";
				enable_minuto <= '1';
			end if;
		end if;
	end if;
end process;

-- contador de minutos
process(clock, reset)
begin
	if (reset = '1') then
		contador_min <= "0001111";
	elsif (clock'event and clock = '1') then
		if (current_state = LOAD) then
			contador_min <= "000" & c_minutos;
		end if;
		if (current_state = COUNT and enable_minuto = '1') then
			if (contador_min > 0) then
				contador_min <= contador_min - '1';
				enable_quarto <= '0';
			end if;
		end if;
	end if;
end process;

-- contador de quartos
process(clock, reset)
begin
	if (reset = '1') then
		contador_quarto <= (Others =>'0');
	elsif (clock'event and clock = '1') then
		if (current_state = LOAD) then
			contador_quarto <= "00000" & c_quarto;
		elsif (enable_quarto = '1' and current_state = COUNT) then
				-- toDo: parar em 4
			contador_quarto <= contador_quarto + 1;
		elsif (current_state = STOP and novo_quarto = '1' and contador_quarto < "100") then
			contador_quarto <= contador_quarto + 1;
		end if;
	end if;
end process;

-- instanciação das ROMs
Segundos_BCD <= conv_to_BCD(conv_integer(contador_seg));
Minutos_BCD <= conv_to_BCD(conv_integer(contador_min));
Centesimos_BCD <= conv_to_BCD(conv_integer(contador_centesimo));
Quarto_BCD <= conv_to_BCD(conv_integer(contador_quarto));

-- display driver
d1_internal <= '1' & Segundos_BCD(3 downto 0) & '1';
d2_internal <= '1' & Segundos_BCD(7 downto 4) & '1';
d3_internal <= '1' & Minutos_BCD(3 downto 0) & '1';
d4_internal <= '1' & Minutos_BCD(7 downto 4) & '1';

display_driver : entity work.dspl_drv port map (
	  clock => clock,
	  reset => reset,
		d4 => d4_internal,
		d3 => d3_internal,
		d2 => d2_internal,
		d1 => d1_internal,
		an => an_internal,
		dec_ddp => dec_ddp_internal
);

-- debouncer
 para_continua_int_inst: entity work.Debounce port map(
    clock    => clock,
    reset    => reset,
    key      => para_continua,
    debkey   => para_continua_int
  );
 novo_quarto_int_inst: entity work.Debounce port map(
	 clock    => clock,
    reset    => reset,
    key      => novo_quarto,
    debkey   => novo_quarto_int
  );
 carga_int_inst: entity work.Debounce port map(
	 clock    => clock,
    reset    => reset,
    key      => carga,
    debkey   => carga_int
  );

end Behavioral;
