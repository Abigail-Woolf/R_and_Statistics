install.packages("tidyverse")
library(tidyverse)
install.packages("dyplr")
library(dbplyr)
install.packages("magrittr")
library(magrittr)
# Loading in demo data from 01_Demo directory
demo_table <- read.csv(file='demo.csv',check.names=F,stringsAsFactors = F)
demo_table2 <- fromJSON(txt='demo.json')
# select third row of the Year column in demo_table
demo_table[3,"Year"]
# Or, this is another way to do it
demo_table[3,3]
# Here is a third way to select data from an R data frame
demo_table$"Vehicle_Class"
# Use bracket notation to filter a data frame 
filter_table <- demo_table2[demo_table2$price > 1000,]
# Filter data by price and drivetrain using subset() functions
filter_table2 <- subset(demo_table2, price > 10000 & drive == "4wd" & "clean" %in% title_status) 
# Sample data from demo_table
demo_table[sample(1:nrow(demo_table), 3),]
# Transform data frame and include new calculated data with mutate() function
demo_table <- demo_table %>% mutate(Mileage_per_Year=Total_Miles/(2020-Year),IsActive=TRUE)
# Use dyplr's group_by() function to group our car data by the condition of the vehicle 
# and determine the average mileage per condition, create a summary table
summarize_demo <- demo_table2 %>% group_by(condition) %>% summarize(Mean_Mileage=mean(odometer))
# Adding max price per condition and add vehicles in each category
summarize_demo <- demo_table2 %>% group_by(condition) %>% summarize(Mean_Mileage=mean(odometer),Maximum_Price=max(price),Num_Vehicles=n())
# Reshape data with tidyr library's spread() and gather() functions, first read in the new data
demo_table3 <- read.csv('demo2.csv',check.names = F,stringsAsFactors = F)
long_table <- gather(demo_table3,key="Metric",value="Score",buying_price:popularity)
# Or
long_table <- demo_table3 %>% gather(key="Metric",value="Score",buying_price:popularity)
# Spread out long format data frame
wide_table <- long_table %>% spread(key="Metric",value="Score")
# Get familiar with mpg data
head(mpg)
# Generate bar plots using ggplot2
plt <- ggplot(mpg,aes(x=class)) # Import dataset into ggplot2
plt + geom_bar()
# Compare the number of vehicles from each manufacturer in the dataset
mpg_summary <- mpg %>% group_by(manufacturer) %>% summarize(Vehicle_Count=n()) #create summary table
plt <- ggplot(mpg_summary,aes(x=manufacturer,y=Vehicle_Count)) #import dataset into ggplot2
plt + geom_col() #plot a bar plot
# Change the titles of our x-axis and y-axis
plt + geom_col() + xlab("Manufacturing Company") + ylab("Number of Vehicles in Dataset") #plot bar plot with labels
# Rotate the x-axis labels 45 degrees
plt + geom_col() + xlab("Manufacturing Company") + ylab("Number of Vehicles in Dataset") + #plot a boxplot with labels
theme(axis.text.x=element_text(angle=45,hjust=1)) #rotate the x-axis label 45 degrees

# Compare the differences in average highway fuel economy of Toyota vehicles as a function of the different cylinder sizes
mpg_summary <- subset(mpg,manufacturer=="toyota") %>% group_by(cyl) %>% summarize(Mean_Hwy=mean(hwy)) #create summary table
plt <- ggplot(mpg_summary,aes(x=cyl,y=Mean_Hwy)) #import dataset into ggplot2
plt + geom_line()
# Adjust the x-axis and y-axis tick values
plt + geom_line() + scale_x_discrete(limits=c(4,6,8)) + scale_y_continuous(breaks = c(15:30))

# Create scatter plot to visualize relationship between the size of each car engine versus their city fuel efficiency
plt <- ggplot(mpg,aes(x=displ,y=cty)) #import dataset into ggplot2
plt + geom_point() + xlab("Engine Size (L)") + ylab("City Fuel-Efficiency (MPG)") 
# Apply custom aesthetics
plt <- ggplot(mpg,aes(x=displ,y=cty,color=class)) #import dataset into ggplot2
plt + geom_point() + labs(x="Engine Size (L)", y="City Fuel-Efficiency (MPG)", color="Vehicle Class") #add scatter plot with labels
# Add shape aesthetic
plt <- ggplot(mpg,aes(x=displ,y=cty,color=class,shape=drv)) #import dataset into ggplot2
plt + geom_point() + labs(x="Engine Size (L)", y="City Fuel-Efficiency (MPG)", color="Vehicle Class",shape="Type of Drive") 

