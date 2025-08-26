export TRACK_OPTION    = 7t
export POWER_OPTION    = 5v0
export METAL_OPTION    = 5LM_1TM
export KVALUE          = 9
export DESIGN_NICKNAME = croc_culp
export DESIGN_NAME     = croc_culp
# export DESIGN_NAME     = delay_stage
export PLATFORM        = gf180
export CORE_AREA = 20 20 2200 1800
export DIE_AREA = 0 0 2220 1820
export SYNTH_NETLIST_FILES = ../../yosys/out/croc_culp_yosys.v
PDK_PATH ?= $(CONDA_PREFIX)/share/pdk/gf180mcuD
export BC_LIB_FILES                           = $(abspath $(PLATFORM_DIR)/lib/gf180mcu_fd_sc_mcu$(TRACK_OPTION)$(POWER_OPTION)__ff_n40C_3v60.lib.gz)
export BC_TEMPERATURE                         = -40c
export BC_VOLTAGE                             = 3.6

export WC_LIB_FILES                           = $(abspath $(PLATFORM_DIR)/lib/gf180mcu_fd_sc_mcu$(TRACK_OPTION)$(POWER_OPTION)__ss_125C_3v00.lib.gz)
export WC_TEMPERATURE                         = 125c
export WC_VOLTAGE                             = 3.0

export TC_LIB_FILES                           = $(abspath $(PLATFORM_DIR)/lib/gf180mcu_fd_sc_mcu$(TRACK_OPTION)$(POWER_OPTION)__tt_025C_3v30.lib.gz)
export TC_TEMPERATURE                         = 25c
export TC_VOLTAGE                             = 3.3

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
