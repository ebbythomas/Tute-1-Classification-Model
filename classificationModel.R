#'*Classification Model*
# This script is used to model a classification model in R. The input dataset is the popular IRIS dataset.


library(datasets)
library(caret)   # Includes more than 20 ML algorithms including the SVM algorithm.

# Importing the data---------
df <- iris

# Preliminary examonation------------
# Check the structure
# Check for any missing values
# If there are missing values, perform imputation

# Split between randomised train and test datasets---------

set.seed(4)
index   <-  sort(sample(nrow(df), nrow(df)*.8)) 

trainSet <- df[index,]
testSet  <- df[-index,]


# Modelling using the SVM --------

# This model will have the cross validation within the modelling
modelCV       <- train(Species ~., data = trainSet,
                   method = "svmPoly",     # Support Vector Machine - Polynomial Kernel
                   na.action = na.omit,    # NA values will be omitted from the model
                   preProcess = c("scale", "center"), # Data preprocessing. Scale = for each variable, mean value is computed and for each row, the mean is subtracted. 
                   trControl = trainControl(method = "cv", number = 10), # 10 fold cross validation. Cross validaiton to improve the learning.
                   # In learning process, in the first iteration, the trainSet is divided into 10 group. Group 1 is left out and the rest 9 groups does the prediction and test it on the 10th group.
                   # In the 2nd iteration, Group 2 alone is left out and rest 9 groups is modelled and predict the group 2. Similarly, we do 10 iteartions as it is 10-fold. Now its averaged for a good model.
                   tuneGrid = data.frame(degree = 1, scale = 1, C=1))

# This model will not have the cross validation within the modelling
modelNormal   <- train(Species ~., data = trainSet,
                   method = "svmPoly",
                   na.action = na.omit,
                   preProcess = c("scale", "center"),
                   trControl = trainControl(method ="none"),
                   tuneGrid = data.frame(degree = 1, scale = 1, C=1))


# Predicting in Train, Test datasets----------

predictionTrainSet     <- predict(modelNormal, trainSet) # Here we try to predict the model for the same trainSet we used for training.
predictionTestSet      <- predict(modelNormal, testSet) # Here we try to predict the model for the testSet..
predictionTrainSetCV   <- predict(modelCV, trainSet) # Here we try to predict the CV-ed model for the same trainSet we used for training.


# Confusion Matrix
# from the confusion Matrix, we will able to identify the false positive and false negatives.
modelTrainingConfusion   <- confusionMatrix(predictionTrainSet, trainSet$Species) # An ideal Confusion Matrix should be a diagonal Matrix
modelTestingConfusion    <- confusionMatrix(predictionTestSet, testSet$Species)
modelTestingCVConfusion  <- confusionMatrix(predictionTrainSet, trainSet$Species)
# We can also see the accuracy of the model. However, accuracy is not always the best indicator of performance of a model.

# Feature importance---------
# Here, we check the importance of each variable contributing to the model
importance = varImp(modelNormal)
plot(importance)
# Can see the importance of each variable to the model for all the three Species.




