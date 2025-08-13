# Set working library
vlib work
vmap work work
vlog +acc gf180mcu-pdk/macros/gf180mcu_fd_ip_sram/latest/cells/gf180mcu_fd_ip_sram__sram64x8m8wm1/gf180mcu_fd_ip_sram__sram64x8m8wm1.v \
     gf180mcu-pdk/macros/gf180mcu_fd_ip_sram/latest/cells/gf180mcu_fd_ip_sram__sram128x8m8wm1/gf180mcu_fd_ip_sram__sram128x8m8wm1.v \
     gf180mcu-pdk/macros/gf180mcu_fd_ip_sram/latest/cells/gf180mcu_fd_ip_sram__sram256x8m8wm1/gf180mcu_fd_ip_sram__sram256x8m8wm1.v \
     gf180mcu-pdk/macros/gf180mcu_fd_ip_sram/latest/cells/gf180mcu_fd_ip_sram__sram512x8m8wm1/gf180mcu_fd_ip_sram__sram512x8m8wm1.v

# Compile design and testbench
vlog +acc -sv +define+QUESTASIM \
     gf180mcu_sram_wrapper.sv \
     tb_sram_wrapper.sv

# Elaborate the testbench
vsim -voptargs="+acc" -debugdb=tb_sram_wrapper.dbg -postsimdataflow -wlf tb_sram_wrapper.wlf +notimingchecks +nospecify work.tb_sram_wrapper

# Run simulation
log -r /*
run -all