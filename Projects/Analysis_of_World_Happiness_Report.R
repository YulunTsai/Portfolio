WHR <- read.csv("WHR.csv")
dim(WHR)
nrow(WHR)

install.packages("dplyr")
install.packages("tidyverse")
library(dplyr)
library(magrittr)
library(tidyverse)
library(regclass)
library(ggplot2)

# fill the regional
rows <- which(WHR$Country.Name == "Angola")
WHR$Regional.Indicator[rows] <- "Sub-Saharan Africa"
rows <- which(WHR$Country.Name == "Belize")
WHR$Regional.Indicator[rows] <- "Latin America and Caribbean"
rows <- which(WHR$Country.Name == "Bhutan")
WHR$Regional.Indicator[rows] <- "South Asia"
rows <- which(WHR$Country.Name == "Central African Republic")
WHR$Regional.Indicator[rows] <- "Sub-Saharan Africa"
rows <- which(WHR$Country.Name == "Congo (Kinshasa)")
WHR$Regional.Indicator[rows] <- "Sub-Saharan Africa"
rows <- which(WHR$Country.Name == "Cuba")
WHR$Regional.Indicator[rows] <- "Latin America and Caribbean"
rows <- which(WHR$Country.Name == "Czechia")
WHR$Regional.Indicator[rows] <- "Central and Eastern Europe"
rows <- which(WHR$Country.Name == "Djibouti")
WHR$Regional.Indicator[rows] <- "Sub-Saharan Africa"
rows <- which(WHR$Country.Name == "Eswatini")
WHR$Regional.Indicator[rows] <- "Sub-Saharan Africa"
rows <- which(WHR$Country.Name == "Guyana")
WHR$Regional.Indicator[rows] <- "Latin America and Caribbean"
rows <- which(WHR$Country.Name == "Oman")
WHR$Regional.Indicator[rows] <- "Middle East and North Africa"
rows <- which(WHR$Country.Name == "Qatar")
WHR$Regional.Indicator[rows] <- "Middle East and North Africa"
rows <- which(WHR$Country.Name == "Somalia")
WHR$Regional.Indicator[rows] <- "Sub-Saharan Africa"
rows <- which(WHR$Country.Name == "Somaliland region")
WHR$Regional.Indicator[rows] <- "Sub-Saharan Africa"
rows <- which(WHR$Country.Name == "South Sudan")
WHR$Regional.Indicator[rows] <- "Sub-Saharan Africa"
rows <- which(WHR$Country.Name == "State of Palestine")
WHR$Regional.Indicator[rows] <- "Middle East and North Africa"
rows <- which(WHR$Country.Name == "Sudan")
WHR$Regional.Indicator[rows] <- "Sub-Saharan Africa"
rows <- which(WHR$Country.Name == "Suriname")
WHR$Regional.Indicator[rows] <- "Latin America and Caribbean"
rows <- which(WHR$Country.Name == "Syria")
WHR$Regional.Indicator[rows] <- "Middle East and North Africa"
rows <- which(WHR$Country.Name == "Trinidad and Tobago")
WHR$Regional.Indicator[rows] <- "Latin America and Caribbean"
rows <- which(WHR$Country.Name == "Turkiye")
WHR$Regional.Indicator[rows] <- "Middle East and North Africa"

summary(WHR)

# fill median to missing values
#ConfidenceInNationalGovernment
data_with_median <- WHR %>%
  group_by(Country.Name) %>%
  mutate(Confidence_In_National_Government_Median = median(Confidence.In.National.Government, na.rm = TRUE))
WHR <- data_with_median %>%
  mutate(Confidence.In.National.Government = ifelse(is.na(Confidence.In.National.Government), 
                                                    Confidence_In_National_Government_Median, 
                                                    Confidence.In.National.Government)) %>%
  select(-Confidence_In_National_Government_Median)
#GDP
data_with_median <- WHR %>%
  group_by(Country.Name) %>%
  mutate(GDP_Median = median(Log.GDP.Per.Capita, na.rm = TRUE))
WHR <- data_with_median %>%
  mutate(Log.GDP.Per.Capita = ifelse(is.na(Log.GDP.Per.Capita), 
                                     GDP_Median,
                                     Log.GDP.Per.Capita)) %>%
  select(-GDP_Median)
#Social Support
data_with_median <- WHR %>%
  group_by(Country.Name) %>%
  mutate(SS_Median = median(Social.Support, na.rm = TRUE))
WHR <- data_with_median %>%
  mutate(Social.Support = ifelse(is.na(Social.Support), 
                                 SS_Median,
                                 Social.Support)) %>%
  select(-SS_Median)
#Healthy Life
data_with_median <- WHR %>%
  group_by(Country.Name) %>%
  mutate(HL_Median = median(Healthy.Life.Expectancy.At.Birth, na.rm = TRUE))
WHR <- data_with_median %>%
  mutate(Healthy.Life.Expectancy.At.Birth = ifelse(is.na(Healthy.Life.Expectancy.At.Birth), 
                                 HL_Median,
                                 Healthy.Life.Expectancy.At.Birth)) %>%
  select(-HL_Median)
#Freedom
data_with_median <- WHR %>%
  group_by(Country.Name) %>%
  mutate(Freedom_Median = median(Freedom.To.Make.Life.Choices, na.rm = TRUE))
