#Importing the data set from excel
install.packages("readxl")
library(readxl)
Dataset<-read_excel("C:/Users/Admin/Downloads/Exploring_the_Effect_of_Social_Media_and_Digital_Platforms_Usage_on_Psychosis_Depression_and_.xlsx")

#Loading required libraries for data cleaning
install.packages("dplyr")
library(dplyr)
install.packages("tidyverse")
library(tidyverse)

#Removing unwanted columns
#Subsetting from column 6:82
Dataset<-Dataset[,6:82]

#Still removing the unwanted columns
Dataset<-Dataset[,-c(5,15,16,23,24,25,33,35,39,43,44,53,54,62,63)]
Dataset<-Dataset[,-(49:58)]
Dataset<-Dataset[,-(49:52)]
Dataset<-Dataset[,-6]

#Convert the dataset to a dataframe
Dataset<-as.data.frame(Dataset) 

#Removing all rows with NAs from the data
Dataset<-na.omit(Dataset)

#Test to find if there is any NAs
colSums(is.na(Dataset))

#Data Wrangling
#Introducing the scores of PHQ-9 and GAD-7 scores by first adding the likert scale
Dataset[Dataset=="not_at_all"]<-0
Dataset[Dataset=="several_days"]<-1
Dataset[Dataset=="more_than_half_the_days"]<-2
Dataset[Dataset=="nearly_every_day"]<-3
Dataset[Dataset=="over_half_the_days"]<-2

#Convert the scale to numeric
Dataset[,33:47]<-lapply(Dataset[,33:47],as.integer)

#Sum to get the total for each scale
Dataset<-Dataset %>% mutate(GAD_7=rowSums(Dataset[,41:47]))
Dataset<-Dataset %>% mutate(PHQ_9=rowSums(Dataset[,33:40]))

#Finding the level of depression and anxiety
#Add the columns of levels to the dataframe
DEPRESSION<- ifelse(Dataset$PHQ_9<=12,"No","Yes")
ANXIETY<-ifelse(Dataset$GAD_7<=11,"No","Yes")
Dataset<-cbind(Dataset, DEPRESSION, ANXIETY)

#Eliminate unuseful variables to remain with the variable for depression and anxiety
Dataset<-Dataset[,-(33:49)]

#Renaming variables
names(Dataset)<-c("AGE","GENDER","COLLEGE_OF_STUDY","YEAR_OF_STUDY","TIME_SPENT_ON_SOCIAL_MEDIA",
                    "FACEBOOK","TIKTOK","X","INSTAGRAM","LINKEDIN","SNAPCHAT","OTHERS","STAYING_IN_TOUCH_WITH_FRIENDS","ENTERTAINMENT",
                    "EDUCATION","NETWORKING","PERSONAL_UPDATES","OTHERS","MEMES_AND_HUMOR","NEWS_AND_CURRENT_EVENTS",
                    "EDUCATIONAL_CONTENT","FITNESS_AND_HEALTH","TRAVEL_AND_LIFESTYLE","FASHION_AND_BEAUTY","OTHERS","FREQUENCY_OF_SOCIAL_MEDIA_USE",
                    "SOCIAL_MEDIA_IMPACT_ON_ACADEMICS","FEELING_ON_SOCIAL_MEDIA_NEGATIVE_IMPACT","SOCIAL_MEDIA_PROFILES","TYPE_OF_CONTENT","MISSING_STUDIES","IMPACT","DEPRESSION","ANXIETY")

#Removing columns that won't be useful
Dataset<-Dataset[,-c(12,18,25,28,29,31,32)]

#Changing the format of the age to categorical variable with the various classes
Dataset[Dataset=="1821"]<-"18-21"
Dataset[Dataset=="2225"]<-"22-25"
Dataset[Dataset=="under_18"]<-"<18"
Dataset[Dataset=="over_25"]<-"25>"

#Correct format for time spent
Dataset[Dataset=="1_3_hours"]<-"1-3"
Dataset[Dataset=="3_5_hours"]<-"3-5"
Dataset[Dataset=="more_than_5_hours"]<-"5>"
Dataset[Dataset=="less_than_1_hour"]<-"<1"

#Data cleaning and Data Wrangling done.
#Data wrangling the variables to the correct format for proper analysis
Dataset$AGE<-factor(Dataset$AGE, ordered = TRUE, levels =c("<18","18-21","22-25","25>"))
Dataset$GENDER<-factor(Dataset$GENDER)
Dataset$COLLEGE_OF_STUDY<-factor(Dataset$COLLEGE_OF_STUDY)
Dataset$YEAR_OF_STUDY<-factor(Dataset$YEAR_OF_STUDY,ordered = TRUE,
                                levels = c("1st_year","2nd_year","3rd_year","4th_year_or_above"))
Dataset$TIME_SPENT_ON_SOCIAL_MEDIA<-factor(Dataset$TIME_SPENT_ON_SOCIAL_MEDIA,ordered = TRUE,
                                             levels = c("<1","1-3","3-5","5>"))

#Converting the variables 6:22 of the data frame to factors with ordered levels
for(i in 6:22){
  Dataset[[i]]<-factor(Dataset[[i]], ordered=TRUE,levels=c("0","1"))
}  

#Converting variables to factors
Dataset$FREQUENCY_OF_SOCIAL_MEDIA_USE<-factor(Dataset$FREQUENCY_OF_SOCIAL_MEDIA_USE, ordered = TRUE,
                                                levels = c("rarely","sometimes","frequently","almost_always"))
Dataset$SOCIAL_MEDIA_IMPACT_ON_ACADEMICS<-factor(Dataset$SOCIAL_MEDIA_IMPACT_ON_ACADEMICS, ordered =FALSE)
Dataset$TYPE_OF_CONTENT<-factor(Dataset$TYPE_OF_CONTENT,ordered = FALSE)
Dataset$DEPRESSION<-factor(Dataset$DEPRESSION,ordered=TRUE,labels = c(0,1), levels = c("No","Yes"))
Dataset$ANXIETY<-factor(Dataset$ANXIETY,ordered = TRUE, labels = c(0,1), levels = c("No","Yes"))

structure(Dataset)
head(Dataset)

#Writing my dataset to the folder
write.csv(Dataset, "C:/Users/Admin/Desktop/mental_health_analysis/data/Cleaned data/Dataset.csv", row.names = FALSE)
