#Testing the interaction effects between anxiety and depression
#Recode outcome variable
#Create a combined outcome variable with 4 categories
Dataset$MENTAL_STATUS<-with( Dataset, 
                               ifelse(DEPRESSION==0 & ANXIETY==0,0,
                                      ifelse(DEPRESSION==1 & ANXIETY==0,1,
                                             ifelse(DEPRESSION==0 & ANXIETY==1,2,3))))

#Convert to factor
Dataset$MENTAL_STATUS<-factor(Dataset$MENTAL_STATUS,
                                levels = c(0,1,2,3),
                                labels = c("None","Depression Only","Anxiety Only","Both"))

#install packages to run multinomial regression
install.packages("nnet")
library(nnet)

#Fit the multinomial model
multi_model<-multinom(MENTAL_STATUS~AGE+GENDER+COLLEGE_OF_STUDY+YEAR_OF_STUDY+
                        TIME_SPENT_ON_SOCIAL_MEDIA+FACEBOOK+TIKTOK+X+INSTAGRAM+
                        LINKEDIN+SNAPCHAT+STAYING_IN_TOUCH_WITH_FRIENDS+
                        ENTERTAINMENT+EDUCATION + NETWORKING+PERSONAL_UPDATES+
                        MEMES_AND_HUMOR+NEWS_AND_CURRENT_EVENTS+EDUCATIONAL_CONTENT+
                        FITNESS_AND_HEALTH+TRAVEL_AND_LIFESTYLE+FASHION_AND_BEAUTY+
                        FREQUENCY_OF_SOCIAL_MEDIA_USE+TYPE_OF_CONTENT, data = Dataset)

#Gives output of the model as log odds
summary(multi_model)

#Gives the odd ratios 
exp(coef(multi_model))

#Testing the multinomial regression
#Pseudo R^2 McFadden's test
#Null model(intercept only)
null_model<-multinom(MENTAL_STATUS~1, data = Dataset)
#McFadden's R^2
1-logLik(multi_model)/logLik(null_model)

#Predicted classes and confusion matrix
predicted_classes<-predict(multi_model)

#Compare predicted and actual 
table(Predicted=predicted_classes,Actual=Dataset$MENTAL_STATUS)

#Calculating accuracy
mean(predicted_classes==Dataset$MENTAL_STATUS)


