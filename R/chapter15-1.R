####15-1 R 내장 함수로 데이터 추출하기####
#행 번호로 행 추출하기#
exam <- read.csv("D:/RProjects/DoRPractice/csv_exam.csv")
exam[]
exam[1,] #1행 추출
exam[2,] #2행 추출

#조건을 충족하는 행 추출하기#
#내장 함수에서는 변수명 앞에 데이터 프레임 이름 반복
exam[exam$class == 1,]
exam[exam$math >= 80,]
exam[exam$class == 1 & exam$math >= 50,]
exam[exam$english < 90 | exam$science < 50,]

#열 번호로 변수 추출하기#
exam[,1] #첫 번째 열 추출
exam[,2]
exam[,3]

#변수명으로 변수 추출하기#
exam[,"class"]
exam[,"math"]
exam[,c("class", "math", "english")] #여러 변수 동시 추출

#행, 변수 동시 추출하기#
exam[1, 3]
exam[5, "english"]
exam[exam$math >= 50, "english"]
exam[exam$math >= 50, c("english", "science")]

#dplyr과 내장 함수의 차이#
#수학 점수 50 이상, 영어 점수 80 이상인 학생들을 대상으로 각 반의 전 과목 총평균 구하기

#내장 함수 코드
exam$tot <- (exam$math + exam$english + exam$science) / 3
aggregate(data = exam[exam$math >= 50 & exam$english >= 80,], tot ~ class, mean) #범주별 요약 통계량 구하는 내장 함수

#dplyr 코드
library(dplyr)
exam %>% 
  filter(math >= 50 & english >= 80) %>% 
  mutate(tot = (math + english + science) / 3) %>% 
  group_by(class) %>% 
  summarise(mean = mean(tot))

#혼자서 해보기#
mpg <- as.data.frame(ggplot2::mpg)

mpg %>% 
  mutate(tot = (cty + hwy) / 2) %>% 
  filter(class == "compact" | class == "suv") %>% 
  group_by(class) %>% 
  summarise(mean_tot = mean(tot))

#Q1
mpg$tot <- (mpg$cty + mpg$hwy) / 2

df_comp <- mpg[mpg$class == "compact",]
df_suv <- mpg[mpg$class == "suv",]

mean(df_comp$tot)
mean(df_suv$tot)
