exclude_io_pin_region -region left:* -region right:*
set_io_pin_constraint -pin_names {reset enable dco ext_trim* trim* } -region top:*
set_io_pin_constraint -pin_names { clockp*  } -region bottom:*

