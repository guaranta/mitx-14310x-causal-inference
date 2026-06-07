# MITx 14.310x — Regression Discontinuity demo (synthetic)
set.seed(3)
n <- 600
x <- runif(n, -1, 1)
treat <- as.numeric(x >= 0)
y <- 1 + 0.5 * x + 1.2 * treat + 0.8 * x * treat + rnorm(n, 0, 0.2)

fit <- lm(y ~ treat + x + treat:x, subset = abs(x) <= 0.5)
cat("=== RDD local linear (|x| <= 0.5) ===\n")
print(summary(fit))
cat("\nDiscontinuity at cutoff (treat coef) ≈ causal jump at x=0\n")
