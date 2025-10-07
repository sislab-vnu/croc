place_macro -macro_name {i_croc_soc.i_croc.gen_sram_bank\[1\].i_sram.gen_512x32xBx1.i_cut.byte_slice\[0\].depth_bank\[0\].genblk1.u_sram} -location {48.16 1379.84} -orientation MY
place_macro -macro_name {i_croc_soc.i_croc.gen_sram_bank\[1\].i_sram.gen_512x32xBx1.i_cut.byte_slice\[2\].depth_bank\[0\].genblk1.u_sram} -location {540.96 1379.84} -orientation R0
place_macro -macro_name {i_croc_soc.i_croc.gen_sram_bank\[0\].i_sram.gen_512x32xBx1.i_cut.byte_slice\[3\].depth_bank\[0\].genblk1.u_sram} -location {1655.92 1379.84} -orientation R0
place_macro -macro_name {i_croc_soc.i_croc.gen_sram_bank\[1\].i_sram.gen_512x32xBx1.i_cut.byte_slice\[3\].depth_bank\[0\].genblk1.u_sram} -location {1121.12 1379.84} -orientation R0

## cluster
place_macro -macro_name {i_croc_soc.i_croc.gen_sram_bank\[0\].i_sram.gen_512x32xBx1.i_cut.byte_slice\[1\].depth_bank\[0\].genblk1.u_sram} -location {48.16 39.2} -orientation MX
place_macro -macro_name {i_croc_soc.i_croc.gen_sram_bank\[0\].i_sram.gen_512x32xBx1.i_cut.byte_slice\[2\].depth_bank\[0\].genblk1.u_sram} -location {540.96 39.2} -orientation MX
place_macro -macro_name {i_croc_soc.i_croc.gen_sram_bank\[0\].i_sram.gen_512x32xBx1.i_cut.byte_slice\[0\].depth_bank\[0\].genblk1.u_sram} -location {1121.12 39.2} -orientation MX
place_macro -macro_name {i_croc_soc.i_croc.gen_sram_bank\[1\].i_sram.gen_512x32xBx1.i_cut.byte_slice\[1\].depth_bank\[0\].genblk1.u_sram} -location {1655.92 39.2} -orientation MX

source croc_culp/add_routing_blk.tcl


# place_macro -macro_name {i_croc_soc/i_croc/gen_sram_bank\[0\].i_sram/gen_512x32xBx1.i_cut.byte_slice\[0\].depth_bank\[0\].genblk1.u_sram} -location {45.56 35.68} -orientation R180
# place_macro -macro_name {i_croc_soc/i_croc/gen_sram_bank\[0\].i_sram/gen_512x32xBx1.i_cut.byte_slice\[1\].depth_bank\[0\].genblk1.u_sram} -location {540.6 35.68} -orientation R180
# place_macro -macro_name {i_croc_soc/i_croc/gen_sram_bank\[0\].i_sram/gen_512x32xBx1.i_cut.byte_slice\[2\].depth_bank\[0\].genblk1.u_sram} -location {1167.6 35.68} -orientation R180
# place_macro -macro_name {i_croc_soc/i_croc/gen_sram_bank\[0\].i_sram/gen_512x32xBx1.i_cut.byte_slice\[3\].depth_bank\[0\].genblk1.u_sram} -location {1705.4 35.68} -orientation R180
# place_macro -macro_name {i_croc_soc/i_croc/gen_sram_bank\[1\].i_sram/gen_512x32xBx1.i_cut.byte_slice\[0\].depth_bank\[0\].genblk1.u_sram} -location {45.48 1312.4} -orientation R0
# place_macro -macro_name {i_croc_soc/i_croc/gen_sram_bank\[1\].i_sram/gen_512x32xBx1.i_cut.byte_slice\[1\].depth_bank\[0\].genblk1.u_sram} -location {540.6 1312.4} -orientation R0
# place_macro -macro_name {i_croc_soc/i_croc/gen_sram_bank\[1\].i_sram/gen_512x32xBx1.i_cut.byte_slice\[2\].depth_bank\[0\].genblk1.u_sram} -location {1167.89 1312.4} -orientation R0
# place_macro -macro_name {i_croc_soc/i_croc/gen_sram_bank\[1\].i_sram/gen_512x32xBx1.i_cut.byte_slice\[3\].depth_bank\[0\].genblk1.u_sram} -location {1705.4 1312.4} -orientation R0

# place_macro -macro_name {i_croc_soc/i_croc/gen_sram_bank\[0\].i_sram.gen_512x32xBx1.i_cut.byte_slice\[0\].depth_bank\[0\].genblk1.u_sram} -location {45.56 35.68} -orientation R180
# place_macro -macro_name {i_croc_soc/i_croc/gen_sram_bank\[0\].i_sram.gen_512x32xBx1.i_cut.byte_slice\[1\].depth_bank\[0\].genblk1.u_sram} -location {540.6 35.68} -orientation R180
# place_macro -macro_name {i_croc_soc/i_croc/gen_sram_bank\[0\].i_sram.gen_512x32xBx1.i_cut.byte_slice\[2\].depth_bank\[0\].genblk1.u_sram} -location {1167.6 35.68} -orientation R180
# place_macro -macro_name {i_croc_soc/i_croc/gen_sram_bank\[0\].i_sram.gen_512x32xBx1.i_cut.byte_slice\[3\].depth_bank\[0\].genblk1.u_sram} -location {1705.4 35.68} -orientation R180
# place_macro -macro_name {i_croc_soc/i_croc/gen_sram_bank\[1\].i_sram.gen_512x32xBx1.i_cut.byte_slice\[0\].depth_bank\[0\].genblk1.u_sram} -location {45.48 1325.68} -orientation R0
# place_macro -macro_name {i_croc_soc/i_croc/gen_sram_bank\[1\].i_sram.gen_512x32xBx1.i_cut.byte_slice\[1\].depth_bank\[0\].genblk1.u_sram} -location {540.6 1325.68} -orientation R0
# place_macro -macro_name {i_croc_soc/i_croc/gen_sram_bank\[1\].i_sram.gen_512x32xBx1.i_cut.byte_slice\[2\].depth_bank\[0\].genblk1.u_sram} -location {1167.89 1325.68} -orientation R0
# place_macro -macro_name {i_croc_soc/i_croc/gen_sram_bank\[1\].i_sram.gen_512x32xBx1.i_cut.byte_slice\[3\].depth_bank\[0\].genblk1.u_sram} -location {1705.4 1325.68} -orientation R0
