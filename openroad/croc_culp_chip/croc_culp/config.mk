export YOSYS_EXE = $(shell which yosys)
export OPENROAD_EXE = $(shell which openroad)
export PROJECT_ROOT = .

export DESIGN_NAME = croc_culp
export TOP_DESIGN_NICKNAME = croc_culp_chip
export DESIGN_NICKNAME = ${TOP_DESIGN_NICKNAME}_${DESIGN_NAME}

export TRACK_OPTION    = 7t
export POWER_OPTION    = 5v0
export METAL_OPTION    = 5LM_1TM
export KVALUE          = 9

export PLATFORM        = gf180
export CORE_AREA = 15 15 2165 1831
export DIE_AREA = 0 0 2180 1846

export PLACE_PINS_ARGS = -min_distance 50.0 -corner_avoidance 50.0

export FAST_LIB_FILES = $(abspath $(PLATFORM_DIR)/lib/gf180mcu_fd_sc_mcu$(TRACK_OPTION)$(POWER_OPTION)__ff_n40C_3v60.lib.gz) \
			$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lib/gf180mcu_fd_ip_sram__sram256x8m8wm1__ff_n40C_3v60.lib \
			$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lib/gf180mcu_fd_ip_sram__sram512x8m8wm1__ff_n40C_3v60.lib 
export FAST_TEMPERATURE = -40c
export FAST_VOLTAGE     = 3.6

export SLOW_LIB_FILES = $(abspath $(PLATFORM_DIR)/lib/gf180mcu_fd_sc_mcu$(TRACK_OPTION)$(POWER_OPTION)__ss_125C_3v00.lib.gz) \
			$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lib/gf180mcu_fd_ip_sram__sram256x8m8wm1__ss_125C_3v00.lib \
			$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lib/gf180mcu_fd_ip_sram__sram512x8m8wm1__ss_125C_3v00.lib

export SLOW_TEMPERATURE = 125c
export SLOW_VOLTAGE     = 3.0

export TYP_LIB_FILES = $(abspath $(PLATFORM_DIR)/lib/gf180mcu_fd_sc_mcu$(TRACK_OPTION)$(POWER_OPTION)__tt_025C_3v30.lib.gz) \
			$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lib/gf180mcu_fd_ip_sram__sram256x8m8wm1__tt_025C_3v30.lib \
			$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lib/gf180mcu_fd_ip_sram__sram512x8m8wm1__tt_025C_3v30.lib

export TYP_TEMPERATURE = 25c
export TYP_VOLTAGE     = 3.3


export SYNTH_NETLIST_FILES = $(DESIGN_NAME)/croc_culp_yosys.v
export PDK_PATH = $(PDK_ROOT)/$(PDK)
export ADDITIONAL_LEFS = $(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lef/gf180mcu_fd_ip_sram__sram256x8m8wm1.lef \
	$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lef/gf180mcu_fd_ip_sram__sram512x8m8wm1.lef

export ADDITIONAL_LIBS = $(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lib/gf180mcu_fd_ip_sram__sram256x8m8wm1__tt_025C_5v00.lib \
		$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lib/gf180mcu_fd_ip_sram__sram512x8m8wm1__tt_025C_5v00.lib
export ADDITIONAL_GDS = $(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/gds/gf180mcu_fd_ip_sram__sram256x8m8wm1.gds \
		$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/gds/gf180mcu_fd_ip_sram__sram512x8m8wm1.gds

export SDC_FILE        = $(DESIGN_NAME)/constraints.sdc

export MAX_ROUTING_LAYER = Metal4

export PDN_TCL = $(DESIGN_NAME)/pdn.tcl
export IO_CONSTRAINTS = $(DESIGN_NAME)/io.tcl
export MACRO_PLACEMENT_TCL = $(DESIGN_NAME)/macro_placement.tcl

export CORE_MARGIN       = 2

export PLACE_DENSITY = 0.5
export MACRO_PLACE_HALO = 20 20

export CORNERS = slow typ fast

ifeq ($(USE_FILL),1)
export DESIGN_TYPE = CELL
else
export DESIGN_TYPE = CELL_NODEN
endif
