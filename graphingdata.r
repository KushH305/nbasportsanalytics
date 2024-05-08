# Libraries
library(MASS)
library(dplyr)
library(ggplot2)
library(corrplot)
library(psych)
library(ggExtra)

# Read Data
bos <- read.csv('https://raw.githubusercontent.com/bkrai/Sports-Analytics-With-R/main/2022BOS.csv')
max(bos$numberGameTeamSeason)
table(bos$numberGameTeamSeason)
table(bos$numberGameTeamSeason, bos$outcomeGame)

# Select
mydata <- bos %>% select(23, 31:35, 'pts')

# Filter
tatum_data <- bos %>% select(23, 31:35, 'pts') %>% 
  filter(namePlayer == 'Jayson Tatum')

scorers_data <- bos %>% select(23, 31:35, 'pts') %>% 
  filter(pts > 40)

# Arrange
bos %>% select(23, 31:35, 'pts') %>% 
  filter(pts > 40) %>% 
  arrange(desc(pts))

# Summarise
bos %>% summarise(AVG = mean(pts),
                  SD = sd(pts),
                  COUNT = n())

# Summarise + Group By
bos %>% group_by(namePlayer) %>% 
  summarise(AVG = mean(pts),
                  SD = sd(pts),
                  COUNT = n()) %>% 
  arrange(desc(AVG))

# Mutate
# Effective Field Goal Percentage
bos %>% group_by(namePlayer) %>% 
  summarise(EFG = (sum(fgm) + 0.5*sum(fg3m))/sum(fga),
            COUNT = n()) %>%
  filter(COUNT > 10) %>% 
  arrange(desc(EFG))

# Which player had the highest free throws made?
bos %>% group_by(namePlayer) %>% 
  summarise(FT = sum(ftm)) %>% 
  arrange(desc(FT))

# Jayson Tatum (400)

# What was Tatum's average score in a Boston win?
bos %>% filter(namePlayer == 'Jayson Tatum') %>% 
  group_by(outcomeGame) %>% 
  summarise(POINTS = mean(pts))

# 28.5 points.

# GGPLOT 2 + Histogram
bos %>% ggplot(aes(x=plusminus, fill = outcomeGame)) + 
  geom_histogram(color='black') +
  facet_wrap(~outcomeGame) +
  ggtitle('Player Point Differential in a Win/Loss', 'Season: 2021-22') +
  theme_bw()

# Histogram - Facet Grid
bos %>% ggplot(aes(x=plusminus, fill = outcomeGame)) + 
  geom_histogram(color='black') +
  facet_grid(vars(outcomeGame), vars(locationGame)) +
  ggtitle('Player Point Differential in a Win/Loss', 'Season: 2021-22') +
  theme_bw()

# Scatter Plot
bos %>% ggplot(aes(x=minutes, y=pts)) +
  geom_point()

bos %>% ggplot(aes(x=minutes, y=pts)) +
  geom_point() +
  geom_smooth(se = 0, method = 'lm')

# Scatter Plot - 2 trend lines
bos %>% ggplot(aes(x=minutes, y=pts, col = outcomeGame)) +
  geom_point() +
  geom_smooth(se = 0, method = 'lm')

# Scatter Plot - log transformation
bos %>% ggplot(aes(x=minutes, y=pts, col = outcomeGame)) +
  geom_point() +
  geom_smooth(se = 0, method = 'lm') +
  scale_y_log10()

# Bar Plot
# Effective Field Goal Percentage
new_data <- bos %>% group_by(namePlayer) %>% 
  summarise(EFG = (sum(fgm) + 0.5*sum(fg3m))/sum(fga),
            COUNT = n()) %>%
  filter(COUNT > 10) %>% 
  arrange(desc(EFG))

new_data %>% ggplot(aes(x=factor(namePlayer), y=EFG, fill=namePlayer)) +
  geom_col(show.legend = FALSE) +
  coord_flip()

# Box Plot
bos %>% ggplot(aes(x=namePlayer, y=pts, col=namePlayer)) +
  geom_boxplot(show.legend = FALSE) +
  coord_flip()

# Box Plot - interaction
bos %>% filter(minutes > 5) %>% 
  ggplot(aes(x=interaction(namePlayer, outcomeGame), y=pts, fill=outcomeGame)) +
  geom_boxplot(show.legend = FALSE) +
  coord_flip()

# Marginal Plot
plot <- bos %>% ggplot(aes(x=minutes, y=pts)) +
  geom_point() +
  geom_smooth(se = 0, method = 'lm')
ggMarginal(plot, type='histogram')

# Coorelation Matrix
coor_data <- bos %>% select(32:34, 37:40)
round(cor(coor_data), digits = 3)
corrplot(cor(coor_data),
         type = 'upper',
         method = 'number',
         number.cex = 1.5)

pairs.panels(coor_data, method='spearman')

