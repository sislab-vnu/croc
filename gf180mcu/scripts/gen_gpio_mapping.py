#!/usr/bin/env python3

def gen(start, length):
    template = """
   gf180mcu_fd_io__bi_24t pad_gpio{GPIO_ID}_io (.PAD({PADNAME}), .A({CORE2PAD}), .Y({PAD2CORE}), .OE({CORE2PAD_EN}), 
					    .CS(1'b0), .SL(1'b0), .IE(~{CORE2PAD_EN}), .PU(1'b0), 
					    .PD(1'b1));
    """
    for i in range(start, length):
        id_str = str(i)
        padname = "gpio%d_io" % i
        core2pad = "soc_gpio_o[%d]" % i
        core2pad_en = "soc_gpio_out_en_o[%d]" %i
        pad2core = "soc_gpio_i[%d]" %i
        a = template.format(GPIO_ID=id_str, PADNAME=padname,
                            CORE2PAD=core2pad,
                            CORE2PAD_EN=core2pad_en,
                            PAD2CORE=pad2core)
        print(a)
if __name__ == "__main__":
    gen(0, 32)
