# Assignment 9: Integrated Sequential and Datapath Designs

This assignment brings together reusable sequential and combinational building blocks.

## Contents

- **Q1:** A 4-bit universal shift register with hold, bidirectional serial shifting, and parallel-load modes.
- **Q2:** An 8-bit ALU supporting arithmetic, bitwise, NOR, and shift operations, with carry and zero flags.
- **Q3:** A finite-state machine that detects the serial sequence `10110`.

The sequence detector uses an active-high asynchronous reset and asserts `detected` when the matching state is reached. Each question includes RTL under `src/` and a testbench under `tb/`.
