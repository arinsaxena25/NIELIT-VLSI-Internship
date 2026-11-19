# NMOS Common-Source Amplifier with PMOS Current-Mirror Load in Cadence Virtuoso

Design and simulation of a single-stage NMOS common-source amplifier with an active PMOS current-mirror load at $V_{DD}=1.8\,\text{V}$ and $I_{REF}=10\,\mu\text{A}$.

## Design

| Item | Value |
|---|---|
| NM0 (input) | $W/L=1\,\mu\text{m}/500\,\text{nm}$ |
| PM1, PM0 (mirror load) | $W/L=8\,\mu\text{m}/500\,\text{nm}$ each |
| Gate bias | $635.5\,\text{mV}$ |
| Output DC voltage | $945.652\,\text{mV}$ (all transistors in saturation) |

## Main results

| Quantity | Value |
|---|---|
| Low-frequency gain | $36.1566\,\text{dB}$ ($64.24$ V/V) |
| $-3\,\text{dB}$ bandwidth | $253.817\,\text{kHz}$ |
| Unity-gain bandwidth | $16.3595\,\text{MHz}$ |
| Phase margin | $89.1172^{\circ}$ |
| Transient gain ($10\,\text{mV}_{pp}$, $1\,\text{kHz}$) | $62.5057$ V/V ($35.9184\,\text{dB}$) |
| Output swing (transient) | $624.899\,\text{mV}_{pp}$ |
| Integrated output / input-referred noise | 14.07 mV<sub>rms</sub> / 301.80 &micro;V<sub>rms</sub> |
| SNR at $10\,\text{mV}_{pp}$ input | $21.38\,\text{dB}$ |

Poles and zeros: dominant pole at $254.32\,\text{kHz}$, mirror pole and zero at $273.53\,\text{MHz}$ and $272.78\,\text{MHz}$ (self-cancelling), RHP zero at $45.37\,\text{GHz}$.

## Key observations

- Bandwidth and unity-gain bandwidth agree with the hand calculation to within about $1.7\,\%$, and the response is single-pole with a phase margin of about $90^{\circ}$.
- NM0 flicker noise is $98.99\,\%$ of the total noise.
- The output is a clean inverted sine wave with no clipping.

## Repository structure

```text
nmos_cs_cmplifier/
├── README.md
├── data/
│   └── simulation_measurements.csv
└── images/
```
