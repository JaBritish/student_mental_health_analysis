#Fitting a binary logistic regression
logit_model<-glm(DEPRESSION~AGE+GENDER+COLLEGE_OF_STUDY+YEAR_OF_STUDY+
                   TIME_SPENT_ON_SOCIAL_MEDIA+FACEBOOK+TIKTOK+X+INSTAGRAM+
                   LINKEDIN+SNAPCHAT+STAYING_IN_TOUCH_WITH_FRIENDS+
                   ENTERTAINMENT+EDUCATION + NETWORKING+PERSONAL_UPDATES+
                   MEMES_AND_HUMOR+NEWS_AND_CURRENT_EVENTS+EDUCATIONAL_CONTENT+
                   FITNESS_AND_HEALTH+TRAVEL_AND_LIFESTYLE+FASHION_AND_BEAUTY+
                   FREQUENCY_OF_SOCIAL_MEDIA_USE+TYPE_OF_CONTENT, family = binomial, data = Dataset)

summary(logit_model)

#Correcting the l,q,c error
for (i in 1:25){
  contrasts(Dataset[[i]])<-contr.treatment(levels(Dataset[[i]]))
}
#Run the glm code again

#Getting the odds ratios and confidence intervals
exp(cbind(OR=coef(logit_model),confint(logit_model)))

#Picking the model that best fits
step_model<-step(logit_model, direction = "both")
summary(step_model)


#Fitting a binary logistic regression for Anxiety
logit_model1<-glm(ANXIETY~AGE+GENDER+COLLEGE_OF_STUDY+YEAR_OF_STUDY+
                    TIME_SPENT_ON_SOCIAL_MEDIA+FACEBOOK+TIKTOK+X+INSTAGRAM+
                    LINKEDIN+SNAPCHAT+STAYING_IN_TOUCH_WITH_FRIENDS+
                    ENTERTAINMENT+EDUCATION + NETWORKING+PERSONAL_UPDATES+
                    MEMES_AND_HUMOR+NEWS_AND_CURRENT_EVENTS+EDUCATIONAL_CONTENT+
                    FITNESS_AND_HEALTH+TRAVEL_AND_LIFESTYLE+FASHION_AND_BEAUTY+
                    FREQUENCY_OF_SOCIAL_MEDIA_USE+TYPE_OF_CONTENT, family = binomial, data = Dataset)

summary(logit_model1)

#Getting the odds ratios and confidence intervals
exp(cbind(OR=coef(logit_model1),confint(logit_model1)))

#Picking the model that best fits
step_model1<-step(logit_model1, direction = "both")

summary(step_model1)

#Testing the goodness of model fit 
#H0: Base model is true vs H1: Current model is true
#Install package for the hosmer-lemeshow test
install.packages("ResourceSelection")
library(ResourceSelection)

# Convert outcome to binary numeric of 0 and 1
#Hosmer-lemeshow test for depression model
hoslem.test(as.numeric(Dataset$DEPRESSION)-1, fitted(logit_model),g=10)

#Hosmer-Lemeshow test for anxiety model
hoslem.test(as.numeric(Dataset$ANXIETY)-1, fitted(logit_model1),g=10)

#Pseudo R^2 test
install.packages("pscl")
library(pscl)

#Depression model
pR2(logit_model)

#Anxiety model
pR2(logit_model1)



#Using classification table and accuracy
#Predicted probabilities for depression model
predicted<-ifelse(predict(logit_model, type = "response")>0.5,1,0)
#Actual values
actual<-Dataset$DEPRESSION
#Confusion matrix
table(Predicted=predicted,Actual = actual)

#Accuracy
mean(predicted==actual)

#Using classification table and accuracy
#Predicted probabilities for anxiety model
predicted1<-ifelse(predict(logit_model1, type = "response")>0.5,1,0)
#Actual values
actual1<-Dataset$ANXIETY
#Confusion matrix
table(Predicted=predicted1,Actual = actual1)

#Accuracy
mean(predicted1==actual1)


#ROC Curve and AUC
install.packages("pROC")
library(pROC)
#Depression model
roc_obj<-roc(actual,predict(logit_model,type = "response"))
plot(roc_obj)
auc(roc_obj)

#Anxiety model
roc_obj1<-roc(actual1,predict(logit_model1,type = "response"))
plot(roc_obj1)
auc(roc_obj1)

