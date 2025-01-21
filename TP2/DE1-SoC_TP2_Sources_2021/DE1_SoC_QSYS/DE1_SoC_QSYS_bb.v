
module DE1_SoC_QSYS (
	adc_ltc2308_conduit_end_CONVST,
	adc_ltc2308_conduit_end_SCK,
	adc_ltc2308_conduit_end_SDI,
	adc_ltc2308_conduit_end_SDO,
	avalon_pwm_inst_led_pwm_readdata,
	clk_clk,
	key_external_connection_export,
	pll_sys_locked_export,
	pll_sys_outclk2_clk,
	reset_reset_n,
	seven_seg_seven_seg_pwm_hex0,
	seven_seg_seven_seg_pwm_hex1,
	seven_seg_seven_seg_pwm_hex2,
	seven_seg_seven_seg_pwm_hex3,
	seven_seg_seven_seg_pwm_hex4,
	seven_seg_seven_seg_pwm_hex5,
	sw_external_connection_export,
	pwm_4_channel_1_qsys_writedata);	

	output		adc_ltc2308_conduit_end_CONVST;
	output		adc_ltc2308_conduit_end_SCK;
	output		adc_ltc2308_conduit_end_SDI;
	input		adc_ltc2308_conduit_end_SDO;
	output	[9:0]	avalon_pwm_inst_led_pwm_readdata;
	input		clk_clk;
	input	[3:0]	key_external_connection_export;
	output		pll_sys_locked_export;
	output		pll_sys_outclk2_clk;
	input		reset_reset_n;
	output	[6:0]	seven_seg_seven_seg_pwm_hex0;
	output	[6:0]	seven_seg_seven_seg_pwm_hex1;
	output	[6:0]	seven_seg_seven_seg_pwm_hex2;
	output	[6:0]	seven_seg_seven_seg_pwm_hex3;
	output	[6:0]	seven_seg_seven_seg_pwm_hex4;
	output	[6:0]	seven_seg_seven_seg_pwm_hex5;
	input	[9:0]	sw_external_connection_export;
	output	[9:0]	pwm_4_channel_1_qsys_writedata;
endmodule
