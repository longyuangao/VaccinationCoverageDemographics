library(tidyverse)
#covid cases plot
covid2 <- read.csv("./data/raw/United_States_COVID-19_Cases.csv")
covid2 <- covid2[-which(covid2$tot_cases == 0 |is.na(covid2$tot_cases)),]
covid2 <- covid2 %>% dplyr::select(submission_date, state, new_case)
covid_time2 <- group_by(covid2,submission_date)
new_cases <- summarize(covid_time2, sum(new_case))
new_cases <- rename(new_cases, new_case='sum(new_case)')
new_cases$submission_date <- as.Date(new_cases$submission_date, format = "%m/%d/%Y")
new_cases <- arrange(new_cases,submission_date)
ggplot(new_cases, aes(submission_date, new_case)) + 
  geom_smooth(method = "loess", span = .05, se = FALSE)

#flu shot coverage rate plot
coverage_rate <- read.csv("./data/clean/us_by_year.csv")
coverage_rate <- rename(coverage_rate, estimation='Estimate....')
coverage_rate$ym <- as.Date(coverage_rate$ym, format = "%m/%d/%Y")
ggplot(coverage_rate, aes(ym, estimation)) + 
  geom_smooth(method = "loess", span = .05, se = FALSE)