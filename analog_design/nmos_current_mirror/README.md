# NMOS Current Mirror in Cadence Virtuoso

Simulation of an NMOS current mirror with $W/L=10\,\mu\text{m}/1\,\mu\text{m}$ and a $100\,\mu\text{A}$ reference current. The full report, with theory and figures, is in `NMOS_Current_Mirror_Report.pdf`.

## Main results

| Item | Value |
|---|---|
| Gate voltage (set by the diode-connected transistor) | $724.756\,\text{mV}$ |
| Output current at $V_{DS}=0.9\,\text{V}$ | $100.6384\,\mu\text{A}$ ($+0.64\,\%$) |
| Output current at $V_{DS}=724.756\,\text{mV}$ | $99.99966\,\mu\text{A}$ ($-0.0003\,\%$) |
| Output current at $V_{DS}=300\,\text{mV}$ | $95.70051\,\mu\text{A}$ ($-4.30\,\%$) |
| Saturation reached | $0.3\,\text{V}$ (triode up to $0.2\,\text{V}$) |
| Output resistance $r_{out}$ (low frequency) | $301.753\,\text{k}\Omega$ |

## Key observations

- The gate voltage is below $0.9\,\text{V}$ because the current source forces $100\,\mu\text{A}$ through the diode-connected transistor.
- The copy is almost exact when the output voltage equals the gate voltage, and it rises slowly with output voltage after that (about $+3\,\%$ at $1.8\,\text{V}$).
- The output transistor is in saturation from $0.3\,\text{V}$, but the current is still $4.3\,\%$ low there.
- The output resistance is flat at low frequency and falls above a few megahertz.

Values described as "about" are read from plots and are approximate.

## Repository structure

```text
nmos_current_mirror/
├── README.md
├── NMOS_Current_Mirror_Report.pdf
├── data/
│   └── simulation_measurements.csv
└── images/
```
