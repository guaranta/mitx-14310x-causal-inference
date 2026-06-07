# MITx 14.310x — IV / 2SLS intuition (synthetic Angrist-Evans style)
set.seed(7)
n <- 1000
z <- rbinom(n, 1, 0.5)  # instrument
u <- rnorm(n)
x <- 0.6 * z + u + rnorm(n, 0, 0.5)  # endogenous regressor
y <- 2 + 1.5 * x + u + rnorm(n, 0, 0.3)

ols <- lm(y ~ x)
iv <- lm(y ~ x, data = data.frame(y, x, z), subset = NULL)
# manual 2SLS: first stage + second stage
fs <- lm(x ~ z)
x_hat <- predict(fs)
sls <- lm(y ~ x_hat)

cat("=== OLS (biased) ===\n")
print(coef(ols))
cat("\n=== 2SLS (instrument Z) ===\n")
print(coef(sls))
