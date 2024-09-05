# Copyright (c) 2022 ETH Zurich and University of Bologna.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#
# Authors:
# - Philippe Sauter <phsauter@iis.ee.ethz.ch>

# Common setup used for all yosys scripts

# list of global variables that may be used
set variables {
    vlog_files  { VLOG_FILES               ""                       }
    top_design  { TOP_DESIGN               ""                       }
    hier_depth  { HIER_DEPTH               0                        }
    period_ps   { YOSYS_TARGET_PERIOD_PS   5000                     }
    tech_cells  { YOSYS_TECH_CELLS         ""                       }
    tech_macros { YOSYS_TECH_MACROS        ""                       }
    tech_tiehi  { YOSYS_TECH_TIEHI         ""                       }
    tech_tielo  { YOSYS_TECH_TIELO         ""                       }
    proj_name   { PROJ_NAME                ""                       }
    build_dir   { BUILD                    "[set dir [pwd]]/out"    }
    work_dir    { WORK                     "[set dir [pwd]]/WORK"   }
    report_dir  { REPORTS                  "[set dir [pwd]]/report" }
    netlist     { NETLIST                  ""                       }
}

# either use env-var or default to fallback
foreach var [dict keys $variables] {  
    set values [dict get $variables $var]
    set env_var [lindex $values 0]
    set fallback [lindex $values 1]

    if {[info exists ::env($env_var)]} {
        puts "using: $var= '$::env($env_var)'"
        set $var $::env($env_var)
    } else {
        puts "using: '$var= $fallback'"
        set $var $fallback
    }
}

if {[string eq $netlist ""]} {
    set netlist ${build_dir}/${top_design}_netlist.v
}

set lib_list [concat [split $tech_cells] [split $tech_macros] ]
set liberty_args_list [lmap lib $lib_list {concat "-liberty" $lib}]
set liberty_args [concat {*}$liberty_args_list]

proc envVarValid {var_name} {
    if { [info exists ::env($var_name)]} {
	    if {$::env($var_name) != "0" && $::env($var_name) ne ""} {
            return 1
        }
    }
    return 0
}

proc processAbcScript {abc_script} {
    global work_dir lib_list
    set src_dir [file join [file dirname [info script]] ../src]
    set abc_out_path $work_dir/[file tail $abc_script]

    set raw [read -nonewline [open $abc_script r]]

    set load_liberty_cmd ""
    foreach lib $lib_list {
        append load_liberty_cmd "read_lib -w -S 20 -G 3 $lib\n"
    }
    set processed [string map -nocase [list "{LOAD_LIBERTY}" [subst $load_liberty_cmd]] $raw]
    set processed [string map -nocase [list "{REC_AIG}" [subst "$src_dir/rec6Lib_final_filtered3_recanon_basilisk.aig"]] $processed]
    set abc_out [open $abc_out_path w]
    puts -nonewline $abc_out $processed

    flush $abc_out
    close $abc_out
    return $abc_out_path
}