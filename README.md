# Social Media and Mental Health: A Data Analysis Project
# Overview
This project investigates the relationship between social media use and mental health outcomes(depression and anxiety) among university students. The analysis uses logistic regression modelling to uncover patterns, risk factors, and behavioral predictors that are statistically associated with mental health status.
The dataset consists of 389 survey responses collected from university students including information on demographics, social media use habits, and indicators of anxiety and depression. 
# Objectives
- Explore how social media usage is associated with depression and anxiety
- Identify key predictors of poor mental health outcomes
- Fit and interpret binary and multinomial logistic regression models
- Visualize predicted probabilities for predicted outcomes
- Showcase practical data science and statistical modeling skills

# Variables
# Dependent Variables
- Depression - Binary(Yes/No)
- Anxiety - Binary(Yes/No)
- Mental Status - Multiclass outcome:
  * None
  * Depression only
  * Anxiety only
  * Both
# Predictor Variables
- AGE, GENDER, YEAR_OF_STUDY, COLLEGE_OF_STUDY
- TIME_SPENT_ON_SOCIAL_MEDIA, FREQUENCY_OF_SOCIAL_MEDIA_USE
- Use of platforms: SNAPCHAT, INSTAGRAM, FACEBOOK, X, LINKEDIN, TIKTOK
- Purpose of use: STAYING_IN_TOUCH_WITH_FRIENDS, ENTERTAINMENT, EDUCATION, NETWORKING, PERSONAL_UPDATES
- Type of consumption: consuming, creating, both_equally
- Content type: MEMES_AND_HUMOR, NEWS_AND_CURRENT_EVENTS, EDUCATIONAL_CONTENT, FITNESS_AND_HEALTH, TRAVEL_AND_LIFESTYLE, FASHION_AND_BEAUTY
- Social media impact on academics
# Tools and Packages used
- tidyverse (data manipulation & wrangling)
- nnet (multinomial logistic regression)
- ResourceSelection (Hosmer - Lemeshow test)
- pROC (ROC/AUC evaluation)
- effects (predicted probabilities)
- ggplot2 (visualization)
# Methodology
- Data cleaning
   * Removed missing values
   * Recorded variables into factors
   * Ensured ordered levels where applicable
- Descriptive statistics
    * Frequency distributions for categorical variables
    * Proportion of mental health outcomes by demographic and behavioral groups
 - Bivariate Analysis
    * Cross tabulations
    * Chi - square tests of associations
    * Proportional bar charts with statistical interpretation
  - Modeling
     * Binary Logistic Regression for DEPRESSION and ANXIETY
     * Multinomial Logistic Regression for combined MENTAL_STATUS
     * Variable selection using stepwise methods
     * Interpretation via odds ratios and confidence intervals
 - Model Diagnostics
   * Hosmer - Lemeshow test (Goodness-of-fit)
   * McFadden's Pseudo R^2
   * Accuracy and ROC AUC scores
- Visualization
   * Forest plots of odd ratios
   * Bar charts of demographic variables
   * Mosaic plots showing proportions of mental health outcomes in categorical variables
# Key Results

