# MITx 14.310x — OLS demo (self-contained synthetic data)
set.seed(42)
n <- 800
data <- data.frame(
  yrs_school = rnorm(n, mean = 12, sd = 2.5),
  lwage = rnorm(n, mean = 2.8, sd = 0.4)
)
data$lwage <- data$lwage + 0.05 * data$yrs_school

fit <- lm(lwage ~ yrs_school, data = data)
cat("=== OLS: lwage ~ yrs_school ===\n")
print(summary(fit))
cat("\n90% CI:\n")
print(confint(fit, level = 0.90))
