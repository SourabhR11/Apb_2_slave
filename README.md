# APB 2 SLAVE

APB is low bandwidth and low performance bus. So, the components requiring lower bandwidth like the peripheral devices such as UART, Keypad, Timer and PIO (Peripheral Input Output) devices are connected to the APB. The bridge connects the high performance AHB or ASB bus to the APB bus. So, for APB the bridge acts as the master and all the devices connected on the APB bus acts as the slave.

## Design specification

The design consists of a single APB master controlled by external signals, communicating with two connected slaves. The master selects one slave at a time based on the least significant bit of the paddress. The APB is enabled only when the transfer signal is high; otherwise, it remains disabled.
1.Parallel bus operation. All the data will be captured at rising edge clock.
2.Two slave design based on 9th bit of apb_write_paddress bit it will elect the slave1 and slave2.
3.Signal priority: 1.PRESET (active low) 2. PSEL (active high) 3. PENABLE (active high) 4. PREADY (active high) 5. PWRITE
4.Data width 8 bit and address width 9 bit.
5.PWRITE=1 indicates write PWDATA to slave. PWRITE=0 indicates read PRDATA from slave.

## Apb interface block diagram

![Screenshot 2025-04-21 123800](https://github.com/user-attachments/assets/fe7c0b51-af88-4692-869a-fac893e97a54)

## State diagram

![Screenshot 2025-04-22 100310](https://github.com/user-attachments/assets/9cd5e536-5a46-4da8-8e8e-c754046afd2a)

## Testbench architecture

![Apb_2_slave drawio (1) drawio](https://github.com/user-attachments/assets/4e60309a-6302-41dc-bb93-4565e0a456ab)


