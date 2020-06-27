### Classification part

library(caret)

# Importing the dhfr data set

data(dhfr)

# Check to see if there are missing data?

sum(is.na(dhfr))

# To acheive reproducible model, set the random seed number

set.seed(100)

# Performs stratified random split of the data set

TrainingIndex <- createDataPartition(dhfr$Y, p=0.8, list = FALSE)
TrainingSet <- dhfr[TrainingIndex,]   # Training Set
TestingSet <- dhfr[-TrainingIndex,]   # Test Set



### SVM model (polynomical kernel)

Model <- train(Y ~., data = TrainingSet,
                  method = 'svmPoly',
                  na.action = na.omit,
                  preProcess = c("scale", "center"),
                  trControl = trainControl(method = "none"),
                  tuneGrid = data.frame(degree = 1, scale = 1, C = 1))


# Save model to RDS file



# Applying model for prediction

Model.training <- predict(Model, TrainingSet)  # Apply modle tomake prediction on Traiining Set
Model.testing <- predict(Model, TestingSet)    # Apply model to make prediction on Testing set


# Model performance: (Displays confusion matrix and statistics)

Model.training.confusion <- confusionMatrix(Model.training, TrainingSet$Y)
Model.testing.confusion <- confusionMatrix(Model.testing, TestingSet$Y)

print(Model.training.confusion)
print(Model.testing.confusion)

# Feature Importance

Importance <- varImp(Model)
plot(Importance, top= 30)
plot(Importance, top = 30, col = 'darkgreen')
