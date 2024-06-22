library(tidyverse)
library(ggplot2)
library(dplyr)

#import dataset
dataset <- read_csv("/Users/ayokunlejames/Downloads/data.csv")
View(dataset)

#rename columns
dataset <- dataset |> 
  rename(
    Emission = 'Sum of Round Trip CO2 emission (kgCo2e)',
    Mileage = 'Sum of Round Trip Mileage (km)')

#view distribution
ggplot(dataset, aes(x = Emission)) +
  geom_histogram(binwidth = 5, fill = "blue", color = "black", alpha = 0.7) +
    labs(title = "Histogram of CO2 emission", x = "Emissions", y = "Frequency")
  
#boxplot of emission distribution
ggplot(dataset, aes(y = Emission)) +
  geom_boxplot(fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Boxplot of CO2 emission", y = "Emissions")


Q1 <- quantile(dataset$Emission, 0.25)
Q3 <- quantile(dataset$Emission, 0.75)
IQR <- Q3-Q1

lower_bound <- Q1-1.5*IQR
upper_bound <- Q3+1.5*IQR

#identify outliers
outliers <- dataset |> filter(Emission <lower_bound | Emission >upper_bound)

outliers |> View()

#save csv file
write.csv(outliers, "outliers.csv", row.names = FALSE)

ggplot(dataset, aes(y = Emission)) +
  geom_boxplot(fill = "blue", color = "black", alpha = 0.7) +
  geom_jitter(aes(x = 1, color = (Emission <lower_bound | Emission >upper_bound)), width = 0.2, size = 2) +
  scale_color_manual(values = c("black", "red")) +
  labs(title = "Boxplot of CO2 emission", y = "Emissions")+
  theme(legend.position = "none")
