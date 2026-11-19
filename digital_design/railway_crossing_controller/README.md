# Railway Crossing Controller

## Overview

The Railway Crossing Controller is a synchronous digital control system for managing the interaction between railway traffic and road traffic at a level crossing. It monitors train approach and departure signals, controls the gate movement, changes the road-traffic signal, and activates a warning alarm while it is unsafe for vehicles to cross.

The design is implemented as a finite-state machine (FSM) in synthesizable Verilog. Separating state transitions from output decoding makes the controller straightforward to simulate, synthesize, and extend with physical sensors, motors, LEDs, buzzers, or a larger timing circuit.

## Main Features

- Four-state finite-state-machine controller.
- Synchronous, active-high reset.
- Parameterized gate movement timer.
- Train-arrival and train-departure input signals.
- Gate status output for open, closing, closed, and opening conditions.
- Red/green road signal output.
- Warning alarm output during train approach and passage.
- Dedicated testbench for functional simulation.

## System Interface

| Signal | Direction | Width | Description |
|---|---|---:|---|
| `clk` | Input | 1 | System clock. State and timer updates occur on its rising edge. |
| `rst` | Input | 1 | Synchronous active-high reset. Returns the controller to `IDLE`. |
| `train_arrival` | Input | 1 | Indicates that a train is approaching the crossing. |
| `train_departure` | Input | 1 | Indicates that the train has cleared the crossing. |
| `gate_status` | Output | 2 | Encodes the current gate movement state. |
| `road_signal` | Output | 1 | `0` indicates green; `1` indicates red. |
| `warning_alarm` | Output | 1 | `1` turns the crossing warning alarm on. |

The module also provides the parameter `GATE_TIMER_MAX`, which defaults to `4`. It controls how long the gate remains in the closing or opening state before the FSM advances.

## State Machine

The controller uses the following state encoding:

| State | Encoding | Gate status | Road signal | Warning alarm |
|---|---:|---|---|---|
| `IDLE` | `00` | Open | Green | Off |
| `GATE_CLOSING` | `01` | Closing | Red | On |
| `TRAIN_PASSING` | `10` | Closed | Red | On |
| `GATE_OPENING` | `11` | Opening | Red | Off |

### State transitions

1. **IDLE → GATE_CLOSING**  
   When `train_arrival` is asserted, the controller starts closing the gate and immediately protects the road side with a red signal and warning alarm.

2. **GATE_CLOSING → TRAIN_PASSING**  
   After the internal timer reaches `GATE_TIMER_MAX`, the gate is considered closed and the controller allows the train-passing phase.

3. **TRAIN_PASSING → GATE_OPENING**  
   When `train_departure` is asserted, the controller begins opening the gate. The road signal remains red while the gate is moving.

4. **GATE_OPENING → IDLE**  
   Once the opening timer reaches `GATE_TIMER_MAX`, the gate is considered open and normal road traffic is permitted again.

5. **GATE_OPENING → GATE_CLOSING**  
   If another train arrival is detected while the gate is opening, the controller immediately starts a new closing cycle.

Any unrecognized state returns to `IDLE` through the default transition.

## Timing and Reset Behavior

The state register and movement timer are updated in the clocked `always` block. Reset is synchronous, so asserting `rst` changes the state and clears the timer on the next rising edge of `clk`.

The timer is active only during `GATE_CLOSING` and `GATE_OPENING`. It is cleared whenever the controller is in `IDLE` or `TRAIN_PASSING`, and it is restarted when the FSM enters a new gate-movement state. This prevents elapsed gate-movement time from carrying over between cycles.

## Design Structure

The implementation uses three logical sections:

1. **Sequential state and timer logic**  
   Stores the current state and updates the timer on each rising clock edge.
2. **Next-state combinational logic**  
   Examines the current state, timer, and train inputs to determine the next state.
3. **Output decoding logic**  
   Generates `gate_status`, `road_signal`, and `warning_alarm` from the current state.

This structure follows the conventional two-process FSM approach while keeping the timer in the sequential section.

## Safety-Oriented Behavior

The controller defaults to a protected condition outside `IDLE`: the road signal is red, and the gate-related states prevent normal road traffic during train movement. The `TRAIN_PASSING` state does not open the gate until `train_departure` is received. A new arrival detected during opening takes priority over completion of the opening timer and starts another closing cycle.

This RTL is a functional controller model. A deployment-ready railway system would additionally require redundant sensing, fault detection, watchdog behavior, fail-safe outputs, actuator feedback, and formal or hardware-level safety certification.

## Verification

The testbench in `tb/tb_railway_controller.v` can be used to exercise:

