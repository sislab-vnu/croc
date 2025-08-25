croc_culp:
	make -f ../OpenROAD-flow-scripts/flow/Makefile DESIGN_CONFIG=config.mk
gui_6_1_fill:
	make -f ../OpenROAD-flow-scripts/flow/Makefile DESIGN_CONFIG=config.mk $@
gui_2_1_floorplan:
	make -f ../OpenROAD-flow-scripts/flow/Makefile DESIGN_CONFIG=config.mk $@
gui_2_2_floorplan_macro:
	make -f ../OpenROAD-flow-scripts/flow/Makefile DESIGN_CONFIG=config.mk $@
gui_2_3_floorplan_tapcell:
	make -f ../OpenROAD-flow-scripts/flow/Makefile DESIGN_CONFIG=config.mk $@
gui_2_4_floorplan_pdn:
	make -f ../OpenROAD-flow-scripts/flow/Makefile DESIGN_CONFIG=config.mk $@
clean:
	-rm -rf logs results reports objects
.PHONY: clean croc_culp croc_culp-gui
