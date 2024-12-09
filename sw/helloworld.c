// Copyright (c) 2024 ETH Zurich and University of Bologna.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0/
//
// Authors:
// - Philippe Sauter <phsauter@iis.ee.ethz.ch>
/*
#include "uart.h"
#include "print.h"
#include "gpio.h"
#include "util.h"

#define TB_FREQUENCY 10000000
#define TB_BAUDRATE    115200

int main() {
    uart_init();

    printf("He%xo World!\n", 0x11);
    uart_write_flush();
    *reg8(GPIO_BASE_ADDR, GPIO_DIR_REG_OFFSET) = 0x0F; // lowest four as outputs
    *reg8(GPIO_BASE_ADDR, GPIO_OUT_REG_OFFSET) = 0x0A; // ready output pattern
    *reg8(GPIO_BASE_ADDR, GPIO_EN_REG_OFFSET) = 0xFF;  // enable lowest eight
    printf("GPIO (expect 0xA0): %x\n", *reg8(GPIO_BASE_ADDR, GPIO_IN_REG_OFFSET));
    *reg8(GPIO_BASE_ADDR, GPIO_TOGGLE_REG_OFFSET) = 0x0F;
    printf("GPIO (expect 0x50): %x\n", *reg8(GPIO_BASE_ADDR, GPIO_IN_REG_OFFSET));
    return 1;
}*/

#include "uart.h"
#include "print.h"
#include "util.h"
#include "config.h"


/*
int my_strlen(const char *str) {
    int len = 0;
    while(*str++) len++;
    return len;
}*/

int main() {
  // Initialize the UART
  
  uart_init();
  *reg8(UART_BASE_ADDR, UART_INTR_ENABLE_REG_OFFSET) = 0x0F;

  //-----Send a greeting message---------------------------------------------
  //printf("Hello! %x\n", 123);

  //-----Write-UART-Test-----------------------------------------------------
  /*uart_write_flush(); // Ensure all bytes are transmitted

  uart_write(0x41);
  uart_write(0x42);
  uart_write(0x43);
  uart_write(0x44);
  uart_write(10);
  uart_write(13);
  uart_write_flush();*/
  
  //-----Read-UART-Test------------------------------------------------------

  uart_write_flush();
  
  uint8_t received = 1;
  uint8_t echo;

  while(1) {

    if (uart_read_ready()) {
      received = uart_read();
      echo     = received + 1;
      if (received != 127) {
        putchar(echo);
      } else {
        putchar(received);
      }
    }

    uart_write_flush();

    if (received == 10) {
      break;
    }
  }

  uart_write(10);
  uart_write(13);
  uart_write_flush();
 
  return 1;
}
