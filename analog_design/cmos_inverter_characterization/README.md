# CMOS Inverter Characterization in Cadence Virtuoso

Simulation of a static CMOS inverter at $V_{DD}=1.8\,\text{V}$ with $W_n=2\,\mu\text{m}$ and the PMOS width tuned for a switching threshold of $V_{DD}/2$. The full report, with theory and figures, is in `CMOS_Inverter_Characterization_Report.pdf`.

## Main results

| Item | Value |
|---|---|
| Initial sizing ($W_n$ / $W_p$) | $2\,\mu\text{m}$ / $2\,\mu\text{m}$ |
| Initial switching threshold $V_M$ | $\approx0.747\,\text{V}$ |
| Selected PMOS width $W_p$ | $7.44384\,\mu\text{m}$ ($W_p/W_n=3.72192$) |
| Switching threshold after resizing | $0.9\,\text{V}=V_{DD}/2$ |
| $t_{PHL}$ / $t_{PLH}$ | $30.6286\,\text{ps}$ / $24.24555\,\text{ps}$ |
| Delay difference / average delay | $6.383\,\text{ps}$ / $27.44\,\text{ps}$ |
| Rise time $t_r$ / fall time $t_f$ (10%-90%) | $37.1943\,\text{ps}$ / $31.1168\,\text{ps}$ |
| $V_{IL}$ / $V_{IH}$ ($dV_{out}/dV_{in}=-1$) | $0.7795\,\text{V}$ / $1.0356\,\text{V}$ |
| $NM_L$ / $NM_H$ (rail-level outputs) | $\approx0.78\,\text{V}$ / $\approx0.76\,\text{V}$ |
| $NM_L$ / $NM_H$ (outputs at the $-1$ slope points) | $\approx0.70\,\text{V}$ / $\approx0.63\,\text{V}$ |
| Static power ($V_{DD}\times$ average leakage $12.045\,\text{pA}$) | $21.68\,\text{pW}$ |
| Dynamic power ($V_{DD}\times1.7571\,\mu\text{A}$) | $3.163\,\mu\text{W}$ |
| $V_M$ over 5 corners, $-40$ to $120\,^{\circ}\text{C}$ | $\approx0.78\,\text{V}$ to $\approx1.05\,\text{V}$ |

## Key observations

- With equal widths the inverter switches at about $0.747\,\text{V}$, below $V_{DD}/2$.
- Increasing the PMOS width moves the switching threshold to higher input voltages.
- $W_p=7.44384\,\mu\text{m}$ places the switching threshold at $0.9\,\text{V}$.
- Delays would be equal near $W_p=5.66886\,\mu\text{m}$, but that moves the threshold away from $V_{DD}/2$, so $7.44384\,\mu\text{m}$ was kept.
- Power is almost entirely dynamic; the static part is about six orders of magnitude smaller.
- Across corners and temperature the delays change by up to about a factor of two. The skewed FS and SF corners move the switching threshold the most.

The noise-margin output levels are read from plots, so those margins and the corner ranges are approximate.

## Repository structure

```text
cmos_inverter_characterization/
├── README.md
├── CMOS_Inverter_Characterization_Report.pdf
├── data/
│   └── simulation_measurements.csv
└── images/
```