WHR <- data_with_median %>%
  mutate(Freedom.To.Make.Life.Choices = ifelse(is.na(Freedom.To.Make.Life.Choices), 
                                               Freedom_Median,
                                               Freedom.To.Make.Life.Choices)) %>%
  select(-Freedom_Median)
#Corruption
data_with_median <- WHR %>%
  group_by(Country.Name) %>%
  mutate(PC_Median = median(Perceptions.Of.Corruption, na.rm = TRUE))
WHR <- data_with_median %>%
  mutate(Perceptions.Of.Corruption = ifelse(is.na(Perceptions.Of.Corruption), 
                                            PC_Median,
                                            Perceptions.Of.Corruption)) %>%
  select(-PC_Median)
#Positive Affact
data_with_median <- WHR %>%
  group_by(Country.Name) %>%
  mutate(PA_Median = median(Positive.Affect, na.rm = TRUE))
WHR <- data_with_median %>%
  mutate(Positive.Affect = ifelse(is.na(Positive.Affect), 
                                  PA_Median,
                                  Positive.Affect)) %>%
  select(-PA_Median)
#Negative Affect
data_with_median <- WHR %>%
  group_by(Country.Name) %>%
  mutate(NA_Median = median(Negative.Affect, na.rm = TRUE))
WHR <- data_with_median %>%
  mutate(Negative.Affect = ifelse(is.na(Negative.Affect), 
                                  NA_Median,
                                  Negative.Affect)) %>%
  select(-NA_Median)

summary(WHR)

#still missing values -> delete it all
WHR <- WHR[complete.cases(WHR), ]

#region
par(mar = c(8, 8, 5, 5))
associate(Confidence.In.National.Government~Regional.Indicator, data=WHR)
1-pf(107.2, df1=9, df2=1972) #0
M <- lm(Confidence.In.National.Government~Regional.Indicator,data=WHR)
M
summary(M)

#Year
associate(Confidence.In.National.Government~Year, data=WHR)
plot(Confidence.In.National.Government~Year,data=WHR)
M <- lm(Confidence.In.National.Government~Year,data=WHR)
abline(M)
M <- lm(Confidence.In.National.Government~Year,data=WHR)
M
summary(M)

#Freedom
associate(Confidence.In.National.Government~Freedom.To.Make.Life.Choices, data=WHR)
plot(Confidence.In.National.Government~Freedom.To.Make.Life.Choices,data=WHR)
M <- lm(Confidence.In.National.Government~Freedom.To.Make.Life.Choices,data=WHR)
abline(M)
M <- lm(Confidence.In.National.Government~Freedom.To.Make.Life.Choices,data=WHR)
M
summary(M)

#Generosity
associate(Confidence.In.National.Government~Generosity, data=WHR)
plot(Confidence.In.National.Government~Generosity,data=WHR)
M <- lm(Confidence.In.National.Government~Generosity,data=WHR)
abline(M)
M <- lm(Confidence.In.National.Government~Generosity,data=WHR)
M
summary(M)

#Healthylife
associate(Confidence.In.National.Government~Healthy.Life.Expectancy.At.Birth, data=WHR)
plot(Confidence.In.National.Government~Healthy.Life.Expectancy.At.Birth,data=WHR)
M <- lm(Confidence.In.National.Government~Healthy.Life.Expectancy.At.Birth,data=WHR)
abline(M)
M <- lm(Confidence.In.National.Government~Healthy.Life.Expectancy.At.Birth,data=WHR)
M
summary(M)

#others
M <- lm(Confidence.In.National.Government~Log.GDP.Per.Capita,data=WHR)
M
summary(M)
M <- lm(Confidence.In.National.Government~Perceptions.Of.Corruption,data=WHR)
M
summary(M)

#Futher question -> in conclusion section
table(WHR$Regional.Indicator)
eastasia <- subset(WHR[WHR$Regional.Indicator == 'East Asia',])
northamerica <-subset(WHR[WHR$Regional.Indicator == 'North America and ANZ', ])
table(northamerica$Country.Name)
table(eastasia$Country.Name)

median_GDP_per_country <- WHR %>%
  group_by(Country.Name) %>%
  summarise(Median_GDP = median(exp(Log.GDP.Per.Capita), na.rm = TRUE))
median_GDP_per_country$ConfidenceOfGovernment <- WHR %>%
  group_by(Country.Name) %>%
  summarise(Median_confidence = median(Confidence.In.National.Government), na.rm = TRUE)
median_GDP_per_country$Healthy <- WHR %>%
  group_by(Country.Name) %>%
  summarise(Median_Healthy = median(Healthy.Life.Expectancy.At.Birth), na.rm = TRUE)
developed <- subset(median_GDP_per_country[median_GDP_per_country$Median_GDP > 20000,])
developing <- subset(median_GDP_per_country[median_GDP_per_country$Median_GDP <= 20000 & median_GDP_per_country$Median_GDP >100,])
least_developed <- subset(median_GDP_per_country[median_GDP_per_country$Median_GDP <= 100,])
summary(developed)
summary(developing)
summary(least_developed)
associate(ConfidenceOfGovernment$Median_confidence~Healthy$Median_Healthy, data=developed)
associate(ConfidenceOfGovernment$Median_confidence~Healthy$Median_Healthy, data=developing)
M <- lm(ConfidenceOfGovernment$Median_confidence~Healthy$Median_Healthy, data=developed)
summary(M)
M <- lm(ConfidenceOfGovernment$Median_confidence~Healthy$Median_Healthy, data=developing)
summary(M)

