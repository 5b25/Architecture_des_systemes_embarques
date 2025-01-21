quit -sim

vlib work 

vcom -2008 Servomo_us.vhd
vcom -2008 Servomo_tb.vhd

vsim -novopt Servomo_tb
view signals 

add wave sim:/Servomo_tb/G1/*
run -all