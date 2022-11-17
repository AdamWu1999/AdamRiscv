#PL_KEY1
set_property PACKAGE_PIN H6 [get_ports sys_rstn]
set_property IOSTANDARD LVCMOS15 [get_ports sys_rstn]

set_property IOSTANDARD LVCMOS18 [get_ports sys_clk]
set_property PACKAGE_PIN J14 [get_ports sys_clk]

set_property IOSTANDARD LVCMOS15 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS15 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS15 [get_ports {led[0]}]

set_property PACKAGE_PIN F5 [get_ports {led[0]}]
set_property PACKAGE_PIN E5 [get_ports {led[1]}]
set_property PACKAGE_PIN G5 [get_ports {led[2]}]

# enable bitstream compression
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]

create_clock -period 20.000 -name sys_clk [get_ports sys_clk]

set_operating_conditions -grade extended
