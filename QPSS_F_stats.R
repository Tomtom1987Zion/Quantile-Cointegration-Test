######################################################
# Quantile Cointegration
# Date: 1/01/2025
# Authors: Tomiwa Sunday Adebayo, Oktay Özkan, Dilber Uzun Ozsahin, Babatunde Sunday Eweade and Bright Akwasi Gyamfi
# Twaikline@gmail.com
# https://enveurope.springeropen.com/articles/10.1186/s12302-025-01059-z
# Journal Name: Environmental Sciences Europe
#######################################################


# set working directory for interactive run
rm(list=ls(all=TRUE))


#Load packages

library(readxl)
library(urca)
library("dynamac")
library(ggplot2)
library("parallel")
options(warn=-1)
options(mc.cores=detectCores())


# Loading DATA, where it is located and name of file.

dataset <- read_excel("DATA.xlsx")

attach(dataset)
y <- CO2
x <- ICT
tau <- seq(from = 0.05, to = 0.95, by = 0.05)
results <- matrix(NA,ncol=length(tau))

for (i in 1:length(tau)) {
  ytau <- quantile(y, probs = tau[i])
  psiy <- rep(tau[i], length(y)) - as.numeric(y - ytau < 0)
  data <- data.frame(psiy,x)
  ardl.model<- dynardl(psiy ~ x,
  lags= list("psiy" = 1, "x" = 1),
  diffs= "x",
  ec = TRUE, simulate = FALSE)
  pss=pssbounds(ardl.model, object.out = TRUE)
  results[[i]] <- pss$fstat
}



df <- data.frame(tau = tau, results = results[1,])

# ggplot 

ggplot(df, aes(x = tau, y = results)) +
  geom_line(color = "black", size=2) +
  geom_hline(yintercept = pss[["ftest.I1.p01"]], linetype = "dashed", color = "red", size=1) +
  geom_hline(yintercept = pss[["ftest.I1.p05"]], linetype = "dashed", color = "blue", size=1) +
  geom_hline(yintercept = pss[["ftest.I1.p10"]], linetype = "dashed", color = "green", size=1) +
  labs(title = "QPSS", x = "Quantiles", y = "F-Statistics") +
  theme_bw() + theme(plot.title = element_text(hjust = 0.5))


## red, blue, and green show upper (I1) bound's critical value at 1%, 5%, and 10%, respectively.