# Generate a boxplot to visualize the highway fuel efficiency of our mpg dataset
plt <- ggplot(mpg,aes(y=hwy)) #import dataset into ggplot2
plt + geom_boxplot() #add boxplot
# Create a set of boxplots that compares highway fuel efficiency for each car manufacturer
plt <- ggplot(mpg,aes(x=manufacturer,y=hwy)) #import dataset into ggplot2
plt + geom_boxplot() + theme(axis.text.x=element_text(angle=45,hjust=1)) #add boxplot and rotate x-axis labels 45 degrees

# Visualize heatmap of the average highway fuel efficiency across the type of vehicle class from 1999 to 2008
mpg_summary <- mpg %>% group_by(class,year) %>% summarize(Mean_Hwy=mean(hwy)) #create summary table
plt <- ggplot(mpg_summary, aes(x=class,y=factor(year),fill=Mean_Hwy))
plt + geom_tile() + labs(x="Vehicle Class",y="Vehicle Year",fill="Mean Highway (MPG)") #create heatmap with labels 
# Look at the difference in average highway fuel efficiency across each vehicle model from 1999 to 2008
mpg_summary <- mpg %>% group_by(model,year) %>% summarize(Mean_Hwy=mean(hwy)) #create summary table
plt <- ggplot(mpg_summary, aes(x=model,y=factor(year),fill=Mean_Hwy)) #import dataset into ggplot2
plt + geom_tile() + labs(x="Model",y="Vehicle Year",fill="Mean Highway (MPG)") + theme(axis.text.x = element_text(angle=90,hjust=1,vjust=.5)) 

# Recreate boxplot ex comparing hwy fuel efficiency across manufactureers with layer of scatter plot on top
plt <- ggplot(mpg,aes(x=manufacturer,y=hwy)) #import dataset into ggplot2
plt + geom_boxplot() + theme(axis.text.x=element_text(angle=45,hjust=1)) + #rotate x-axis labels 45 degrees
geom_point() #overlay scatter plot on top
# mapping argument exactly same as ggplot() function b/c it uses aes() function to id variables to use
mpg_summary <- mpg %>% group_by(class) %>% summarize(Mean_Engine=mean(displ)) #create summary table
plt <- ggplot(mpg_summary,aes(x=class,y=Mean_Engine)) #import dataset into ggplot2
plt + geom_point(size=4) + labs(x="Vehicle Class",y="Mean Engine Size") #add scatter plot
# Layer the upper and lower standard deviation boundaries to our visualization using the geom_errorbar() function
mpg_summary <- mpg %>% group_by(class) %>% summarize(Mean_Engine=mean(displ),SD_Engine=sd(displ))
plt <- ggplot(mpg_summary,aes(x=class,y=Mean_Engine)) #import dataset into ggplot2
plt + geom_point(size=4) + labs(x="Vehicle Class",y="Mean Engine Size") + #add scatter plot with labels
geom_errorbar(aes(ymin=Mean_Engine-SD_Engine,ymax=Mean_Engine+SD_Engine)) #overlay with error bars
# Use facet() function to separate out plots for eaxh level
mpg_long <- mpg %>% gather(key="MPG_Type",value="Rating",c(cty,hwy)) #convert to long format
head(mpg_long)

# Visualize the different vehicle fuel efficiency ratings by manufacturer
plt <- ggplot(mpg_long,aes(x=manufacturer,y=Rating,color=MPG_Type)) #import dataset into ggplot2
plt + geom_boxplot() + theme(axis.text.x=element_text(angle=45,hjust=1)) #add boxplot with labels rotated 45 degrees
# Facet our previous example by the fuel-efficiency type
plt <- ggplot(mpg_long,aes(x=manufacturer,y=Rating,color=MPG_Type)) #import dataset into ggplot2
plt + geom_boxplot() + facet_wrap(vars(MPG_Type)) + theme(axis.text.x=element_text(angle=45,hjust=1),legend.position = "none") + xlab("Manufacturer")

# Stats
# Test distribution of vehicle weights from the built in mtcars dataset
ggplot(mtcars,aes(x=wt)) + geom_density()
# Perform a quantitative Shapiro-Wilk test on our previous example
shapiro.test(mtcars$wt)

