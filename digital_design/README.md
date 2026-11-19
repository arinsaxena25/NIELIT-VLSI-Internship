# Digital Design

This folder contains Verilog RTL and simulation work completed during the
digital-design portion of the NIELIT VLSI internship. The exercises progress
from basic combinational circuits to sequential logic, finite-state machines,
datapath components, and an integrated control-system project.

## Contents

| Folder | Topics covered |
|---|---|
| [Assignment 1](Assignment%201/) | Basic logic gates and 2-to-1 multiplexers using multiple Verilog modeling styles |
| [Assignment 2](Assignment%202/) | Binary encoder, magnitude comparator, and binary-to-Gray-code converter |
| [Assignment 3](Assignment%203/) | BCD-to-Excess-3 conversion and seven-segment display decoding |
| [Assignment 4](Assignment%204/) | 4-bit up/down counters with asynchronous and synchronous reset |
| [Assignment 5](Assignment%205/) | Multiplexer, comparator, D flip-flop, and asynchronous-reset counter |
| [Assignment 6](Assignment%206/) | Mealy and Moore FSM sequence detectors for `1001` |
| [Assignment 7](Assignment%207/) | Universal shift register and 8-bit ALU |
| [Assignment 8](Assignment%208/) | Enhanced shift-register and ALU designs with status outputs |
| [Assignment 9](Assignment%209/) | Integrated shift register, ALU, and `10110` sequence detector |
| [Railway Crossing Controller](railway_crossing_controller/) | Synchronous FSM for gate control, road signals, warning alarm, and train sensors |

## Repository Structure

Most assignments are organized by question:

```text
Assignment N/
├── Q1/
│   ├── src/   # Verilog RTL
│   └── tb/    # Testbench and simulation stimulus
└── README.md
```

The railway-crossing project follows a project-level structure:

```text
railway_crossing_controller/
├── src/       # Controller RTL
├── tb/        # Controller testbench
└── README.md
```

## Skills Practiced

- Combinational and sequential circuit design
- Dataflow, structural, and behavioral Verilog modeling
- Synchronous and asynchronous reset handling
- Counters, registers, multiplexers, comparators, and ALUs
- Mealy and Moore finite-state-machine design
- Self-checking and waveform-based simulation
- RTL organization for synthesis and verification

Each assignment has its own README with the detailed design description,
module behavior, and verification notes. The
[Railway Crossing Controller README](railway_crossing_controller/README.md)
also includes project-specific simulation and synthesis guidance.

## Running Simulations

The testbenches are written for standard Verilog simulators. For example, from
an assignment question directory containing `src/` and `tb/`:

```bash
iverilog -o simulation src/<design>.v tb/<testbench>.v
vvp simulation
```

Refer to the README inside the relevant assignment for the exact module and
testbench filenames.
