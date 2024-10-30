# ------------------------------------------------------------------------------
#  IO Map
# ------------------------------------------------------------------------------
set_property IOSTANDARD LVCMOS33 [get_ports digging]
set_property IOSTANDARD LVCMOS33 [get_ports jumping]
set_property IOSTANDARD LVCMOS33 [get_ports walk_left]
set_property IOSTANDARD LVCMOS33 [get_ports aah]
set_property IOSTANDARD LVCMOS33 [get_ports walk_right]
set_property PACKAGE_PIN J11 [get_ports aah]
set_property PACKAGE_PIN J10 [get_ports digging]
set_property PACKAGE_PIN K13 [get_ports jumping]
set_property PACKAGE_PIN K12 [get_ports walk_left]
set_property PACKAGE_PIN H11 [get_ports walk_right]
# ------------------------------------------------------------------------------
#  create virtual clock
# ------------------------------------------------------------------------------
create_clock -add -name clk_virt_100mhz -period 10.00
# ------------------------------------------------------------------------------
#  input timing
# ------------------------------------------------------------------------------

set_false_path -to {digging}
set_output_delay -clock [get_clocks clk_virt_100mhz] -min -add_delay 1.000 [get_ports {digging}]
set_output_delay -clock [get_clocks clk_virt_100mhz] -max -add_delay 3.000 [get_ports {digging}]

set_false_path -to {jumping}
set_output_delay -clock [get_clocks clk_virt_100mhz] -min -add_delay 1.000 [get_ports {jumping}]
set_output_delay -clock [get_clocks clk_virt_100mhz] -max -add_delay 3.000 [get_ports {jumping}]

set_false_path -to {walk_left}
set_output_delay -clock [get_clocks clk_virt_100mhz] -min -add_delay 1.000 [get_ports {walk_left}]
set_output_delay -clock [get_clocks clk_virt_100mhz] -max -add_delay 3.000 [get_ports {walk_left}]

set_false_path -to {aah}
set_output_delay -clock [get_clocks clk_virt_100mhz] -min -add_delay 1.000 [get_ports {aah}]
set_output_delay -clock [get_clocks clk_virt_100mhz] -max -add_delay 3.000 [get_ports {aah}]

set_false_path -to {walk_right}
set_output_delay -clock [get_clocks clk_virt_100mhz] -min -add_delay 1.000 [get_ports {walk_right}]
set_output_delay -clock [get_clocks clk_virt_100mhz] -max -add_delay 3.000 [get_ports {walk_right}]


