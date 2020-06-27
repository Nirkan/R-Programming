### Classification part

library(caret)

# Importing the dhfr data set

data(dhfr)

# Check to see if there are missing data?

sum(is.na(dhfr))


# If the data is clean, introduce random NA to the dataset

na.gen <- function(data, n){
  i <-1
  while (i < n+1) {
    idx1 <- sample(1:nrow(data), 1)
    idx2 <- sample(1:ncol(data), 1)
    data[idx1, idx2] <- NA
    i = i + 1
  }
  return(data)
}


# Choose 1 of the following

dhfr <- dhfr[,-1]         # Removing first column

dhfr <- na.gen(data = dhfr, n = 100)

dhfr <- na.gen(dhfr, 100)


# check the missing values again

sum(is.na(dhfr))

colSums(is.na(dhfr))    # which column contain NA

str(dhfr)

View(colSums(is.na(dhfr)))        # shows how many NA values in each column

# Lists rows with missing data

missingdata <- dhfr[!complete.cases(dhfr), ]

sum(is.na(missingdata))

View(missingdata)


# Simply delete all entries with missing data

clean.data <- na.omit(dhfr)

sum(is.na(clean.data))


## Imputation : Replace missing values with the column's

# Mean

dhfr.impute <- dhfr

for (i in which(sapply(dhfr.impute, is.numeric))) {
  dhfr.impute[is.na(dhfr.impute[ ,i]), i] <- mean(dhfr.impute[ ,i], na.rm = TRUE)
}

sum(is.na(dhfr.impute))


# Median

dhfr.impute <- dhfr

for (i in which(sapply(dhfr.impute, is.numeric))) {
  dhfr.impute[is.na(dhfr.impute[ ,i]), i] <- median(dhfr.impute[ ,i], na.rm = TRUE)
}


sum(is.na(dhfr.impute))
