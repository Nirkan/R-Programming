### Loading iris data set

## Method 1

library(datasets)
data(iris)

iris <- datasets::iris


## Method 2 

library(RCurl)
#iris = read.csv(text = getURL("website where iris.csv file is present in raw form")

## View the data

View(iris)

### Display summary statistics

# head() / tail()

head(iris, 4)
tail(iris, 4)

# Summary()

summary(iris)
summary(iris$Sepal.Length)


# Check to see if there are missing data?

sum(is.na(iris))


# skimr() - expands on summary 

install.packages("skimr")
library(skimr)

# Group data by Species then perform skim
iris %>%
  dplyr::group_by(Species) %>%
  skim()



### Quick data visualization

# R base plot()

plot(iris)
plot(iris, col = 'darkorange')

# scatter plot

plot(iris$Sepal.Width, iris$Sepal.Length)

plot(iris$Sepal.Width, iris$Sepal.Length, col = "red")

plot(iris$Sepal.Width, iris$Sepal.Length, col = "red",
     xlab = "Sepal Width", ylab = "Sepal length")


# Histogram

hist(iris$Sepal.Width)
hist(iris$Sepal.Width, col = "blue", xlab = "Sepal Width")


# Feature plots

install.packages("caret")
library(caret)

featurePlot(x = iris[,1:4],
            y = iris$Species,
            plot = "box",
            strip = strip.custom(par.strip.text = list(cex = .7)),
            scales = list(x = list(relation = "free"),
                          y = list(relation = "free")))
            