# Visualize the distribution of driven miles for our entire population dataset
population_table <- read.csv('used_car_data.csv',check.names = F,stringsAsFactors = F) #import used car dataset
plt <- ggplot(population_table,aes(x=log10(Miles_Driven))) #import dataset into ggplot2
plt + geom_density() #visualize distribution using density plot
# Create a sample dataset using dplyr’s sample_n() function
sample_table <- population_table %>% sample_n(50) #randomly sample 50 data points
plt <- ggplot(sample_table,aes(x=log10(Miles_Driven))) #import dataset into ggplot2
plt + geom_density() #visualize distribution using density plot

# Test if the miles driven from our previous sample dataset is statistically different from the miles driven in our population data
t.test(log10(sample_table$Miles_Driven),mu=mean(log10(population_table$Miles_Driven))) 
# two-sample t-Test of whether the mean miles driven of two samples from our used car dataset are statistically different
sample_table <- population_table %>% sample_n(50) #generate 50 randomly sampled data points
sample_table2 <- population_table %>% sample_n(50) #generate another 50 randomly sampled data points
t.test(log10(sample_table$Miles_Driven),log10(sample_table2$Miles_Driven)) #compare means of two samples

# Using mpg_modified.csv generate out two samples
mpg_data <- read.csv('mpg_modified.csv') #import dataset
mpg_1999 <- mpg_data %>% filter(year==1999) #select only data points where the year is 1999
mpg_2008 <- mpg_data %>% filter(year==2008) #select only data points where the year is 2008
# Use a paired t-test to determine if there is a statistical difference in overall highway fuel 
# efficiency between vehicles manufactured in 1999 versus 2008
t.test(mpg_1999$hwy,mpg_2008$hwy,paired = T) #compare the mean difference between two samples

# Clean the data before ANOVA
mtcars_filt <- mtcars[,c("hp","cyl")] #filter columns from mtcars dataset
mtcars_filt$cyl <- factor(mtcars_filt$cyl) #convert numeric column to factor
aov(hp ~ cyl,data=mtcars_filt) #compare means across multiple levels
# Retrieve P-values
summary(aov(hp ~ cyl,data=mtcars_filt))

# Correlation
# Plot the two variables
plt <- ggplot(mtcars,aes(x=hp,y=qsec)) #import dataset into ggplot2
plt + geom_point() #create scatter plot
# Quantify the strength of the correlation between our two variables
cor(mtcars$hp,mtcars$qsec) #calculate correlation coefficient
# Another example on used_cars
used_cars <- read.csv('used_car_data.csv',stringsAsFactors = F) #read in dataset
head(used_cars)
# Plot the variables
plt <- ggplot(used_cars,aes(x=Miles_Driven,y=Selling_Price)) #import dataset into ggplot2
plt + geom_point() #create a scatter plot
# Calculate the Pearson correlation coefficient
cor(used_cars$Miles_Driven,used_cars$Selling_Price)

# Produce a correlation matrix for our used_cars dataset
used_matrix <- as.matrix(used_cars[,c("Selling_Price","Present_Price","Miles_Driven")]) #convert data frame into numeric matrix
cor(used_matrix)

# Create a linear regression model
lm(qsec ~ hp,mtcars)
# Determine our p-value and our r-squared value for a simple linear regression model
summary(lm(qsec~hp,mtcars))
# Visualize fitted line against the data set, first calculate those data points
model <- lm(qsec ~ hp,mtcars) #create linear model
yvals <- model$coefficients['hp']*mtcars$hp + model$coefficients['(Intercept)'] #determine y-axis values from linear model
# Plot the linear model over the scatter plot
plt <- ggplot(mtcars,aes(x=hp,y=qsec)) 
plt + geom_point() + geom_line(aes(y=yvals), color = "red") 

# Generate multiple linear regression model
lm(qsec ~ mpg + disp + drat + wt + hp,data=mtcars) 
# Obtain statistical metrics
summary(lm(qsec ~ mpg + disp + drat + wt + hp,data=mtcars))

# Chi-squared
#generate contingency table
table(mpg$class,mpg$year) 
# Pass the contingency table to the chisq.test() function
tbl <- table(mpg$class,mpg$year) #generate contingency table
chisq.test(tbl) #compare categorical distributions








