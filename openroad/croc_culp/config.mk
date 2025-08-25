export TRACK_OPTION    = 7t
export POWER_OPTION    = 5v0
export DESIGN_NICKNAME = croc_culp
export DESIGN_NAME     = croc_culp
# export DESIGN_NAME     = delay_stage
export PLATFORM        = gf180
export CORE_AREA = 20 20 2200 1800
export DIE_AREA = 0 0 2220 1820
export SYNTH_NETLIST_FILES = ../../yosys/out/croc_culp_yosys.v
PDK_PATH ?= $(CONDA_PREFIX)/share/pdk/gf180mcuD
export ADDITIONAL_LEFS = $(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lef/gf180mcu_fd_ip_sram__sram256x8m8wm1.lef \
	$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lef/gf180mcu_fd_ip_sram__sram512x8m8wm1.lef

export ADDITIONAL_LIBS = $(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lib/gf180mcu_fd_ip_sram__sram256x8m8wm1__tt_025C_5v00.lib \
		$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lib/gf180mcu_fd_ip_sram__sram512x8m8wm1__tt_025C_5v00.lib
export ADDITIONAL_GDS = $(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/gds/gf180mcu_fd_ip_sram__sram256x8m8wm1.gds \
		$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/gds/gf180mcu_fd_ip_sram__sram512x8m8wm1.gds
export SDC_FILE        = constraints.sdc
# export ABC_AREA        = 1

# export CORE_UTILIZATION  = 60
# export CORE_ASPECT_RATIO = 1
export PDN_TCL = ./pdn.tcl

export CORE_MARGIN       = 2

export PLACE_DENSITY = 0.5
export MACRO_PLACE_HALO = 40 40

ifeq ($(USE_FILL),1)
export DESIGN_TYPE = CELL
else
export DESIGN_TYPE = CELL_NODEN
endif
