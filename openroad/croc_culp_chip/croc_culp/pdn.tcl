## block grid on M3-M4
## Macro grid on M2-M3 to allow connection from M4 to M3
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

####################################
# voltage domains
####################################
set_voltage_domain -name {CORE} -power {VDD} -ground {VSS}
####################################
# standard cell grid
####################################
define_pdn_grid -name {block} -voltage_domains {CORE} -pins {Metal4}

add_pdn_ring -grid {block} \
   -layer        {Metal4 Metal3} \
   -widths       "4.48 4.48" \
    -spacings     "0.56 0.56" \
    -core_offsets "2 2" \
   -add_connect

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
    -offset {22.4}

# add_pdn_stripe -grid {block} \
#     -layer {Metal5} \
#     -width {4.480} \
#     -pitch {200.0} \
#     -extend_to_core_ring \
#     -offset {44.8}

add_pdn_connect -grid {block} \
    -layers {Metal1 Metal4} \
    -max_columns {5} \
    -ongrid {Metal2 Metal3 Metal4} \
    -split_cuts {Metal3 0.128}

# add_pdn_connect -grid {block} \
#     -layers {Metal4 Metal5}

define_pdn_grid -macro -name macro -starts_with POWER -halo 0 -pins {Metal3}

add_pdn_ring -grid {macro} \
   -layer        {Metal2 Metal3} \
   -widths       "3 3" \
    -spacings     "0.56 0.56" \
    -core_offsets "1 1" \
    -connect_to_pads \
    -add_connect

add_pdn_stripe \
    -grid macro \
    -layer Metal4 \
    -width 3 \
    -pitch 100 \
    -offset 4 \
    -spacing 1 \
    -number_of_straps 1 \
    -starts_with POWER \
    -extend_to_core_ring

add_pdn_stripe \
    -grid macro \
    -layer Metal4 \
    -width 3 \
    -pitch 100 \
    -offset 423.41 \
    -spacing 1 \
    -number_of_straps 1 \
    -starts_with POWER \
    -extend_to_core_ring

add_pdn_connect \
    -grid macro \
    -layers "Metal3 Metal4"

# add_pdn_connect \
#     -grid macro \
#     -layers "Metal4 Metal5"

pdngen -report_only
