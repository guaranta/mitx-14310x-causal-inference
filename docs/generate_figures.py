"""Generate README figures for causal inference demos."""

from pathlib import Path
import matplotlib.pyplot as plt
import numpy as np
from scipy import stats

OUT = Path(__file__).resolve().parent / "figures"
OUT.mkdir(exist_ok=True)
rng = np.random.default_rng(42)

# OLS
x = rng.normal(10, 2, 200)
y = 2.5 + 1.8 * x + rng.normal(0, 3, 200)
slope, intercept, r, p, se = stats.linregress(x, y)
fig, ax = plt.subplots(figsize=(7, 4))
ax.scatter(x, y, alpha=0.4, s=15, color="#6366f1")
ax.plot(x, intercept + slope * x, color="#ef4444", lw=2, label=f"β₁={slope:.2f}, p={p:.2e}")
ax.set_xlabel("Education (years)")
ax.set_ylabel("Log wage")
ax.set_title("OLS — synthetic NLSY-style relationship")
ax.legend()
fig.tight_layout()
fig.savefig(OUT / "ols_demo.png", dpi=150)
plt.close()

# RDD
x_rdd = rng.uniform(-3, 3, 300)
treat = (x_rdd >= 0).astype(float)
y_rdd = 1.0 + 0.5 * x_rdd + 1.2 * treat + rng.normal(0, 0.5, 300)
fig, ax = plt.subplots(figsize=(7, 4))
mask_l, mask_r = x_rdd < 0, x_rdd >= 0
ax.scatter(x_rdd[mask_l], y_rdd[mask_l], alpha=0.5, s=15, color="#3b82f6", label="Control")
ax.scatter(x_rdd[mask_r], y_rdd[mask_r], alpha=0.5, s=15, color="#f97316", label="Treated")
ax.axvline(0, color="#111", ls="--", lw=1)
ax.set_xlabel("Running variable")
ax.set_ylabel("Outcome")
ax.set_title("RDD — discontinuity at cutoff (synthetic)")
ax.legend()
fig.tight_layout()
fig.savefig(OUT / "rdd_demo.png", dpi=150)
plt.close()

print(f"Saved 2 figures to {OUT}")
