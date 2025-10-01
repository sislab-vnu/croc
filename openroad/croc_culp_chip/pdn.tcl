###################################
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

add_global_connection -net {VDD} -inst_pattern {.*} -pin_pattern {DVDD} -power
add_global_connection -net {VSS} -inst_pattern {.*} -pin_pattern {DVSS} -ground

# global_connect

####################################
# voltage domains
####################################
set_voltage_domain -name {CORE} -power {VDD} -ground {VSS}
####################################
# standard cell grid
####################################
define_pdn_grid -name {core_grid} -voltage_domains {CORE}

add_pdn_ring -grid {core_grid} \
   -layer        {Metal4 Metal5} \
   -widths       "4.48 4.48" \
   -spacings     "0.56 0.56" \
    -pad_offsets  "6 6" \
    -connect_to_pads \
    -connect_to_pad_layers {Metal2 Metal4 Metal5}

add_pdn_stripe -grid {core_grid} \
    -layer {Metal1} \
    -width {0.600} \
    -pitch {3.92} \
    -offset {0} \
    -extend_to_core_ring \
    -followpins

add_pdn_stripe -grid {core_grid} \
    -layer {Metal4} \
    -width {4.480} \
    -spacing {0.56} \
    -pitch {44.8} \
    -offset {22.4} \
    -snap_to_grid \

add_pdn_stripe -grid {core_grid} \
    -layer {Metal5} \
    -width {4.480} \
    -pitch {86.24} \
    -offset {43.12} \
    -snap_to_grid \
    -extend_to_core_ring

add_pdn_connect -grid {core_grid} \
    -layers {Metal1 Metal4} \
    -max_columns {5} \
    -ongrid {Metal2 Metal3 Metal4}

add_pdn_connect -grid {core_grid} \
    -layers {Metal5 Metal1}
add_pdn_connect -grid {core_grid} \
    -layers {Metal5 Metal2}
add_pdn_connect -grid {core_grid} \
    -layers {Metal4 Metal2}
add_pdn_connect -grid {core_grid} \
    -layers {Metal5 Metal4}

define_pdn_grid -macro -name macro -default -voltage_domains {CORE}
add_pdn_connect -grid {macro} -layers {Metal4 Metal5}

pdngen -report_only
