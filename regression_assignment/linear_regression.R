############## Helper Functions & Library Packages #############################

# Define the functions that evaluate model accuracy
# Mean Absolute Error
mae <- function(a, b) {
 response <- sum(abs(a - b))
 return(response)
}
# *** Mean Squared Error ***
mse <- function(a, b) {
 response <- sum((a - b)^2) / length(a)
 return(response)
}

# Activate required library packages for later use
#library(glmnet)
library(ROCR)

############## Data Preparation ################################################

# Load the data that will be used to train the model
train.data <- read.csv('train.csv')

# Update the distribution qualities of the target variable using log
train.data$Log_Sal <- log(train.data$SalaryNormalized)

# Randomly select fold assignments for n-fold cross-validation
set.seed(1234)
train.data$fold <- sample(1:10, nrow(train.data), replace=TRUE)

# create subsets of the data for training and initial testing
train <- subset(train, fold != 3)
test <- subset(test, fold == 3)


############## MODEL TRAINING ##################################################

# create models for quantifying variable relationships 
model <- lm(Log_Sal ~ ., data=train)
model1_rsqr <- summary(model)$r.squared

model2 <- update(model, .~. -Title)
model2_rsqr <- summary(model2)$r.squared

model3 <- update(model2, .~. -SourceName)
model3_rsqr <- summary(model3)$r.squared

model4 <- update(model3, .~. -ContractType)
model4_rsqr <- summary(model4)$r.squared


test.data <- read.csv('test.csv')

final_model <- lm(Log_Sal ~ LocationNormalized 
                  + ContractTime 
                  + Company 
                  + Category, 
                  data=train.data)

predictions <- predict(final_model, test.data)

test.data[1,]


