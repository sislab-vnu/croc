###################################################
# Create Routing Blockages around Macros for GF12 #
# Created by Minsoo Kim (mik226@eng.ucsd.edu)     #
###################################################
set db [::ord::get_db]
set block [[$db getChip] getBlock]
set tech [$db getTech]

set layer_M2 [$tech findLayer Metal2]
set layer_M3 [$tech findLayer Metal3]
set layer_M4 [$tech findLayer Metal4]
set layer_M5 [$tech findLayer Metal5]

set allInsts [$block getInsts]

set cnt 0

foreach inst $allInsts {
  set master [$inst getMaster]
  set name [$master getName]
  set loc_llx [lindex [$inst getLocation] 0]
  set loc_lly [lindex [$inst getLocation] 1]

  if { [string match "gf180mcu_fd_io__in*" $name] } {
    set w [$master getWidth]
    set h [$master getHeight]
      set orient [$inst getOrient]
    ## left side
    set llx_Mx [expr $loc_llx]
    set lly_Mx [expr $loc_lly]
      if { [string match "*R90" $orient] } {
    	  set urx_Mx [expr $loc_llx + $h]
    	  set ury_Mx [expr $loc_lly + $w]	  
      } else {
	  set urx_Mx [expr $loc_llx + $w]
	  set ury_Mx [expr $loc_lly + $h]
      }
      puts "in: $orient $llx_Mx $lly_Mx $urx_Mx $ury_Mx"
    set obs_M2 [odb::dbObstruction_create $block $layer_M2 $llx_Mx $lly_Mx $urx_Mx $ury_Mx]
    set obs_M3 [odb::dbObstruction_create $block $layer_M3 $llx_Mx $lly_Mx $urx_Mx $ury_Mx]
    set obs_M4 [odb::dbObstruction_create $block $layer_M4 $llx_Mx $lly_Mx $urx_Mx $ury_Mx]
    set obs_M5 [odb::dbObstruction_create $block $layer_M5 $llx_Mx $lly_Mx $urx_Mx $ury_Mx]

    incr cnt
  } elseif { [string match "gf180mcu_fd_io__bi*" $name] } {
    set w [$master getWidth]
    set h [$master getHeight]
      set orient [$inst getOrient]
      puts "bi: $orient"
    ## left side
    set llx_Mx [expr $loc_llx]
    set lly_Mx [expr $loc_lly]
    if { [string match "*R90" $orient] } {
    	set urx_Mx [expr $loc_llx + $h]
    	set ury_Mx [expr $loc_lly + $w]	  
    } else {
	set urx_Mx [expr $loc_llx + $w]
	set ury_Mx [expr $loc_lly + $h]
    }
    # if { [string compare "R0" $orient] } {
    # 	set urx_Mx [expr $loc_llx + $h]
    # 	set ury_Mx [expr $loc_lly + $w]	  
    # }
      puts "in: $orient $llx_Mx $lly_Mx $urx_Mx $ury_Mx"
    set obs_M2 [odb::dbObstruction_create $block $layer_M2 $llx_Mx $lly_Mx $urx_Mx $ury_Mx]
    set obs_M3 [odb::dbObstruction_create $block $layer_M3 $llx_Mx $lly_Mx $urx_Mx $ury_Mx]
    set obs_M4 [odb::dbObstruction_create $block $layer_M4 $llx_Mx $lly_Mx $urx_Mx $ury_Mx]
    set obs_M5 [odb::dbObstruction_create $block $layer_M5 $llx_Mx $lly_Mx $urx_Mx $ury_Mx]

    incr cnt
  }
}

if { $cnt != 0 } {
  puts "Created $cnt routing blockages over macros"
}
