quit -sim

vlib work 

vcom -2008 machine_etat.vhd
vcom -2008 IP_Telemetre_tb.vhd

vsim -novopt IP_Telemetre_tb
view signals 

add wave sim:/IP_telemetre_tb/G1/*
run -all