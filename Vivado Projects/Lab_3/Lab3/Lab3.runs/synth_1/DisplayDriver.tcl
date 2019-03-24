# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/svenp/Lab3/Lab3.cache/wt [current_project]
set_property parent.project_path C:/Users/svenp/Lab3/Lab3.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Users/svenp/Lab3/Lab3.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib C:/Users/svenp/Lab3/Lab3.srcs/sources_1/new/DisplayDriver.v
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/svenp/Lab3/Lab3.srcs/constrs_1/new/constraintsDisplayDriver.xdc
set_property used_in_implementation false [get_files C:/Users/svenp/Lab3/Lab3.srcs/constrs_1/new/constraintsDisplayDriver.xdc]

read_xdc C:/Users/svenp/Lab3/Lab3.srcs/constrs_1/new/garbage.xdc
set_property used_in_implementation false [get_files C:/Users/svenp/Lab3/Lab3.srcs/constrs_1/new/garbage.xdc]


synth_design -top DisplayDriver -part xc7a35tcpg236-1


write_checkpoint -force -noxdef DisplayDriver.dcp

catch { report_utilization -file DisplayDriver_utilization_synth.rpt -pb DisplayDriver_utilization_synth.pb }
