#Import required tools and libraries
library(tidyverse)
# Import the MechaCar mpg dataset
MechaCar_table <- read.csv(file = 'MechaCar_mpg.csv',check.names = T,stringsAsFactors = F)
# Import Suspension_coil.csv
SuspensionCoil_table <- read.csv(file='Suspension_Coil.csv',check.names = T,stringsAsFactors = F)
#Check for distribution of mpg on MechaCar dataset
ggplot(MechaCar_table,aes(x=mpg)) + geom_density()
shapiro.test(MechaCar_table$mpg)
#Create a correlation matrix to visualize pearson correlation coefficent
Mecha_matrix <- data.matrix(MechaCar_table, rownames.force = NA)
cor(Mecha_matrix)

#run mult linear regression
lm(mpg ~ vehicle.length + vehicle.weight + spoiler.angle + ground.clearance, data=filtered_Mecha)
summary(lm(mpg ~ vehicle.length + vehicle.weight + spoiler.angle + ground.clearance, data=filtered_Mecha))

#Fine mean, median, variance, and SD of PSI variable
summary(SuspensionCoil_table)
mean(SuspensionCoil_table$PSI)
median(SuspensionCoil_table$PSI)
sd(SuspensionCoil_table$PSI)
var(SuspensionCoil_table$PSI)
#Create summary stats table of suspension coil's lb/in continuous variable
stats <- c("Mean", "Median", "Variance", "Standard_Deviation")
stats_results <- c(1499.531,1499.747,76.23459,8.731242)
stats_table <- data.frame(stats, stats_results)
#Check boxplots to visulize
plt <- ggplot(SuspensionCoil_table,aes(x=Manufacturing_Lot,y=PSI))
plt + geom_boxplot()

#Perform a t-test
t.test(SuspensionCoil_table$PSI,mu=1500)
       
       