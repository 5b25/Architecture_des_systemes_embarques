
module Computer_System (
	hex3_hex0_export,
	hex5_hex4_export,
	leds_export,
	pushbuttons_export,
	sdram_addr,
	sdram_ba,
	sdram_cas_n,
	sdram_cke,
	sdram_cs_n,
	sdram_dq,
	sdram_dqm,
	sdram_ras_n,
	sdram_we_n,
	sdram_clk_clk,
	servo_0_servo_writeresponsevalid_n,
	slider_switches_export,
	system_pll_ref_clk_clk,
	system_pll_ref_reset_reset,
	telemetre_us_avalon_0_telemetre_distance,
	telemetre_us_avalon_0_telemetre_trig,
	telemetre_us_avalon_0_telemetre_echo,
	vga_CLK,
	vga_HS,
	vga_VS,
	vga_BLANK,
	vga_SYNC,
	vga_R,
	vga_G,
	vga_B,
	video_pll_ref_clk_clk,
	video_pll_ref_reset_reset);	

	output	[31:0]	hex3_hex0_export;
	output	[15:0]	hex5_hex4_export;
	output	[9:0]	leds_export;
	input	[1:0]	pushbuttons_export;
	output	[12:0]	sdram_addr;
	output	[1:0]	sdram_ba;
	output		sdram_cas_n;
	output		sdram_cke;
	output		sdram_cs_n;
	inout	[15:0]	sdram_dq;
	output	[1:0]	sdram_dqm;
	output		sdram_ras_n;
	output		sdram_we_n;
	output		sdram_clk_clk;
	output		servo_0_servo_writeresponsevalid_n;
	input	[9:0]	slider_switches_export;
	input		system_pll_ref_clk_clk;
	input		system_pll_ref_reset_reset;
	output	[9:0]	telemetre_us_avalon_0_telemetre_distance;
	output		telemetre_us_avalon_0_telemetre_trig;
	input		telemetre_us_avalon_0_telemetre_echo;
	output		vga_CLK;
	output		vga_HS;
	output		vga_VS;
	output		vga_BLANK;
	output		vga_SYNC;
	output	[3:0]	vga_R;
	output	[3:0]	vga_G;
	output	[3:0]	vga_B;
	input		video_pll_ref_clk_clk;
	input		video_pll_ref_reset_reset;
endmodule
