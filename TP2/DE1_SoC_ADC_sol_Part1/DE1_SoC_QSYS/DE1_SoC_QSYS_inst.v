	DE1_SoC_QSYS u0 (
		.clk_clk                         (<connected-to-clk_clk>),                         //                      clk.clk
		.reset_reset_n                   (<connected-to-reset_reset_n>),                   //                    reset.reset_n
		.adc_ltc2308_conduit_end_CONVST  (<connected-to-adc_ltc2308_conduit_end_CONVST>),  //  adc_ltc2308_conduit_end.CONVST
		.adc_ltc2308_conduit_end_SCK     (<connected-to-adc_ltc2308_conduit_end_SCK>),     //                         .SCK
		.adc_ltc2308_conduit_end_SDI     (<connected-to-adc_ltc2308_conduit_end_SDI>),     //                         .SDI
		.adc_ltc2308_conduit_end_SDO     (<connected-to-adc_ltc2308_conduit_end_SDO>),     //                         .SDO
		.sw_external_connection_export   (<connected-to-sw_external_connection_export>),   //   sw_external_connection.export
		.pll_sys_locked_export           (<connected-to-pll_sys_locked_export>),           //           pll_sys_locked.export
		.pll_sys_outclk2_clk             (<connected-to-pll_sys_outclk2_clk>),             //          pll_sys_outclk2.clk
		.hex0_external_connection_export (<connected-to-hex0_external_connection_export>), // hex0_external_connection.export
		.ledr_external_connection_export (<connected-to-ledr_external_connection_export>), // ledr_external_connection.export
		.hex1_external_connection_export (<connected-to-hex1_external_connection_export>), // hex1_external_connection.export
		.hex2_external_connection_export (<connected-to-hex2_external_connection_export>), // hex2_external_connection.export
		.hex3_external_connection_export (<connected-to-hex3_external_connection_export>), // hex3_external_connection.export
		.hex4_external_connection_export (<connected-to-hex4_external_connection_export>), // hex4_external_connection.export
		.hex5_external_connection_export (<connected-to-hex5_external_connection_export>), // hex5_external_connection.export
		.key_external_connection_export  (<connected-to-key_external_connection_export>)   //  key_external_connection.export
	);

