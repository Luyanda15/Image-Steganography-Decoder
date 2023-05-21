# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param chipscope.maxJobs 2
set_param xicom.use_bs_reader 1
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/User/Documents/EEE4120F/ISD_Decoder/ISD_Decoder.cache/wt [current_project]
set_property parent.project_path C:/Users/User/Documents/EEE4120F/ISD_Decoder/ISD_Decoder.xpr [current_project]
set_property XPM_LIBRARIES XPM_MEMORY [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part_repo_paths {C:/Users/User/AppData/Roaming/Xilinx/Vivado/2019.1/xhub/board_store} [current_project]
set_property board_part digilentinc.com:nexys4_ddr:part0:1.1 [current_project]
set_property ip_output_repo c:/Users/User/Documents/EEE4120F/ISD_Decoder/ISD_Decoder.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_mem {
  C:/Users/User/Documents/EEE4120F/ISD_Decoder/ISD_Decoder.srcs/sources_1/new/stego_image.mem
  C:/Users/User/Documents/EEE4120F/ISD_Decoder/ISD_Decoder.srcs/sources_1/new/ref_image.mem
}
read_verilog -library xil_defaultlib {
  C:/Users/User/Documents/EEE4120F/ISD_Decoder/ISD_Decoder.srcs/sources_1/new/stego_detector.v
  C:/Users/User/Documents/EEE4120F/ISD_Decoder/ISD_Decoder.srcs/sources_1/new/isd_decoder.v
}
read_ip -quiet C:/Users/User/Documents/EEE4120F/ISD_Decoder/ISD_Decoder.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.xci
set_property used_in_implementation false [get_files -all c:/Users/User/Documents/EEE4120F/ISD_Decoder/ISD_Decoder.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/User/Documents/EEE4120F/ISD_Decoder/ISD_Decoder.srcs/constrs_1/new/IO_Port.xdc
set_property used_in_implementation false [get_files C:/Users/User/Documents/EEE4120F/ISD_Decoder/ISD_Decoder.srcs/constrs_1/new/IO_Port.xdc]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top isd_decoder -part xc7a100tcsg324-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef isd_decoder.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file isd_decoder_utilization_synth.rpt -pb isd_decoder_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
