library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity avalon_pwm_4_channels is
  port (
    clk        : in std_logic;
    writedata  : in std_logic_vector (31 downto 0);
    chipselect : in std_logic;
    write_n    : in std_logic;
    address    : in std_logic_vector (2 downto 0); -- 3位地址（0到7）
    reset_n    : in std_logic;
    readdata   : out std_logic_vector (31 downto 0);
    out_port   : out std_logic_vector (3 downto 0) -- 4路PWM输出
  );
end avalon_pwm_4_channels;

architecture RTL of avalon_pwm_4_channels is

  -- 定义用于DIV和DUTY的数组类型
  type reg_array is array (0 to 3) of unsigned(31 downto 0);

  -- 使用reg_array类型声明DIV和DUTY寄存器
  signal div     : reg_array;
  signal duty    : reg_array;

  signal counter : unsigned (31 downto 0);
  signal pwm_on  : std_logic_vector(3 downto 0);

begin

  readdata <= std_logic_vector(div(to_integer(unsigned(address(1 downto 0))))) when address(2) = '0' else
    std_logic_vector(duty(to_integer(unsigned(address(1 downto 0)))));

  -- 管理DIV和DUTY寄存器的进程
    registers: process (clk, reset_n)
    begin
      if reset_n = '0' then
        for i in 0 to 3 loop
          div(i)  <= (others => '0');
          duty(i) <= (others => '0');
        end loop;
      elsif rising_edge(clk) then
        if chipselect = '1' and write_n = '0' then
          if address(2) = '0' then
            div(to_integer(unsigned(address(1 downto 0)))) <= unsigned(writedata);
          else
            duty(to_integer(unsigned(address(1 downto 0)))) <= unsigned(writedata);
          end if;
        end if;
      end if;
    end process;

  -- 频率分频器的进程
  divider: process (clk, reset_n)
  begin
    if reset_n = '0' then
      counter <= (others => '0');
    elsif clk'event and clk = '1' then
      if address(2) = '0' then
        if counter >= div(to_integer(unsigned(address(1 downto 0)))) then
          counter <= (others => '0');
        else
          counter <= counter + 1;
        end if;
      end if;
    end if;
  end process;

  -- 每个PWM通道的占空比控制进程
  duty_cyle: process (clk, reset_n)
  begin
    if reset_n = '0' then
      pwm_on <= (others => '1');
    elsif rising_edge(clk) then
      for i in 0 to 3 loop
        if counter >= duty(i) then
          pwm_on(i) <= '0';
        elsif counter = 0 then
          pwm_on(i) <= '1';
        end if;
      end loop;
    end if;
  end process;

  out_port <= pwm_on;

end RTL;