# APB 2 SLAVE


##  About APB Protocol 

- **AMBA APB** (Advanced Peripheral Bus) is part of ARM's AMBA bus family.
- It is a **low-power, low-complexity** interface used for connecting **peripherals**.

###  Bus Characteristics
- **Synchronous** with the system clock.
- **Non-pipelined** and **non-bursting** protocol.
- **Simple read/write access**—ideal for slow peripherals.

###  Signal Overview
| Signal      | Description                           |
|-------------|---------------------------------------|
| `PCLK`      | APB clock                             |
| `PRESETn`   | Active-low reset                      |
| `PADDR`     | Address bus                           |
| `PWDATA`    | Write data                            |
| `PRDATA`    | Read data                             |
| `PWRITE`    | Transfer direction (1 = Write, 0 = Read) |
| `PSEL`      | Slave select                          |
| `PENABLE`   | Transfer phase indicator              |
| `PREADY`    | Slave ready for next transfer         |
| `PSLVERR`   | Optional error indication             |

###  Transfer Phases
1. **Setup Phase**:  
   - `PADDR`, `PWRITE`, `PWDATA`, and `PSEL` are asserted.
   - `PENABLE = 0`
2. **Enable Phase**:  
   - `PENABLE = 1`  
   - Transfer occurs when `PREADY = 1`.

###  Features
- Designed for **low bandwidth** communication.
- Ensures **low power consumption**.
- Simple interface ideal for **peripherals like UART, GPIO, timers**.

###  Common Use Cases
- Connecting **UART**, **SPI**, **I2C**, **GPIO**, **Timers** to the system bus.


## Design specification

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

<img src="https://github.com/user-attachments/assets/fe7c0b51-af88-4692-869a-fac893e97a54" width="400">


## State diagram
<img src="https://github.com/user-attachments/assets/6ca2fc10-85aa-4102-9f9a-54c7a31b788c" width="400">


## Testbench architecture

<img src="https://github.com/user-attachments/assets/4e60309a-6302-41dc-bb93-4565e0a456ab" width="400">


