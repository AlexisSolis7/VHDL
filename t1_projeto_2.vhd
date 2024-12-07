library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity transmissor is
    Port ( 
	 -- controle
			  clock : in STD_LOGIC;
           reset : in  STD_LOGIC;
			  
			  palavra : in  STD_LOGIC_VECTOR(7 downto 0);
           send : in  STD_LOGIC := '0';
           
			  busy : out  STD_LOGIC:= '0';
           linha : out  STD_LOGIC:= '1'
	);
end transmissor;

architecture Behavioral of transmissor is
	-- registrador
		signal reg_storage : std_logic_vector(7 downto 0);
	-- contador
		signal contador_enable : STD_LOGIC;
		signal contador_load : STD_LOGIC;
		signal contador_zeros : std_logic_vector(2 downto 0) := "000";
		
	-- MUXs
		signal selected_bit : std_logic;
		
	---- maquina de estados
		type STATES is (S0, S1, S2, S3); -- enum
		-- S0 -> Aguardando
		-- S1 -> Inicializando
		-- S2 -> Transmitindo
		-- S3 -> Finalizando
		signal scurrent, snext: STATES;
begin

-- contador
process(clock, reset)
begin
if (reset = '1') then 
		contador_zeros <= (Others => '0');
elsif (rising_edge(clock)) then
	   if (contador_load = '1') then
			contador_zeros <= (Others => '1');
		elsif (contador_enable = '1') then
			contador_zeros <= contador_zeros - 1;
		end if;
end if;
end process;


-- registrador
process(clock, reset)
begin
   if (reset = '1') then 
		reg_storage <= (Others => '0');
	elsif (rising_edge(clock)) then
	--	if (scurrent != S0) then
			reg_storage <= palavra;
	--	end if;
	end if;
end process;


-- MUX 1
selected_bit <= reg_storage (conv_integer(contador_zeros));

-- saida
linha <= selected_bit when scurrent = S2 else 
			'1' when scurrent = S0 else '0';

--	maquina de estados, 2 process , 1 pra registrar e 1 pra gerar o next state
		
process(clock, reset, send)
begin
	if (reset = '1') then
	snext <= S0;
	end if;
	
	if (scurrent = S0) then
		if (send = '1') then
		snext <= S1;
		busy <= '1';
		else snext <= S0;
		end if;
	end if;
	
	if (scurrent = S1) then
		snext  <= S2;
		contador_load <= '1';
	end if;

	if (scurrent = S2) then
		if (contador_zeros = "000") then
		snext <= S3;
		contador_enable <= '0';
		else 
			contador_enable <= '1';
			contador_load <= '0';
		end if;
	end if;
	
	if (scurrent = S3) then
		snext <= S0;
		busy <= '0';
	end if;

	
end process;

process(clock, reset)
begin
	scurrent <= snext;
end process;

end Behavioral; -- Fim da arquitetura
