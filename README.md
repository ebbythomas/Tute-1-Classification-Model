#Data Processing

Run the file dataProcessing.jl. This will feed in the raw data recs2009_public, as well as call all other data processing functions
At the end of data processing, we will get three files - train set, (train.csv) validation set (valid.csv) and test set (test.csv)
Note that this code block has been designed so that it is appropriate for use in a general use case. However, contextual aggregation performed in 'contextAgg.jl' file is specifically suited for the specific dataset as well as the application. This code block, henceforth will vary widely depending on the dataset encountered as well as the application.

#Stepwise Regression

Run the file stepReg.
At the start of stepwise regression, we import train, validation and test sets obtained at the end of data prcessing.
Varying values of 'i' for the iteration yields different models with different number of variables.
After complete iteration so that only the most significant one variable remains in the model, we proceed towards the graph to obtain the knee point. Then the loop has to be initiated again to obtain the best variables identified at the knee point.
The association between models (variables) are found out using fishersTest.jl, which is called within the file.
