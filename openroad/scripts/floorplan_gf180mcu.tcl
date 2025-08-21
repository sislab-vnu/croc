# Copyright 2023 ETH Zurich and University of Bologna.
# Solderpad Hardware License, Version 0.51, see LICENSE for details.
# SPDX-License-Identifier: SHL-0.51

# Authors:
# - Tobias Senti <tsenti@ethz.ch>
# - Jannis Schönleber <janniss@iis.ee.ethz.ch>
# - Philippe Sauter   <phsauter@iis.ee.ethz.ch>

source scripts/floorplan_util.tcl

##########################################################################
# Reset (mark everything as unplaced)
##########################################################################

set block [ord::get_db_block]
set insts [odb::dbBlock_getInsts $block]
foreach inst $insts {
  set master [[$inst getMaster] getName]
  # delete IO filler and unplace the rest
  if {[lsearch -exact $iofill $master] != -1 || $master eq $iocorner} {
    odb::dbInst_destroy $inst
    continue
  } else {
    odb::dbInst_setPlacementStatus $inst "none"
  }
}

##########################################################################
# Pads/IOs 
##########################################################################
utl::report "Create Padring"
source src/padring_${TECHNO}.tcl


##########################################################################
# RAM sizes
##########################################################################
set RamMaster256x8   [[ord::get_db] findMaster "gf180mcu_fd_ip_sram__sram256x8m8wm1"]
set RamSize256x8_W   [ord::dbu_to_microns [$RamMaster256x8 getWidth]]
set RamSize256x8_H   [ord::dbu_to_microns [$RamMaster256x8 getHeight]]


##########################################################################
# Chip and Core Area
##########################################################################
# core gets snapped to site-grid -> get real values
set coreArea      [ord::get_core_area]
set core_leftX    [lindex $coreArea 0]
set core_bottomY  [lindex $coreArea 1]
set core_rightX   [lindex $coreArea 2]
set core_topY     [lindex $coreArea 3]


##########################################################################
# Tracks 
##########################################################################
# We need to define the metal tracks 
# (where the wires on each metal should go)
# this function is defined in init_tech.tcl
makeTracks

# the height of a standard cell, useful to align things
set siteHeight        [ord::dbu_to_microns [[dpl::get_row_site] getHeight]]


##########################################################################
# Paths to the instances of macros
##########################################################################
utl::report "Macro Names"
source src/instances_${TECHNO}.tcl

##########################################################################
# Placing 
##########################################################################
# use these for macro placement
set floorPaddingX      80.0
set floorPaddingY      100.0
set floor_leftX       [expr $core_leftX + $floorPaddingX]
set floor_bottomY     [expr $core_bottomY + $floorPaddingY]
set floor_rightX      [expr $core_rightX - $floorPaddingX]
set floor_topY        [expr $core_topY - $floorPaddingY]
set floor_midpointX   [expr $floor_leftX + ($floor_rightX - $floor_leftX)/2]
set floor_midpointY   [expr $floor_bottomY + ($floor_topY - $floor_bottomY)/2]
set floorSpacing 80.0

utl::report "Place Macros"

# Bank0
set X [expr $floor_midpointX - ($RamSize256x8_W*2) - ($floorPaddingX*1.5)]
set Y [expr $floor_topY - $RamSize256x8_H]
placeInstance $bank0_sram0 $X $Y R0
set X [expr $floor_midpointX - $RamSize256x8_W - ($floorPaddingX*0.5)]
placeInstance $bank0_sram1 $X $Y R0
set X [expr $floor_midpointX + ($floorPaddingX*0.5)]
placeInstance $bank0_sram2 $X $Y R0
set X [expr $floor_midpointX + $RamSize256x8_W + ($floorPaddingX*1.5)]
placeInstance $bank0_sram3 $X $Y R0

# Bank1
set Y [expr $floor_topY - ($RamSize256x8_H*2)  - ($floorPaddingY*10)]
set X [expr $floor_midpointX - ($RamSize256x8_W*2) - ($floorPaddingX*1.5)]
placeInstance $bank1_sram0 $X $Y R180

set X [expr $floor_midpointX - $RamSize256x8_W - ($floorPaddingX*0.5)]
placeInstance $bank1_sram1 $X $Y R180

set X [expr $floor_midpointX + ($floorPaddingX*0.5)]
placeInstance $bank1_sram2 $X $Y R180

set X [expr $floor_midpointX + $RamSize256x8_W + ($floorPaddingX*1.5)]
placeInstance $bank1_sram3 $X $Y R180

cut_rows -halo_width_x 2 -halo_width_y 1
