#Creating a forest plot
#Extracting odds ratios from the model
OR<-exp(coef(logit_model))

#Get 95% confidence intervals
CI<-exp(confint(logit_model))

#Combine into a data frame
forest_df<-data.frame(
  Variable = names(OR),
  OR = OR,
  Lower_CI=CI[,1],
  Upper_CI=CI[,2]
)


#Binary logistic model for depression
library(ggplot2)

ggplot(forest_df, aes(x=reorder(Variable,OR),y=OR))+
  geom_point(size=3, color ="#0072B2")+
  geom_errorbar(aes(ymin = Lower_CI,ymax = Upper_CI), width = 0.2 , color= "#0072B2")+
  geom_hline(yintercept = 1,linetype = "dashed", color = "red")+
  coord_flip()+
  theme_minimal(base_size = 13)+
  labs(
    title = "Forest plot of Odds Ratios",
    x = "Predictors",
    y = "Odds Ratio (95% CI)"
  )
#Interpretation: Red line is when 0R=1. The horizontal line is the confidence interval, 
#if it passes through the red line(OR=1) then variable is not statistically significant.
#The blue dot is the OR of the variable. If OR is on the right of the red line then OR>1 
#thus strong positive association. OR on the left shows negative association since OR<1.


#Binary logistic model for anxiety

#Extracting odds ratios from the model
OR1<-exp(coef(logit_model1))
#Get 95% confidence intervals
CI1<-exp(confint(logit_model1))
#Combine into a data frame
forest_df1<-data.frame(
  Variable = names(OR1),
  OR = OR1,
  Lower_CI=CI1[,1],
  Upper_CI=CI1[,2]
)


ggplot(forest_df1, aes(x=reorder(Variable,OR),y=OR))+
  geom_point(size=3, color ="#0072B2")+
  geom_errorbar(aes(ymin = Lower_CI,ymax = Upper_CI), width = 0.2 , color= "#0072B2")+
  geom_hline(yintercept = 1,linetype = "dashed", color = "red")+
  coord_flip()+
  theme_minimal(base_size = 13)+
  labs(
    title = "Forest plot of Odds Ratios",
    x = "Predictors",
    y = "Odds Ratio (95% CI)"
  )
#Interpretation: Red line is when 0R=1. The horizontal line is the confidence interval, 
#if it passes through the red line(OR=1) then variable is not statistically significant.
#The blue dot is the OR of the variable. If OR is on the right of the red line then OR>1 
#thus strong positive association. OR on the left shows negative association since OR<1.


