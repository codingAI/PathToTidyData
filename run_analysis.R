library(dplyr)

## reading the test files

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")


## reading the training files

X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

## reading the features files
var_names <- read.table("./UCI HAR Dataset/features.txt")
var_names <- var_names[,2]

## rename the variable with the correct labels in X_train and X_test
names(X_train)<-var_names
names(X_test)<-var_names

## merge the testing files

### rename the columns
names(y_test) <- "y_test"
names(subject_test)<-"subject_test"

### bind them
test_set <- cbind(subject_test,y_test)


## merge the training files

### rename the columns
names(y_train) <- "activity_id"
names(subject_train)<-"subject_id"

### bind themt
train_set <- cbind(subject_train,y_train)
train_set <- cbind(train_set, X_train)


## merge the testing files

### rename the columns
names(y_test) <- "activity_id"
names(subject_test)<-"subject_id"

### bind them
test_set <- cbind(subject_test,y_test)
test_set <- cbind(test_set, X_test)

## merge the test and train data into a single data frame

full_set <- rbind(train_set,test_set) 

## keep only the mean() and std() measurement

incl_mean <- grep("mean()",var_names,value=TRUE,fixed=TRUE)
incl_std <- grep("std()",var_names,value=TRUE,fixed=TRUE)
incl_mean_std <-c(incl_mean,incl_std)
incl_full <-c("subject_id","activity_id",incl_mean_std)
full_set<-full_set[,incl_full]

## relabel activity_id with activity names (using helper function)

## provide helper function for activity names
nameactivity <-function(number){
    value = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
    value[number]
}
full_set$activity_id <- nameactivity(full_set$activity_id)

## function to produce the tidy dataset out of the full data set

producetidy <- function(data){
    ## group by subject and activity into a new data set
    tidy_data <- group_by(data, subject_id,activity_id)
    
    ## summarize by mean on each of the remaining variables
    tidy_data <- summarise_each(tidy_data,funs(mean)) 
}

## PRODUCE it and save it as text file 
tidy_set <- producetidy(full_set)

write.table(tidy_set,file="tidy_set.txt",row.names = FALSE)





