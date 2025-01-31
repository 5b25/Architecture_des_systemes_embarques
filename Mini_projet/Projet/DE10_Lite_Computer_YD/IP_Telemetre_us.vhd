library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- L'horloge de DE10-LITE est Pclk = 20 ns = 0.002us；Fclk= 50 MHz
-- 1 us = 1000 ns = 50 fois
-- Et donc, 10 us = 10,000 ns = 500 fois
-- 			60 us = 60,000 ns = 3,000 fois
-- Après qu'on envoie le trig, on attend 106 ns
-- On attent au mois 10 ms = 10,000 us = 500,000 fois

entity IP_Telemetre_us is
port
(
	clk     : in std_logic;
	Rst_n   : in std_logic;
	echo    : in std_logic;
	chipselect : in std_logic;
	Read_n : in std_logic;
	trig    : out std_logic;
	Dist_cm : out std_logic_vector(9 downto 0);
	readdata : out std_logic_vector(31 downto 0)
);
end entity;

architecture behav of IP_Telemetre_us is
    signal count_time : integer := 0;
    signal count_echo : integer := 0;
    signal count_trig : integer := 0;
    signal echo_last : std_logic := '0';
	signal Read_Dist : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
begin
	process(clk, Rst_n)
	begin
		if Rst_n = '0' then
			count_time <= 0;
			count_echo <= 0;
			count_trig <= 0;
			echo_last <= '0';
			trig <= '0';
			Read_Dist <= "0000000000";
		elsif Rising_Edge(clk) then
			if count_trig < 500 then
				trig <= '1';
				count_trig <= count_trig + 1;
			elsif  count_trig = 500 then
				trig <= '0';
			end if;

            -- Détection de bord de signal d'écho
            if echo = '1' and echo_last = '0' then
                count_echo <= 0; -- Un front montant est détecté et le comptage est initialisé.
            elsif echo = '1' then
                count_echo <= count_echo + 1; -- Compter à un niveau élevé
            end if;
            echo_last <= echo; -- Enregistrer l'état d'écho du moment précédent

            -- Calculer la distance
            if echo = '0' and echo_last = '1' then
                Read_Dist <= std_logic_vector(to_unsigned(count_echo / 2941, 10));
            end if;

			Dist_cm <= Read_Dist;
			count_time <= count_time + 1;
			
			-- 每 65 ms重置一次 count_trig
				-- 65 ms × 50 MHz = 3,250,000
			if count_time mod 3250000 = 0 then
				count_trig <= 0;
			end if;

			if chipselect = '1' and Read_n = '0' then
				readdata(9 downto 0) <= Read_Dist;
				readdata(31 downto 10) <= (others => '0'); -- 填充其余位
			end if;

		end if;
	end process;
end architecture;
	 