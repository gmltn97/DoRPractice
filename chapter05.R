####05-1 데이터 파악하기####
exam <- read.csv("csv_exam.csv")

head(exam) #앞에서 6행까지 출력
head(exam, 10)

tail(exam) #뒤에서부터 6행 출력
tail(exam, 10)

View(exam) #뷰어 창에서 데이터 확인하기

dim(exam) #데이터가 몇 행, 몇 열로 구성

str(exam) #속성 파악하기

summary(exam) #요약 통계량 산출하기

#mpg 데이터 파악하기
mpg <- as.data.frame(ggplot2::mpg)
head(mpg)
tail(mpg)
View(mpg)
dim(mpg)
str(mpg)
summary(mpg) #문자: 값의 개수(length), 변수 속성(class, mode)


####05-2 변수명 바꾸기####
df_raw <- data.frame(var1 = c(1, 2, 1),
                     var2 = c(2, 3, 2))
df_raw

install.packages("dplyr")
library(dplyr)

df_new <- df_raw #복사본 생성
df_new

df_new <- rename(df_new, v2=var2)
df_raw
df_new


####혼자서 해보기####
#Q1
mpg <- as.data.frame(ggplot2::mpg)
mpg_new <- mpg
#Q2
mpg_new <- rename(mpg_new, city=cty, highway=hwy)
#Q3
head(mpg_new)


####05-3 파생변수 만들기####
df <- data.frame(var1 = c(4, 3, 8),
                 var2 = c(2, 6, 1))
df

df$var_sum <- df$var1 + df$var2
df

df$var_mean <- (df$var1 + df$var2) / 2
df

#mpg 통합 연비 변수 만들기
mpg$total <- (mpg$cty + mpg$hwy) / 2
head(mpg)
mean(mpg$total) #통합 연비 변수의 평균


#조건문을 활용해 파생변수 만들기
#1. 기준값 정하기
summary(mpg$total)
hist(mpg$total)

#2. 합격 판정 변수 만들기
mpg$test <- ifelse(mpg$total >= 20, "pass", "fail")
head(mpg, 20)

#3. 빈도표로 합격 파정 자동차 수 살펴보기
table(mpg$test) #데이터의 갯수

#4. 막대 그래프로 빈도 표현하기
library(ggplot2)
qplot(mpg$test) #값의 갯수를 막대의 길이로 표현


#중첩 조건문 활용하기
#1. grade 변수 생성
mpg$grade <- ifelse(mpg$total >= 30, "A",
                    ifelse(mpg$total >= 20, "B", "C"))
head(mpg, 20)

#2. 빈도표, 막대 그래프로 연비 등급 살펴보기
table(mpg$grade) #빈도표
qplot(mpg$grade) #등급 빈도 막대 그래프

#원하는 만큼 범주 만들기
mpg$grade2 <- ifelse(mpg$total >= 30, "A",
                     ifelse(mpg$total >= 25, "B",
                            ifelse(mpg$total >= 20, "C", "D")))
head(mpg, 10)

table(mpg$grade2)
qplot(mpg$grade2)


####분석 도전!####
#문제1
midwest <- as.data.frame(ggplot2::midwest)
head(midwest)
tail(midwest)
View(midwest)
dim(midwest)
str(midwest)
summary(midwest)

#문제2
library(dplyr)
midwest <- rename(midwest, total=poptotal, asian=popasian)
View(midwest)

#문제3
midwest$asia_percent = midwest$asian / midwest$total * 100
View(midwest)
hist(midwest$asia_percent)

#문제4
mean(midwest$asia_percent)
midwest$asia_average <- ifelse(midwest$asia_percent > 0.4872462, "large", "small")
head(midwest)

#문제5
table(midwest$asia_average)
library(ggplot2)
qplot(midwest$asia_average)
