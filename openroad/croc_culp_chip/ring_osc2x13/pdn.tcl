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
define_pdn_grid -name {block} -voltage_domains {CORE} -pins {Metal4}

# add_pdn_ring -grid {block} \
#     -layer        {Metal4 Metal3} \
#     -widths       "4.48 4.48" \
#     -spacings     "0.56 0.56" \
#     -core_offsets "2 2" \
#     -add_connect

add_pdn_stripe -grid {block} \
    -layer {Metal1} \
    -width {0.600} \
    -pitch {3.92} \
    -offset {0} \
    -extend_to_core_ring \
    -followpins

add_pdn_stripe -grid {block} \
    -layer {Metal4} \
    -width {4.480} \
    -spacing {0.56} \
    -pitch {44.8} \
    -extend_to_core_ring \
    -offset {22.4} \
    -snap_to_grid

add_pdn_connect -grid {block} -layers {Metal1 Metal4}
