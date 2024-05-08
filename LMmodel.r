# Library
library(BasketballAnalyzeR)
Tadd$team

# Tbox
Tbox[1,]

# OBox
Obox[1,]

# Pace, Ratings, & Four factors
FF <- fourfactors(Tbox[1:2,],Obox[1:2,])
plot(FF)

FF2 <- fourfactors(Tbox[c(2,6,10),], Obox[c(2,6,10),])
plot(FF2)

TF <- fourfactors(Tbox,Obox)

# Correlation Plot
corrplot(cor(TF[-1]),
         method='number',
         type='upper')

# Team Success
efg_dev <- TF$F1.Off-TF$F1.Def
to_dev <- TF$F2.Def-TF$F2.Off
reb_dev <- TF$F3.Off-TF$F3.Def
ft_dev <- TF$F4.Off-TF$F4.Def
wins <- Tbox$W
data <- data.frame(wins, efg_dev, to_dev, reb_dev, ft_dev)

# Plotting this data
corrplot(cor(data),
         method='number',
         type='upper')

# Multiple Linear Regression
model <- lm(wins ~ ., data)
summary(model)