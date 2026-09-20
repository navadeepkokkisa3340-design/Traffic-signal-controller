# Traffic Signal Controller using Verilog

## Overview

This project implements a **VLSI-based Traffic Signal Controller** using **Verilog HDL**.

The controller manages traffic signals for two directions:

- East-West (EW)
- North-South (NS)

The design uses a **Finite State Machine (FSM)** to control the traffic lights. It also supports **emergency vehicle priority** and **vehicle density-based traffic control**.

## Features

- FSM-based traffic signal control
- East-West and North-South traffic management
- Emergency vehicle priority
- Vehicle density detection
- Density-based traffic control
- Pedestrian signal control
- Verilog HDL implementation
- Behavioral simulation using Xilinx Vivado

## System Inputs

| Input | Description |
|---|---|
| `clk` | System clock |
| `rst` | Reset signal |
| `emer_ew` | Emergency vehicle on East-West road |
| `emer_ns` | Emergency vehicle on North-South road |
| `density_ew[3:0]` | Vehicle density on East-West road |
| `density_ns[3:0]` | Vehicle density on North-South road |

The density inputs are 4-bit values, giving a range of:

```text
0 to 15
