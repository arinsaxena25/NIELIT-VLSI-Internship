# NMOS Transistor Characterization in Cadence Virtuoso

DC simulation of a single NMOS transistor: output and transfer characteristics, transconductance, output resistance and body effect. The full report, with theory and figures, is in `NMOS_Characterization_Report.pdf`.

## Main results

Bias point: $V_{GS}=V_{DS}=0.9\,\text{V}$, $V_{BS}=0\,\text{V}$, $I_D=247.222\,\mu\text{A}$.

| Quantity | Graphical | Operating point | Difference |
|---|---|---|---|
| $g_m$ | $906.95\,\mu\text{S}$ | $918.161\,\mu\text{S}$ | $1.22\,\%$ |
| $r_o$ | $25.7815\,\text{k}\Omega$ | $26.1685\,\text{k}\Omega$ | $1.48\,\%$ |
| $g_{mb}$ | $271.5\,\mu\text{S}$ | $276.672\,\mu\text{S}$ | $1.87\,\%$ |

From the operating-point values: $g_m/I_D\approx3.71\,\text{V}^{-1}$, intrinsic gain $g_m r_o\approx24.0$, $g_{mb}/g_m\approx0.30$.

## Key observations

- The device is off at $V_{GS}=0$ and $0.45\,\text{V}$ and conducts at $0.9$, $1.35$ and $1.8\,\text{V}$.
- $g_m$ peaks at roughly $0.99\,\text{mS}$ near $V_{GS}\approx1.3\,\text{V}$ and then falls slightly.
- $r_o$ increases with $V_{DS}$, reaching roughly $35\,\text{k}\Omega$ at $1.8\,\text{V}$.
- Sweeping $V_{BS}$ from $-1\,\text{V}$ to $1\,\text{V}$ changes $I_D$ from about $65\,\mu\text{A}$ to about $373\,\mu\text{A}$.

Values described as "roughly" or "about" are read from plots and are approximate.

## Repository structure

```text
nmos_characterization/
├── README.md
├── NMOS_Characterization_Report.pdf
├── data/
│   └── simulation_measurements.csv
└── images/
```
