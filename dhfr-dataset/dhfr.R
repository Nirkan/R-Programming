# Importin libraries

library(datasets)
library(caret)


# Importing the Iris data set
data(iris)

# Check to see if there are missing data?
sum(is.na(iris))

# set the random seed number, To achieve reproducible model.
set.seed(100)

# Performing stratified random split of the dataset

TrainingIndex <- createDataPartition(iris$Species, p=0.8, list = FALSE)
TrainingSet <- iris[TrainingIndex,]      # Training set
TestingSet <- iris[-TrainingIndex,]      # Testing set



# SVM model (polynomial kernel)

Model <- train(Species ~., data = TrainingSet,
               method = "svmPoly",
               na.action = na.omit,
               preProcess = c("scale", "center"),
               trControl = trainControl(method = "none"),
               tuneGrid = data.frame(degree=1, scale=1, C=1)
)


# Build CV model

Model.cv <- train(Species ~., data = TrainingSet,
                  method = "svmPoly",
                  na.action = na.omit,
                  preProcess = c("scale", "center"),
                  trControl  = trainControl(method = "cv", number = 10),
                  tuneGrid = data.frame(degree = 1, scale = 1, C = 1)
                  )



# Apply model for prediction

Model.training <- predict(Model, TrainingSet)  # Applying Model to perform prediction on training
Model.testing <- predict(Model, TestingSet)    # Applying Model to perform prediction on testing
Model.cv <- predict(Model.cv, TrainingSet)     # Performing cross validation


# Model performance (Displays statistics and the confusion matrix )

Model.training.confusion <- confusionMatrix(Model.training, TrainingSet$Species)
Model.testing.confusion <- confusionMatrix(Model.testing, TestingSet$Species)
Model.cv.confusion <- confusionMatrix(Model.cv, TrainingSet$Species)

print(Model.training.confusion)
print(Model.testing.confusion)
print(Model.cv.confusion)

# Feature importance

Importance <- varImp(Model)
plot(Importance)
plot(Importance, col = "violet")
