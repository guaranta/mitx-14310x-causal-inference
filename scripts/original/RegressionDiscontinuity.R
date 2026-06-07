
#-------Regression Discontinuity-------
rm(list = ls())
install.packages("rdd")
library(rdd)
indiv <- read.csv('indiv_final.csv')

# Create a variable to indicate whether the party of the candidate is the same as the incumbent
indiv$incum_paty <- as.numeric(indiv$difshare > 0)
incum_proportion <- sum(indiv$incum_paty)/nrow(indiv)
summary(indiv$incum_paty) 

# Check for discontinuities
DCdensity(indiv$difshare, 0, verbose = TRUE, htest = TRUE, ext.out=TRUE)

# Add extra variables to run some linear models
indiv$difshare_sq <- (indiv$difshare)^2
indiv$difshare_cub <- (indiv$difshare)^3


#Parametric Regression
matrix_coef <- matrix(NA, nrow = 2, ncol = 11)

model <- lm(myoutcomenext ~ incum_paty, data = indiv, subset = abs(difshare) <= 0.5)
matrix_coef[1, 1] <- model$coefficients[2]
pvalue <- summary(model)
matrix_coef[2, 1] <- pvalue$coefficients[2, 4]

model <- lm(myoutcomenext ~ incum_paty + difshare, data = indiv, subset = abs(difshare) <= 0.5)
matrix_coef[1, 2] <- model$coefficients[2]
pvalue <- summary(model)
matrix_coef[2, 2] <- pvalue$coefficients[2, 4]

model <- lm(myoutcomenext ~ incum_paty + difshare + incum_paty*difshare, data = indiv, subset = abs(difshare) <= 0.5)
matrix_coef[1, 3] <- model$coefficients[2]
pvalue <- summary(model)
matrix_coef[2, 3] <- pvalue$coefficients[2, 4]

model <- lm(myoutcomenext ~ incum_paty + difshare + difshare_sq, data = indiv, subset = abs(difshare) <= 0.5)
matrix_coef[1, 4] <- model$coefficients[2]
pvalue <- summary(model)
matrix_coef[2, 4] <- pvalue$coefficients[2, 4]

model <- lm(myoutcomenext ~ incum_paty + difshare + difshare_sq + incum_paty*difshare + incum_paty*difshare_sq, data = indiv, 
            subset = abs(difshare) <= 0.5)
matrix_coef[1, 5] <- model$coefficients[2]
pvalue <- summary(model)
matrix_coef[2, 5] <- pvalue$coefficients[2, 4]


model <- lm(myoutcomenext ~ incum_paty + difshare + difshare_sq + difshare_cub, data = indiv, subset = abs(difshare) <= 0.5)
matrix_coef[1, 6] <- model$coefficients[2]
pvalue <- summary(model)
matrix_coef[2, 6] <- pvalue$coefficients[2, 4]


model <- lm(myoutcomenext ~ incum_paty + difshare + difshare_sq + difshare_cub + incum_paty*difshare + incum_paty*difshare_sq +
              incum_paty*difshare_cub, data = indiv, 
            subset = abs(difshare) <= 0.5)
matrix_coef[1, 7] <- model$coefficients[2]
pvalue <- summary(model)
matrix_coef[2, 7] <- pvalue$coefficients[2, 4]

matrix_coef

model <- RDestimate(myoutcomenext~difshare, data=indiv, subset = abs(indiv$difshare) <=0.5)
summary(model)


#Plot A
model1 <- RDestimate(myoutcomenext ~ difshare, data = indiv, subset = abs(indiv$difshare) <=0.5)
plot(model1)
#Plot B
model2 <- RDestimate(myoutcomenext ~ difshare, data = indiv, subset=abs(indiv$difshare) <=0.5,
                     kernel = "rectangular", bw = 3)
plot(model2)
#Plot C
model3 <- RDestimate(myoutcomenext ~ difshare, data = indiv, subset=abs(indiv$difshare) <=0.5,
                     kernel = "rectangular", bw = (1/3))
plot(model3)