- Reset and initial idle behavior.
- Train arrival and transition into gate closing.
- Timer-based transition into train passing.
- Train departure and gate opening.
- Timer-based return to idle.
- A new train arrival during gate opening.
- Output values associated with each controller state.

Waveforms can be inspected with a Verilog simulator and GTKWave. The default timer value is intentionally small for simulation; it can be increased through the module parameter for a different clock-to-gate timing model.

## Project Files

```text
railway_crossing_controller/
├── src/
│   └── railway_controller.v
├── tb/
│   └── tb_railway_controller.v
└── README.md
```

## Running a Simulation

From this directory, compile the RTL and testbench with Icarus Verilog:

```bash
iverilog -o railway_controller_sim src/railway_controller.v tb/tb_railway_controller.v
vvp railway_controller_sim
```

To generate a waveform, add a `$dumpfile` and `$dumpvars` call to the testbench if they are not already present, then run:

```bash
gtkwave railway_controller.vcd
```

### VCS-based simulation

```bash
vcs -o Output/railway_controller.out \
    ../RTL/Design/railway_controller.v \
    ../RTL/TB/tb_railway.v
cd Output
./railway_controller.out
cd ..
gtkwave VCD/railway_controller.vcd
```

The testbench must generate `VCD/railway_controller.vcd` before it can be opened with GTKWave. These commands use the original `RTL/Design`, `RTL/TB`, `Output`, and `VCD` directory structure; paths and filenames must be modified before using them with this repository.

## Code and Functional Coverage

VCS coverage commands:

```bash
vcs -cm line+tgl+branch+cond+fsm \
    -o Output/railway_controller.out \
    ../RTL/Design/railway_controller.v \
    ../RTL/TB/tb_railway.v
cd Output
./railway_controller.out \
    -cm line+tgl+branch+cond+fsm
cd ..
urg -dir Output/railway_controller.out.vdb/ \
    -report Coverage/
```

The generated reports are written to `Coverage/`. These commands assume the original directory structure and must be modified for this repository. The coverage run should exercise reset, train arrival, gate closing, train passage, train departure, gate opening, timer expiry, and a new arrival while the gate is opening.

## Synthesis Constraints

The following SDC was used for the original controller:

```tcl
create_clock -name clk -period 10 [get_ports clk]

set_input_delay 1.0 -clock clk \
    [get_ports {rst train_arrival train_departure}]

set_output_delay 1.0 -clock clk \
    [get_ports {gate_status road_signal warning_alarm}]

set_false_path -from [get_ports rst]
```

The input and output delay constraints model the timing relationship between the controller and external circuitry. Reset is excluded from normal timing analysis because it is a control input rather than a synchronous data-path signal.

## Design Compiler Synthesis

Synthesis script:

```tcl
source /home/int-07/Desktop/arin/Scripts/dc_setup.tcl

set TOP railway_controller

read_verilog /home/int-07/Desktop/arin/RTL/Design/${TOP}.v
current_design ${TOP}
link

source /home/int-07/Desktop/arin/Synthesis/Constraints/${TOP}.sdc

check_design
compile_ultra

report_qor   > /home/int-07/Desktop/arin/Synthesis/Reports/${TOP}_qor.rpt
report_area  > /home/int-07/Desktop/arin/Synthesis/Reports/${TOP}_area.rpt
report_timing > /home/int-07/Desktop/arin/Synthesis/Reports/${TOP}_timing.rpt
report_power > /home/int-07/Desktop/arin/Synthesis/Reports/${TOP}_power.rpt

write -format verilog -hierarchy \
    -output /home/int-07/Desktop/arin/Synthesis/Netlist/${TOP}_synth_netlist.v
write_sdc /home/int-07/Desktop/arin/Synthesis/Netlist/${TOP}_output.sdc

write_file -format ddc -hierarchy \
    -output /home/int-07/Desktop/arin/Synthesis/Backup/${TOP}.ddc
```

The synthesis shell commands are:

```text
dc_shell
source synth.tcl
gui_show
```

These commands assume the original `RTL/Design`, `Synthesis`, `Scripts`, and report directories, and the SDC port names must match the RTL being synthesized. Modify the paths, filenames, and port names before using this flow with the repository's `src/railway_controller.v`.

The synthesis reports provide quality-of-results, area, timing, and power information. The generated Verilog netlist, output SDC, and DDC database are saved separately so that the synthesized implementation can be inspected or used in downstream verification.

The design can also be opened in Vivado by adding `src/railway_controller.v` as a design source and `tb/tb_railway_controller.v` as a simulation source.

## Implementation Files

- [railway_controller.v](src/railway_controller.v): FSM, timer, and output logic.
- [tb_railway_controller.v](tb/tb_railway_controller.v): Simulation stimulus and functional checks.
