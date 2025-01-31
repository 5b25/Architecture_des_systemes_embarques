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
port (
    clk         : in  std_logic;
    Rst_n       : in  std_logic;
    echo        : in  std_logic;
    chipselect  : in  std_logic;
    Read_n      : in  std_logic;
    trig        : out std_logic;
    Dist_cm     : out std_logic_vector(9 downto 0);
    readdata    : out std_logic_vector(31 downto 0)
);
end entity;

architecture behav of IP_Telemetre_us is
    type state_type is (IDLE, TRIG_ON, ECHO_WAIT, ECHO_COUNT, CALCULATE, RESET);
    signal current_state, next_state : state_type;

    signal count_time   : integer := 0;             -- 全局时间计数器
    signal count_echo   : integer := 0;             -- 回波计数
    signal count_trig   : integer := 0;             -- 触发信号计数
    signal Read_Dist    : std_logic_vector(9 downto 0) := (others => '0');
	signal echo_r, echo_rr : std_logic;

    constant TRIG_TIME      : integer := 500;       -- le trig va rester au niveau haut durée 500us
    constant MAX_ECHO_COUNT : integer := 600000;   -- Valeur maximale du nombre d'échos（4m）
    constant MEASURE_PERIOD : integer := 3250000;  -- la période pour mesurer la distance（environ 65ms）

begin

    -- Processus principal de la machine d'état
    Dist_cm <= Read_Dist;

    process(clk, Rst_n)
    begin
        if Rst_n = '0' then
            -- Initialiser
            current_state <= IDLE;
            next_state <= IDLE;
            count_time <= 0;
            count_echo <= 0;
            count_trig <= 0;
            trig <= '0';
            Read_Dist <= (others => '0');
        elsif rising_edge(clk) then
            -- Incrément global du compteur de temps
            count_time <= count_time + 1;
            echo_r <= echo;
            echo_rr <= echo_r;

            case next_state is
                when IDLE =>
                    -- Attendre pour l'arrivée de la période de télémétrie
                    next_state <= TRIG_ON;

                when TRIG_ON =>
                    if count_trig < TRIG_TIME then
                        -- On met le trig au niveau haut
                        trig <= '1';
                        count_trig <= count_trig + 1;
                    else
                        trig <= '0';
                        count_time <= 0;
                        count_trig <= 0;
                        next_state <= ECHO_WAIT;
                    end if;

                when ECHO_WAIT =>
                    -- Attendre pour le front montre qui arrive
                    if echo_rr = '1' then
                        count_echo <= 0; -- Si on le détecte, on compte l'echo
                        next_state <= ECHO_COUNT;
                    end if;

                    if count_time > 5e6 THEN 
                        next_state <= IDLE; 
                    end if;

                when ECHO_COUNT =>
                    -- 计数回波信号高电平的持续时间
                    count_echo <= count_echo + 1;
                    if echo_rr = '0' then
                        next_state <= CALCULATE; -- 检测到回波下降沿
                    end if;

                when CALCULATE =>
                    -- 计算距离
                    Read_Dist <= std_logic_vector(to_unsigned(count_echo / 2941, 10));
                    next_state <= RESET;

                when RESET =>
                    -- 准备进入下一次测距
                    count_echo <= 0;
                    count_trig <= 0;
                    trig <= '0';
                    if count_time > 5e6 then 
                        next_state <= IDLE;
                    end if; 

                when others =>
                    next_state <= IDLE;
            end case;

            -- 保存上一个时钟周期的回波信号
            -- echo_samples <= echo_samples(1 downto 0) & echo;
            -- if echo_samples = "111" then
            --     echo_filtered <= '1';
            -- elsif echo_samples = "000" then
            --     echo_filtered <= '0';
            -- end if;
            -- echo_last <= echo_filtered;
        end if;
    end process;

    -- Avalon 接口
    process(chipselect, Read_n)
    begin
        if chipselect = '1' and Read_n = '0' then
            readdata(9 downto 0) <= Read_Dist;
            readdata(31 downto 10) <= (others => '0');
        end if;
    end process;

end architecture;



