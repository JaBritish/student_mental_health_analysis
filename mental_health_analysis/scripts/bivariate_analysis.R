#Bivariate relationships
#Comparing the association for variables against depression
#H0: no significant association vs H1: significant association
#Generates Crosstab and chi square tests of association
#Predictors vs Depression
for (col in names(Dataset[1:25])){
  cat("\n",col,"vs Depression:\n")
  tab<-table(Dataset[[col]],Dataset$DEPRESSION)
  prop<-prop.table(tab,margin = 1)*100
  print(round(prop,2))
  if(any(chisq.test(tab)$expected<5)){
    test<-fisher.test(tab)
    cat("Fisher's Exact Test p-value:",round(test$p.value,4),"\n")
    cat("Fisher's Test used due to small expected counts.\n")
  }else{
    test<-chisq.test(tab)
    cat("Chi-squared p-value:",round(test$p.value,4),"\n")
  }
}

#Predictors vs Anxiety
for (col in names(Dataset[1:25])){
  cat("\n",col,"vs Depression:\n")
  tab1<-table(Dataset[[col]],Dataset$ANXIETY)
  prop1<-prop.table(tab1,margin = 1)*100
  print(round(prop1,2))
  if(any(chisq.test(tab1)$expected<5)){
    test1<-fisher.test(tab1)
    cat("Fisher's Exact Test p-value:",round(test1$p.value,4),"\n")
    cat("Fisher's Test used due to small expected counts.\n")
  }else{
    test1<-chisq.test(tab1)
    cat("Chi-squared p-value:",round(test1$p.value,4),"\n")
  }
}


#Generating a visual plot of time spent on social media against depression
time_summary<-Dataset %>%
  count(TIME_SPENT_ON_SOCIAL_MEDIA,DEPRESSION) %>% 
  group_by(TIME_SPENT_ON_SOCIAL_MEDIA) %>% 
  mutate(percent = round(n/sum(n)*100,2))

#Bar chart stacked side by side
ggplot(time_summary, aes(x=TIME_SPENT_ON_SOCIAL_MEDIA,y=percent,fill= DEPRESSION))+
  geom_bar(stat = "identity",position = "dodge")+
  geom_text(aes(label = paste0(round(percent,1),"%")),
            position = position_dodge(width =0.9),vjust=-0.3, size = 3.5)+
  labs(title = "Depression across Time spent on social media",
       x="Time Spent on Social Media(hours)",
       y="Percentage",
       fill = "Depression Status")+
  scale_y_continuous(labels = scales::percent_format(scale = 1))+
  scale_fill_manual(values = c("1"= "#FF5733", "0"="#33C3FF"))+
  theme_minimal()+
  theme(plot.title = element_text(hjust=0.5))

#Mosaic plot of Depression against time spent
mosaicplot(table(Dataset$TIME_SPENT_ON_SOCIAL_MEDIA,Dataset$DEPRESSION),
           main = "Mosaic plot: Depression by Time Spent on Social Media",
           xlab = "Time Spent",
           ylab ="Depression", color = c("lightblue","tomato"))

#Generating a visual plot of time spent on social media against anxiety
time_summary1<-Dataset %>%
  count(TIME_SPENT_ON_SOCIAL_MEDIA,ANXIETY) %>% 
  group_by(TIME_SPENT_ON_SOCIAL_MEDIA) %>% 
  mutate(percent = round(n/sum(n)*100,2))

#Bar chart stacked side by side
ggplot(time_summary1, aes(x=TIME_SPENT_ON_SOCIAL_MEDIA,y=percent,fill= ANXIETY))+
  geom_bar(stat = "identity",position = "dodge")+
  geom_text(aes(label = paste0(round(percent,1),"%")),
            position = position_dodge(width =0.9),vjust=-0.3, size = 3.5)+
  labs(title = "Anxiety across Time spent on social media",
       x="Time Spent on Social Media(hours)",
       y="Percentage",
       fill = "Anxiety Status")+
  scale_y_continuous(labels = scales::percent_format(scale = 1))+
  scale_fill_manual(values = c("1"= "#FF5733", "0"="#33C3FF"))+
  theme_minimal()+
  theme(plot.title = element_text(hjust=0.5))

#Mosaic plot of Depression against time spent
mosaicplot(table(Dataset$TIME_SPENT_ON_SOCIAL_MEDIA,Dataset$ANXIETY),
           main = "Mosaic plot: Anxiety by Time Spent on Social Media",
           xlab = "Time Spent",
           ylab ="Anxiety", color = c("lightblue","tomato"))


#Visualizing the comparison of age with depression status
age_summary<-Dataset %>%
  count(AGE,DEPRESSION) %>% 
  group_by(AGE) %>% 
  mutate(percent = round(n/sum(n)*100,2))

#Bar chart showing proportions with bars side by side
ggplot(age_summary, aes(x=AGE,y=percent,fill= DEPRESSION))+
  geom_bar(stat = "identity",position = "dodge")+
  geom_text(aes(label = paste0(round(percent,1),"%")),
            position = position_dodge(width =0.9),vjust=-0.3, size = 3.5)+
  labs(title = "Depression across Age",
       x="Age",
       y="Percentage",
       fill = "Depression Status")+
  scale_y_continuous(labels = scales::percent_format(scale = 1))+
  scale_fill_manual(values = c("1"= "#FF5733", "0"="#33C3FF"))+
  theme_minimal()+
  theme(plot.title = element_text(hjust=0.5))

#Mosaic plot 
mosaicplot(table(Dataset$AGE,Dataset$DEPRESSION),
           main = "Mosaic plot: Depression by Age",
           xlab = "Age",
           ylab ="Depression", color = c("lightblue","tomato"))

