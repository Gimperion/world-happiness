options(stringsAsFactors=FALSE)

library(dplyr)
library(tomkit) # https://github.com/Gimperion/tomkit



##  Find Correlation & Regression for -

## Family
## Health
## Freedom
## Trust (Government corruption)
## Generosity
## Dystopia residual

EXERCISE_VARS <- c("family", "health_life_expectancy", "freedom", "trust_government_corruption", "generosity", "dystopia_residual")
COL_MAP <- c("2015"="sienna", "2016"="seagreen", "2017"="steelblue")


## Data Loading 
raw <- read.csv("raw/World_Happiness_2015_2017.csv") %>%
    cleanNames()

## Functions 
getHappinessCor <- function(var){
    cor_value <- cor(raw[,var], raw$happiness_score, method="pearson")
    list(
        r = cor_value,
        r_sq = cor_value^2,
        linear_model = lm(formula(sprintf("happiness_score ~ %s", var)), data=raw)
    )
}

showModel <- function(var){
    plot(raw[,var], raw$happiness_score, pch=19, las=1,
         col=COL_MAP[as.character(raw$year)],
         main=sprintf("happiness_score ~ %s (r=%.03f)", var, models[[var]]$r),
         ylab="happiness_score", xlab=var)
    abline(models[[var]]$linear_model, lwd=2, lty=2)
}
    

## Execute 
models <- lapply(EXERCISE_VARS, getHappinessCor) %>%
    setNames(EXERCISE_VARS)


par(mfrow=c(2,3))
lapply(EXERCISE_VARS, showModel)
