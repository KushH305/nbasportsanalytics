# Setting up Data
points <- c(35, 27, 12, 15, 19)
player <- c('Tatum', 'Brown', 'Williams', 'Horford', 'White')

# Setting up Data Frame
mydata <- data.frame(player, points)
str(mydata)

# Functions
names(mydata) # lists the columns
dim(mydata) # dimensions of data frame
summary(mydata) # mean, median, mode of num data

# Boston Celtics
bos <- read.csv('https://raw.githubusercontent.com/bkrai/Sports-Analytics-With-R/main/2022BOS.csv')