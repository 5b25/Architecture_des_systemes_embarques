	component DE1_SoC_QSYS is
		port (
			adc_ltc2308_conduit_end_CONVST   : out std_logic;                                       -- CONVST
			adc_ltc2308_conduit_end_SCK      : out std_logic;                                       -- SCK
			adc_ltc2308_conduit_end_SDI      : out std_logic;                                       -- SDI
			adc_ltc2308_conduit_end_SDO      : in  std_logic                    := 'X';             -- SDO
			avalon_pwm_inst_led_pwm_readdata : out std_logic_vector(9 downto 0);                    -- readdata
			clk_clk                          : in  std_logic                    := 'X';             -- clk
			key_external_connection_export   : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
			pll_sys_locked_export            : out std_logic;                                       -- export
			pll_sys_outclk2_clk              : out std_logic;                                       -- clk
			reset_reset_n                    : in  std_logic                    := 'X';             -- reset_n
			seven_seg_seven_seg_pwm_hex0     : out std_logic_vector(6 downto 0);                    -- hex0
			seven_seg_seven_seg_pwm_hex1     : out std_logic_vector(6 downto 0);                    -- hex1
			seven_seg_seven_seg_pwm_hex2     : out std_logic_vector(6 downto 0);                    -- hex2
			seven_seg_seven_seg_pwm_hex3     : out std_logic_vector(6 downto 0);                    -- hex3
			seven_seg_seven_seg_pwm_hex4     : out std_logic_vector(6 downto 0);                    -- hex4
			seven_seg_seven_seg_pwm_hex5     : out std_logic_vector(6 downto 0);                    -- hex5
			sw_external_connection_export    : in  std_logic_vector(9 downto 0) := (others => 'X'); -- export
			pwm_4_channel_1_qsys_writedata   : out std_logic_vector(9 downto 0)                     -- writedata
		);
	end component DE1_SoC_QSYS;

	u0 : component DE1_SoC_QSYS
		port map (
			adc_ltc2308_conduit_end_CONVST   => CONNECTED_TO_adc_ltc2308_conduit_end_CONVST,   -- adc_ltc2308_conduit_end.CONVST
			adc_ltc2308_conduit_end_SCK      => CONNECTED_TO_adc_ltc2308_conduit_end_SCK,      --                        .SCK
			adc_ltc2308_conduit_end_SDI      => CONNECTED_TO_adc_ltc2308_conduit_end_SDI,      --                        .SDI
			adc_ltc2308_conduit_end_SDO      => CONNECTED_TO_adc_ltc2308_conduit_end_SDO,      --                        .SDO
			avalon_pwm_inst_led_pwm_readdata => CONNECTED_TO_avalon_pwm_inst_led_pwm_readdata, -- avalon_pwm_inst_led_pwm.readdata
			clk_clk                          => CONNECTED_TO_clk_clk,                          --                     clk.clk
			key_external_connection_export   => CONNECTED_TO_key_external_connection_export,   -- key_external_connection.export
			pll_sys_locked_export            => CONNECTED_TO_pll_sys_locked_export,            --          pll_sys_locked.export
			pll_sys_outclk2_clk              => CONNECTED_TO_pll_sys_outclk2_clk,              --         pll_sys_outclk2.clk
			reset_reset_n                    => CONNECTED_TO_reset_reset_n,                    --                   reset.reset_n
			seven_seg_seven_seg_pwm_hex0     => CONNECTED_TO_seven_seg_seven_seg_pwm_hex0,     -- seven_seg_seven_seg_pwm.hex0
			seven_seg_seven_seg_pwm_hex1     => CONNECTED_TO_seven_seg_seven_seg_pwm_hex1,     --                        .hex1
			seven_seg_seven_seg_pwm_hex2     => CONNECTED_TO_seven_seg_seven_seg_pwm_hex2,     --                        .hex2
			seven_seg_seven_seg_pwm_hex3     => CONNECTED_TO_seven_seg_seven_seg_pwm_hex3,     --                        .hex3
			seven_seg_seven_seg_pwm_hex4     => CONNECTED_TO_seven_seg_seven_seg_pwm_hex4,     --                        .hex4
			seven_seg_seven_seg_pwm_hex5     => CONNECTED_TO_seven_seg_seven_seg_pwm_hex5,     --                        .hex5
			sw_external_connection_export    => CONNECTED_TO_sw_external_connection_export,    --  sw_external_connection.export
			pwm_4_channel_1_qsys_writedata   => CONNECTED_TO_pwm_4_channel_1_qsys_writedata    --    pwm_4_channel_1_qsys.writedata
		);

