#Use this for the decoder circuit (Exercise 1)

#Input
set_property PACKAGE_PIN R2 [get_ports{a[0]}]
set_property PACKAGE_PIN T1 [get_ports{a[1]}]

#Output
set_property PACKAGE_PIN V19 [get_ports{o[0]}]
set_property PACKAGE_PIN U19 [get_ports{o[1]}]
set_property PACKAGE_PIN E19 [get_ports{o[2]}]
set_property PACKAGE_PIN U16 [get_ports{o[3]}]


set_property IOSTANDARD LVCMOS33 [get_ports{a o}]