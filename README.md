# APB 2 SLAVE

APB is low bandwidth and low performance bus. So, the components requiring lower bandwidth like the peripheral devices such as UART, Keypad, Timer and PIO (Peripheral Input Output) devices are connected to the APB. The bridge connects the high performance AHB or ASB bus to the APB bus. So, for APB the bridge acts as the master and all the devices connected on the APB bus acts as the slave.

## Design specification

##  APB Protocol Design Overview

###  Master-Slave Architecture
- Single APB master controlled via external signals.
- Two APB slave devices are connected to the bus.
- Master selects one slave at a time based on the **9th bit (bit 8)** of the `PADDR`.

###  Slave Selection Logic
- `PADDR[8] = 0` → Slave 1 is selected.
- `PADDR[8] = 1` → Slave 2 is selected.

###  Transfer Control
- APB is **enabled only when `transfer` signal is high**.
- When `transfer = 0`, the APB bus remains **inactive**.

###  Clocking
- All data is **captured on the rising edge** of the clock.

###  Bus Specifications
- **Data Width:** 8 bits
- **Address Width:** 9 bits

###  Operation Modes
- `PWRITE = 1` → Write operation: `PWDATA` is sent to the selected slave.
- `PWRITE = 0` → Read operation: `PRDATA` is read from the selected slave.


## Apb interface block diagram

![Screenshot 2025-04-21 123800](https://github.com/user-attachments/assets/fe7c0b51-af88-4692-869a-fac893e97a54)

## State diagram

<img src="https://github.com/user-attachments/assets/4e60309a-6302-41dc-bb93-4565e0a456ab" width="400">

## Testbench architecture

![Apb_2_slave drawio (1) drawio](https://github.com/user-attachments/assets/4e60309a-6302-41dc-bb93-4565e0a456ab)


