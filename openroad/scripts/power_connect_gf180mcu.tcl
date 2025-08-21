# Copyright 2024 ETH Zurich and University of Bologna.
# Solderpad Hardware License, Version 0.51, see LICENSE for details.
# SPDX-License-Identifier: SHL-0.51

# Authors:
# - Philippe Sauter   <phsauter@iis.ee.ethz.ch>


##########################################################################
# Global Connections
##########################################################################
####################################
# global connections
####################################
add_global_connection -net {VDD} -inst_pattern {.*} -pin_pattern {^VDD$} -power
add_global_connection -net {VDD} -inst_pattern {.*} -pin_pattern {^VDDPE$}
add_global_connection -net {VDD} -inst_pattern {.*} -pin_pattern {^VDDCE$}
add_global_connection -net {VDD} -inst_pattern {.*} -pin_pattern {^VDDP$}
add_global_connection -net {VDD} -inst_pattern {.*} -pin_pattern {^VDDC$}
add_global_connection -net {VDD} -inst_pattern {.*} -pin_pattern {^VNW$}
add_global_connection -net {VSS} -inst_pattern {.*} -pin_pattern {^VSS$} -ground
add_global_connection -net {VSS} -inst_pattern {.*} -pin_pattern {^VSSE$}
add_global_connection -net {VSS} -inst_pattern {.*} -pin_pattern {^VSSC$}
add_global_connection -net {VSS} -inst_pattern {.*} -pin_pattern {^VPW$}
####################################
# voltage domains
####################################
set_voltage_domain -name {CORE} -power {VDD} -ground {VSS}
####################################
# standard cell grid
####################################
define_pdn_grid -name {block} -voltage_domains {CORE} 
add_pdn_stripe -grid {block} -layer {Metal1} -width {0.600} -pitch {3.92} -offset {0} -followpins
add_pdn_stripe -grid {block} -layer {Metal4} -width {4.480} -spacing {0.56} -pitch {44.8} -offset {22.4}
add_pdn_stripe -grid {block} -layer {Metal5} -width {4.480} -pitch {89.6} -offset {44.8}
add_pdn_connect -grid {block} -layers {Metal1 Metal4} -max_columns {5} -ongrid {Metal2 Metal3 Metal4} -split_cuts {Metal3 0.128}
add_pdn_connect -grid {block} -layers {Metal4 Metal5}


# # std cells
# add_global_connection -net {VDD} -pin_pattern {VDD} -power
# add_global_connection -net {VSS} -pin_pattern {VSS} -ground
# # # pads
# # add_global_connection -net {VDD} -inst_pattern {.*} -pin_pattern {vdd} -power
# # add_global_connection -net {VSS} -inst_pattern {.*} -pin_pattern {vss} -ground
# # fix for bondpad/port naming
# # add_global_connection -net {VDDIO} -pin_pattern {DVDD} -power
# # add_global_connection -net {VSSIO} -pin_pattern {DVSS} -ground
# # # rams
# # add_global_connection -net {VDD} -inst_pattern {.*} -pin_pattern {VDDARRAY} -power
# # add_global_connection -net {VDD} -inst_pattern {.*} -pin_pattern {VDDARRAY!} -power
# # add_global_connection -net {VDD} -inst_pattern {.*} -pin_pattern {VDD!} -power
# # add_global_connection -net {VSS} -inst_pattern {.*} -pin_pattern {VSS!} -ground

# # # pads
# # add_global_connection -net {VDDIO} -inst_pattern {.*} -pin_pattern {iovdd} -power
# # add_global_connection -net {VSSIO} -inst_pattern {.*} -pin_pattern {iovss} -ground
# # # fix for bondpad/port naming
# # add_global_connection -net {VDDIO} -inst_pattern {.*} -pin_pattern {.*iovdd_RING} -power
# # add_global_connection -net {VSSIO} -inst_pattern {.*} -pin_pattern {.*iovss_RING} -ground

# # connection
# global_connect

# # voltage domains
# set_voltage_domain -name {CORE} -power {VDD} -ground {VSS}
# # standard cell grid and rings
# define_pdn_grid -name {core_grid} -voltage_domains {CORE}
