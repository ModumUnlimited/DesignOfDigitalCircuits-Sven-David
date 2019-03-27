#Clock signal
set_property PACKAGE_PIN W5 [get_ports clock]
set_property IOSTANDARD LVCMOS33 [get_ports clock]
create_clock -period 10 -waveform {0 5} [get_ports clock]

#LEDs
set_property PACKAGE_PIN W18 [get_ports out[5]]
set_property PACKAGE_PIN U15 [get_ports out[4]]
set_property PACKAGE_PIN U14 [get_ports out[3]]
set_property PACKAGE_PIN U19 [get_ports out[2]]
set_property PACKAGE_PIN E19 [get_ports out[1]]
set_property PACKAGE_PIN U16 [get_ports out[0]]
set_property IOSTANDARD LVCMOS33 [get_ports out]

#Buttons
set_property PACKAGE_PIN W19 [get_ports direction[1]]
set_property PACKAGE_PIN U18 [get_ports reset]
set_property PACKAGE_PIN T17 [get_ports direction[0]]
set_property IOSTANDARD LVCMOS33 [get_ports {direction reset}]