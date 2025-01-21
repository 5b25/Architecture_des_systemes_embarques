library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Servomo_tb is
end entity;

architecture Bench of Servomo_tb is
    signal clk          : std_logic;
    signal reset_n      : std_logic;
    signal chipselect   : std_logic := '0';
    signal Write_n      : std_logic := '0';
    signal commande     : std_logic;
    signal writedata    : std_logic_vector(31 downto 0);

begin
    -- 实例化被测试模块
    G1: entity work.Servomo_us
        port map (
            clk         => clk, 
            reset_n     => reset_n, 
            chipselect  => chipselect,
            Write_n     => Write_n,
            commande    => commande, 
            writedata   => writedata
        );

    -- 时钟生成过程
    Clock: process
    begin
        while now <= 150 ms loop
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
        end loop;
        wait;
    end process;
    
    -- 复位信号
    Reset: process
    begin
        reset_n <= '0'; 
        wait for 100 ns;
        reset_n <= '1'; 
        wait;           
    end process;

    -- 测试信号生成
    echon: process
    begin
        -- 0°
        chipselect <= '1';
        Write_n <= '0';
        writedata <= "00000000000000000000000000000000";
        wait for 20 ms;

        -- 30°
        writedata <= "00000000000000000000000000011110";
        wait for 20 ms;

        -- 停止测试
        wait;
    end process;

end architecture;
