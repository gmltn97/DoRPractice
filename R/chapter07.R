####07-1 결측치 정제하기####
#결측치 찾기
df <- data.frame(sex = c("M", "F", NA, "M", "F"),
                 score = c(5, 4, 3, 4, NA))
df

is.na(df) #결측치는 TRUE

table(is.na(df))
table(is.na(df$sex)) #결측치 1개
table(is.na(df$score)) #결측치 1개

mean(df$score) #NA
sum(df$score) #NA

#결측치 제거하기
library(dplyr)
df %>% filter(is.na(score)) #결측치 있는 행 추출
df %>% filter(!is.na(score)) #score 결측치 제거

df_nomiss <- df %>% filter(!is.na(score))
mean(df_nomiss$score)
sum(df_nomiss$score)

df_nomiss <- df %>% filter(!is.na(score) & !is.na(sex)) #score, sex 결측치 제
df_nomiss

df_nomiss2 <- na.omit(df) #결측치 하나라도 있으면 제거
df_nomiss2

#함수의 결측치 제외 기능 이용하기
mean(df$score, na.rm=T)
sum(df$score, na.rm=T)

exam <- read.csv("csv_exam.csv")
exam[c(3, 8, 15), "math"] <- NA
exam
exam %>% summarise(mean_math = mean(math))
exam %>% summarise(mean_math = mean(math, na.rm=T))
exam %>% summarise(mean_math = mean(math, na.rm=T),
                   sum_math = sum(math, na.rm=T),
                   median_math = median(math, na.rm=T))

#결측치 대체하기#
#평균값으로 결측치 대체하기
mean(exam$math, na.rm=T)

exam$math <- ifelse(is.na(exam$math), 55, exam$math)
table(is.na(exam$math))
exam
mean(exam$math)

#혼자서 해보기#
mpg <- as.data.frame(ggplot2::mpg)
mpg[c(65, 124, 131, 153, 212), "hwy"] <- NA
#Q1
table(is.na(mpg$drv))
table(is.na(mpg$hwy))

#Q2
mpg %>% 
  filter(!is.na(hwy)) %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))


####07-2 이상치 정제하기####
#이상치 제거하기
outlier <- data.frame(sex = c(1, 2, 1, 3, 2, 1),
                      score = c(5, 4, 3, 4, 2, 6))
outlier

table(outlier$sex)
table(outlier$score)

outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)
outlier

outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)
outlier

outlier %>% 
  filter(!is.na(sex) & !is.na(score)) %>% 
  group_by(sex) %>% 
  summarise(mean_score = mean(score))

#이상치 제거하기 - 극단적인 값
#상자 그림으로 극단치 기준 정하기
boxplot(mpg$hwy)
boxplot(mpg$hwy)$stats #상자 그림 통계치 출력

#결측 처리하기
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy))

mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy, na.rm=T))

#혼자서 해보기#
mpg <- as.data.frame(ggplot2::mpg)
mpg[c(10, 14, 58, 93), "drv"] <- "k"
mpg[c(29, 43, 129, 203), "cty"] <- c(3, 4, 39, 42)

#Q1
table(mpg$drv)
mpg$drv <- ifelse(mpg$drv %in% c("4", "f", "r"), mpg$drv, NA)
table(mpg$drv)

#Q2
boxplot(mpg$cty)
boxplot(mpg$cty)$stats
mpg$cty <- ifelse(mpg $ cty < 9 | mpg $ cty > 26, NA, mpg$cty)
boxplot(mpg$cty)

#Q3
mpg %>% 
  filter(!is.na(drv) & !is.na(cty)) %>% 
  group_by(drv) %>% 
  summarise(mean_cty = mean(cty))
