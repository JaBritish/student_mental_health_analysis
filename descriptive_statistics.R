#frequency distributions for categorical variables
#Compute the descriptive statistics in terms of frequencies and proportions
#Count data for all categorical variables
summary(Dataset)

#Proportions in percent for each category
for (col_name in names(Dataset)){
  cat("\n Proportions for:", col_name, "\n")
  print(round(prop.table(table(Dataset[[col_name]]))*100,2))
}

#Proportions of mental health outcomes among predictors
#Depression
for (col in names(Dataset[1:25])){
  cat("\n",col,"vs Depression:\n")
  tab<-table(Dataset[[col]],Dataset$DEPRESSION)
  prop<-prop.table(tab,margin = 1)*100
  print(round(prop,2))
}


#Anxiety
for (col in names(Dataset[1:25])){
  cat("\n",col,"vs Anxiety:\n")
  tab1<-table(Dataset[[col]],Dataset$ANXIETY)
  prop1<-prop.table(tab1,margin = 1)*100
  print(round(prop1,2))
}

