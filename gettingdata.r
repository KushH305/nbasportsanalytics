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

str(bos)
head(bos, 2)
tail(bos, 3)
summary(bos)

bos$slugMatchup <- as.factor(bos$slugMatchup)

# Pie Chart
tab <- table(bos$slugOpponent)
pie(tab,
    col = rainbow(30),
    main = 'Boston Opponents')

# Bar Plot
barplot(tab,
        col = rainbow(30),
        las = 2) # Labels as vertical

# Histogram
hist(bos$pts,
     col = 'green',
     main = 'Points Per Player Per Game',
     xlab = 'Points Made')

# Scatter Plot
# y axis ~ x axis
plot(pts ~ minutes, bos)
pairs(bos[,30:35])
 
# Libraries
library(psych)
pairs.panels(bos[,30:35])

# Missing Data
mean(bos$pctFT, na.rm = TRUE)
sd(bos$pctFT, na.rm = TRUE)

# Rows with missing data
bos[!complete.cases(bos),]
dim(bos)

# New data frame w/out missing data
new <- na.omit(bos)
dim(new)