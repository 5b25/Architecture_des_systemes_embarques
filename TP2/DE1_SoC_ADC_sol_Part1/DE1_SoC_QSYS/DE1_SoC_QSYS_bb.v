
module DE1_SoC_QSYS (
	clk_clk,
	reset_reset_n,
	adc_ltc2308_conduit_end_CONVST,
	adc_ltc2308_conduit_end_SCK,
	adc_ltc2308_conduit_end_SDI,
	adc_ltc2308_conduit_end_SDO,
	sw_external_connection_export,
	pll_sys_locked_export,
	pll_sys_outclk2_clk,
	hex0_external_connection_export,
	ledr_external_connection_export,
	hex1_external_connection_export,
	hex2_external_connection_export,
	hex3_external_connection_export,
	hex4_external_connection_export,
	hex5_external_connection_export,
	key_external_connection_export);	

	input		clk_clk;
	input		reset_reset_n;
	output		adc_ltc2308_conduit_end_CONVST;
	output		adc_ltc2308_conduit_end_SCK;
	output		adc_ltc2308_conduit_end_SDI;
	input		adc_ltc2308_conduit_end_SDO;
	input	[9:0]	sw_external_connection_export;
	output		pll_sys_locked_export;
	output		pll_sys_outclk2_clk;
	output	[6:0]	hex0_external_connection_export;
	output	[9:0]	ledr_external_connection_export;
	output	[6:0]	hex1_external_connection_export;
	output	[6:0]	hex2_external_connection_export;
	output	[6:0]	hex3_external_connection_export;
	output	[6:0]	hex4_external_connection_export;
	output	[6:0]	hex5_external_connection_export;
	input	[3:0]	key_external_connection_export;
endmodule
