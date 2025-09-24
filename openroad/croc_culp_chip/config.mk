export YOSYS_EXE = $(shell which yosys)
export OPENROAD_EXE = $(shell which openroad)
export PROJECT_ROOT = .
export DESIGN_NAME = croc_culp_chip
export DESIGN_NICKNAME = croc_culp_chip
export PLATFORM = gf180
export TRACK_OPTION    = 7t
export POWER_OPTION    = 5v0
export METAL_OPTION    = 5LM_1TM
export KVALUE          = 9

export SYNTH_NETLIST_FILES = ./croc_culp_chip_yosys.v

export SDC_FILE = constraint.sdc

# export SEAL_GDS = $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/sealring.gds.gz

export DIE_AREA = 0.0 0.0 2935.0 2935.0
export CORE_AREA = 355.0 355.0 2580.0 2580.0

export MAX_ROUTING_LAYER = Metal5

export TNS_END_PERCENT = 100
export PLACE_DENSITY = 0.75

export CORNERS = slow typ fast

export FOOTPRINT_TCL = ./pad.tcl
export PDN_TCL = ./pdn.tcl

export BLOCKS = croc_culp
export PDK_PATH = $(PDK_ROOT)/$(PDK)

export FAST_LIB_FILES     = $(abspath $(PLATFORM_DIR)/lib/gf180mcu_fd_sc_mcu$(TRACK_OPTION)$(POWER_OPTION)__ff_n40C_3v60.lib.gz) \
				$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lib/gf180mcu_fd_ip_sram__sram256x8m8wm1__ff_n40C_3v60.lib \
				$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lib/gf180mcu_fd_ip_sram__sram512x8m8wm1__ff_n40C_3v60.lib \
				$(PDK_PATH)/libs.ref/gf180mcu_fd_io/lib/gf180mcu_fd_io__ff_n40C_3v63.lib
export FAST_TEMPERATURE   = -40c
export FAST_VOLTAGE       = 3.6

export SLOW_LIB_FILES     = $(abspath $(PLATFORM_DIR)/lib/gf180mcu_fd_sc_mcu$(TRACK_OPTION)$(POWER_OPTION)__ss_125C_3v00.lib.gz) \
				$(PDK_PATH)/libs.ref/gf180mcu_fd_io/lib/gf180mcu_fd_io__ss_125C_2v97.lib \
				$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lib/gf180mcu_fd_ip_sram__sram256x8m8wm1__ss_125C_3v00.lib \
				$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lib/gf180mcu_fd_ip_sram__sram512x8m8wm1__ss_125C_3v00.lib

export SLOW_TEMPERATURE   = 125c
export SLOW_VOLTAGE       = 3.0

export TYP_LIB_FILES      = $(abspath $(PLATFORM_DIR)/lib/gf180mcu_fd_sc_mcu$(TRACK_OPTION)$(POWER_OPTION)__tt_025C_3v30.lib.gz) \
				$(PDK_PATH)/libs.ref/gf180mcu_fd_io/lib/gf180mcu_fd_io__tt_025C_3v30.lib \
				$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lib/gf180mcu_fd_ip_sram__sram256x8m8wm1__tt_025C_3v30.lib \
				$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lib/gf180mcu_fd_ip_sram__sram512x8m8wm1__tt_025C_3v30.lib

export TYP_TEMPERATURE    = 25c
export TYP_VOLTAGE        = 3.3

export MACRO_PLACEMENT_TCL = macro_placement.tcl

export ADDITIONAL_LEFS = $(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lef/gf180mcu_fd_ip_sram__sram256x8m8wm1.lef \
	$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lef/gf180mcu_fd_ip_sram__sram512x8m8wm1.lef \
	$(PDK_PATH)/libs.ref/gf180mcu_fd_io/lef/gf180mcu_fd_io__asig_5p0.lef \
	$(PDK_PATH)/libs.ref/gf180mcu_fd_io/lef/gf180mcu_fd_io__cor.lef \
	$(PDK_PATH)/libs.ref/gf180mcu_fd_io/lef/gf180mcu_fd_io__bi_t.lef \
	$(PDK_PATH)/libs.ref/gf180mcu_fd_io/lef/gf180mcu_fd_io__in_c.lef \
	$(PDK_PATH)/libs.ref/gf180mcu_fd_io/lef/gf180mcu_fd_io__dvdd.lef \
	$(PDK_PATH)/libs.ref/gf180mcu_fd_io/lef/gf180mcu_fd_io__dvss.lef \
	$(PDK_PATH)/libs.ref/gf180mcu_fd_io/lef/gf180mcu_fd_io__fill1.lef \
	$(PDK_PATH)/libs.ref/gf180mcu_fd_io/lef/gf180mcu_fd_io__fill5.lef \
	$(PDK_PATH)/libs.ref/gf180mcu_fd_io/lef/gf180mcu_fd_io__fill10.lef \
	gf180mcu_fd_io.tlef

export ADDITIONAL_LIBS = $(PDK_PATH)/libs.ref/gf180mcu_fd_io/lib/gf180mcu_fd_io__tt_025C_3v30.lib \
				$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lib/gf180mcu_fd_ip_sram__sram256x8m8wm1__tt_025C_3v30.lib \
				$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lib/gf180mcu_fd_ip_sram__sram512x8m8wm1__tt_025C_3v30.lib


export ADDITIONAL_GDS = $(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/gds/gf180mcu_fd_ip_sram__sram256x8m8wm1.gds \
		$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/gds/gf180mcu_fd_ip_sram__sram512x8m8wm1.gds \
		$(PDK_PATH)/libs.ref/gf180mcu_fd_io/gds/gf180mcu_fd_io.gds


