// Copyright (c) 2024 ETH Zurich and University of Bologna.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0/
//
// Authors:
// - Philippe Sauter <phsauter@iis.ee.ethz.ch>

#include "uart.h"
#include "print.h"
#include "timer.h"
#include "gpio.h"
#include "util.h"

#define DPLL_BASE_ADDR 0x20000000
#define DAC_BASE_ADDR  0x20001000

// Offsets register map of DPLL
#define DAC_BASE_OFFSET     0x1000
#define DPLL_CFG_OFFSET     0x0
#define DPLL_EXTRIM_OFFSET  0x4
#define DPLL_STATUS_OFFSET  0x8

/// @brief Example integer square root
/// @return integer square root of n

uint32_t isqrt(uint32_t n) {
    uint32_t res = 0;
    uint32_t bit = (uint32_t)1 << 30;

    while (bit > n) bit >>= 2;

    while (bit) {
        if (n >= res + bit) {
            n -= res + bit;
            res = (res >> 1) + bit;
        } else {
            res >>= 1;
        }
        bit >>= 2;
    }
    return res;
}

char receive_buff[16] = {0};

int main() {
    uart_init(); // setup the uart peripheral

    // simple printf support (only prints text and hex numbers)
    printf("Hello World!\n");
    // wait until uart has finished sending
    uart_write_flush();
    // uart loopback
    uart_loopback_enable();
    printf("internal msg\n");
    sleep_ms(1);
    for(uint8_t idx = 0; idx<15; idx++) {
        receive_buff[idx] = uart_read();
        if(receive_buff[idx] == '\n') {    
            break;
        }
    }
    uart_loopback_disable();

    printf("Loopback received: ");
    printf(receive_buff);
    uart_write_flush();
    // toggling some GPIOs
    gpio_set_direction(0xFFFF, 0x000F); // lowest four as outputs
    gpio_write(0x0A);  // ready output pattern
    gpio_enable(0xFF); // enable lowest eight
    // wait a few cycles to give GPIO signal time to propagate
    asm volatile ("nop; nop; nop; nop; nop;");
    printf("GPIO (expect 0xA0): 0x%x\n", gpio_read());

    gpio_toggle(0x0F); // toggle lower 8 GPIOs
    asm volatile ("nop; nop; nop; nop; nop;");
    printf("GPIO (expect 0x50): 0x%x\n", gpio_read());   
    uart_write_flush();

    printf("Test DPLL\n");
    uart_write_flush();
    // DPLL TEST 
    //*reg8(DPLL_BASE_ADDR,0) = 0x1A;
    *reg32(DPLL_BASE_ADDR,0) = 0x1B;
    printf("Config Write\n");
    uart_write_flush();
 	 
    uint32_t dpll_status = *reg32(DPLL_BASE_ADDR, 0); 		
    printf("DPLL Status Read: 0x%x\n", dpll_status);
    uart_write_flush();

    printf("End Test DPLL\n");
    uart_write_flush();
    
    // DAC TEST 
    printf("Test DAC\n");
    uart_write_flush();
    *reg32(DAC_BASE_ADDR,0) = 0x0A;  
    uint32_t dac_status = *reg32(DAC_BASE_ADDR, 0);    
    printf("DAC Status Read: 0x%x\n", dac_status);
    uart_write_flush();
    printf("End Test DAC\n");
    uart_write_flush(); 

    dpll_status = *reg32(DPLL_BASE_ADDR,0);
    printf("DPLL Status Read again: 0x%x\n", dpll_status);
    uart_write_flush(); 
    

    // doing some compute
    uint32_t start = get_mcycle();
    uint32_t res   = isqrt(1234567890UL);
    uint32_t end   = get_mcycle();
    printf("Result: 0x%x, Cycles: 0x%x\n", res, end - start);
    uart_write_flush();

    // using the timer
    printf("Tick\n");
    sleep_ms(10);
    printf("Tock\n");
    uart_write_flush();
    return 1;
}
