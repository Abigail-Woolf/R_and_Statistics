# R_and_Statistics

## Project Overview
For this project I analyzed two datasets, MechaCar_mpg.csv and Suspension_Coil.csv to determine if the manufacturing of the car prototype is consistent across lots. The car prototype, MechaCar, is suffering from production troubles due to certain vehicle specifications and manufacturing processes. This analysis is necessary to determine what last minute changes need to be made for producition of optimal cars. 

## Data Files
MechaCar_mpg.csv 
Suspension_Coil.csv

## Folder Contents
| Folders | Contents |
----------|-----------
| Resources | Contains the raw automotive datasets |
| 01_Demo | Examples of R code and statistical test |
| Challenge | Complete and clean code for this repository |
| Images | Useful Charts for Statistics|

## Final Analysis
MPG REGRESSION
    
    I used a multiple linear regression model to predict the mpg of MechaCar prototypes using four variables. I also checked the distribution of the mpg data and saw that it represented a normal bell curve. Consequently, I did not have to adjust the data to ensure an approximate normal distribution.
    Before I ran the multiple linear regression, I was curious to see the results of Pearson's Correlation coefficients in a correlation matrix that I named Mecha_matrix. I noticed that the two variables with the strongest correlations to mpg were vehicle length and ground clearance (both positive). I took note of these correlations to compare them to my complete linear regression. 
   
    I determined my null hypothesis to be: there is no correlation between mpg and any of the other vehicle specifications in the MechCar dataset. Therefore, the hypothesis is: there is a correlation between mpg and other vehicle specifications. The significance level is p<0.05.
    
    When I observed the results of the statistical analysis, I found that I was able to reject the null hypothesis for both variables, vehicle length and ground clearance, based on these P values respectively: 3.05e-12 and 2.13e-8. This was expected based on the correlation matrix I had built earlier. 
    The slope of this linear model would not be considered to be zero because there was a significant positive correlation between two of the five tested variables. 
    The R-squared value (0.7032) suggests that ~70% of predictions of mpg will be correct using this model. In other words, this linear model of MechCar prototypes can effectively predict mpg of the cars. 

SUSPENSION COIL SUMMARY
 
    In my summary statistics table, I found that the variance was: Variance=76.23459. According to the MechaCar design specifications for the suspension coils, the variance must not exceed 100 PSI, so I am within the allowed variance. In other words, the manufacturing data currently meets the design specifications. 

SUSPENSION COIL T-TEST
 
    I chose a single-sample-T test to compare the mean PSI of my sample data to the given population mean PSI(1500). The results of this test gave me a p-value=0.5117, which is above the significance level of p=0.05. In other words, there is not sufficient evidence to reject the null hypothesis, and the means are statistically similar.  

MY STUDY

    To compare the performance of the MechaCar prototype vehicle to other vehicles on the market, I would choose to look at fuel efficiency, cost, color, and size. These are metrics that will most likely be of interest to a customer. To quantify how the MechaCar might outperform the competition, I want to copmare my MechaCar sample to a greater population of cars that are on the market. I would first do a single-sample T-test to compare the mpg (efficiency) of MechaCar models to as many other cars on the market that have this data accessible. So, I would need to collect data about the car populations' mpg. The null hypothesis would be that there is no significant difference between the mpg of MechaCar prototypes and other cars on the market. The hypothesis is there is a significant difference between the mpg of MechaCar prototypes and other cars on the market. If we get statistical significance, we can reject the null hypothesis.

