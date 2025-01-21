library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Servomo_us is
    generic(
        CLK_FREQ       : integer := 50000000; -- 时钟频率，50 MHz
        PWM_FREQ       : integer := 50        -- PWM 频率，50 Hz
    );
    port(
        clk         : in std_logic;                    -- 时钟信号
        reset_n     : in std_logic;                    -- 异步复位信号，低电平有效
        chipselect  : in std_logic;                    -- Avalon 接口选择信号
        Write_n     : in std_logic;                    -- Avalon 写信号，低电平有效
        writedata   : in std_logic_vector(31 downto 0);-- Avalon 输入数据端口
        commande    : out std_logic                    -- PWM 输出信号
    );
end entity;

architecture RTL of Servomo_us is
    -- 内部常量
    constant MIN_PULSE_WIDTH : integer := CLK_FREQ / 1000; -- 最小脉宽 (1 ms 对应的时钟周期)
    constant MAX_PULSE_WIDTH : integer := CLK_FREQ / 500;  -- 最大脉宽 (2 ms 对应的时钟周期)
    constant PWM_PERIOD      : integer := CLK_FREQ / PWM_FREQ; -- PWM 周期对应的时钟周期数
    constant DEGREE_STEP     : integer := (MAX_PULSE_WIDTH - MIN_PULSE_WIDTH) / 180; -- 每度对应的脉宽增量

    -- 内部信号
    signal degree           : integer := 0;             -- 当前角度值（0-180）
    signal pwm_cnt          : integer := 0;             -- PWM 计数器
    signal pwm_duty         : integer := 0;             -- 当前角度计算出的占空比
    signal position         : std_logic_vector(7 downto 0) := (others => '0'); -- 角度输入信号
begin

    -- PWM 信号生成逻辑
    process(clk, reset_n)
    begin
        if reset_n = '0' then
            -- 异步复位逻辑
            degree <= 0;                       -- 复位角度值
            pwm_cnt <= 0;                      -- 重置计数器
            pwm_duty <= MIN_PULSE_WIDTH;       -- 默认占空比为最小脉宽
            commande <= '0';                   -- PWM 输出复位
            position <= (others => '0');       -- 重置位置信号
        elsif rising_edge(clk) then
            if (chipselect = '1' and write_n = '0') then
                position <= writedata(7 downto 0);
            end if;

            -- 从 position 提取角度值
            degree <= to_integer(unsigned(position));

            -- 根据角度计算 PWM 占空比
            pwm_duty <= MIN_PULSE_WIDTH + (degree * DEGREE_STEP);

            -- 生成 PWM 信号
            if pwm_cnt < pwm_duty then
                commande <= '1';               -- 输出高电平
            else
                commande <= '0';               -- 输出低电平
            end if;

            -- 计数器递增
            pwm_cnt <= pwm_cnt + 1;

            -- 每个周期结束后重置计数器
            if pwm_cnt = PWM_PERIOD then
                pwm_cnt <= 0;
            end if;
        end if;
    end process;

end architecture;
