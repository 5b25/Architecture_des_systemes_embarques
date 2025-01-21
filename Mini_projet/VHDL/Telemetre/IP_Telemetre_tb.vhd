library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;

entity IP_Telemetre_tb is
	
end entity;

architecture Bench of IP_Telemetre_tb is
signal clk : Std_logic;
signal Rst_n : Std_logic;
signal echo : std_logic := '0';
signal trig : std_logic := '0'; -- 初始化为低电平
signal chipselect : std_logic;
signal Read_n : std_logic;
signal Dist_cm : std_logic_vector(9 downto 0);
signal readdata : std_logic_vector(31 downto 0);

begin
    G1: entity work.IP_Telemetre_us port map (
        clk => clk, 
        Rst_n => Rst_n, 
        echo => echo, 
        chipselect => chipselect,
        Read_n => Read_n,
        trig => trig,
        Dist_cm => Dist_cm, 
        readdata => readdata
        );

    Clock: process
    begin
        while now <= 300 ms loop
            clk <= '0';
            wait for 10 NS;
            clk <= '1';
            wait for 10 NS;
        end loop;
        wait;
    end process;
    
    Rst_n <= '0', '1' after 10 NS;

    echon : process
    begin
        
        wait until trig = '1';
        wait until trig = '0';
        wait for 100 ns;
        echo <= '1';
        wait for 2 ms;
        echo <= '0';

        wait for 100 ns;
        chipselect <= '1';
        Read_n <= '0';
        wait for 300 ns;
        chipselect <= '0';
        Read_n <= '1';


        wait for 500 ns;
        wait until trig = '1';
        wait until trig = '0';
        wait for 100 ns;
        echo <= '1';
        wait for 10 ms;
        echo <= '0';

        wait for 100 ns;
        chipselect <= '1'; 
        Read_n <= '0';
        wait for 300 ns;
        chipselect <= '0';
        Read_n <= '1';


        wait for 500 ns;
        wait until trig = '1';
        wait until trig = '0';
        wait for 100 ns;
        echo <= '1';
        wait for 20 ms;
        echo <= '0';

        wait for 100 ns;
        chipselect <= '1';
        Read_n <= '0';
        wait for 300 ns;
        chipselect <= '0';
        Read_n <= '1';

    end process;
end architecture;