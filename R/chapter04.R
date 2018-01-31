####04-2 데이터 프레임 만들기####
#1. 변수 만들기
english <- c(90, 80, 60, 70)
english

math <- c(50, 60, 100, 20)
math

#2. 데이터 프레임 만들기
df_midterm <- data.frame(english, math)
df_midterm

#3. 반에 대한 정보 추가
class <- c(1, 1, 2, 2)
class

df_midterm <- data.frame(english, math, class)
df_midterm

#4. 분석하기
mean(df_midterm$english)

mean(df_midterm$math)

#5. 데이터 프레임 한 번에 만들기
df_midterm <- data.frame(english = c(90, 80, 60, 70),
                         math = c(50, 60, 100, 20),
                         class = c(1, 1, 2, 2))
df_midterm

####혼자서 해보기####
#Q1
df_fruit <- data.frame(fruit = c("사과", "딸기", "수박"),
                       price = c(1800, 1500, 3000),
                       volume = c(24, 38, 13))
df_fruit

#Q2
mean(df_fruit$price)
mean(df_fruit$volume)


####04-3 외부 데이터 이용하기####
install.packages("readxl")
library(readxl)

#read_excel()
#엑셀 파일을 데이터 프레임으로 만드는 기능
#첫 번째 행을 변수명으로 인식
df_exam <- read_excel("excel_exam.xlsx") 
df_exam

mean(df_exam$english)
mean(df_exam$science)

#변수명 없이 첫 번재 행부터 데이터 시작
df_exam_novar <- read_excel("excel_exam_novar.xlsx", col_names = F)
df_exam_novar

#엑셀 파일에 시트가 여러 개인 경우
df_exam_sheet <- read_excel("excel_exam_sheet.xlsx", sheet=3)
df_exam_sheet

#CSV 파일 불러오기
df_csv_exam <- read.csv("csv_exam.csv")
df_csv_exam

#데이터 프레임을 CSV 파일로 저장하기
df_midterm <- data.frame(english=c(90, 80, 60, 70),
                         math = c(50, 60, 100, 20),
                         class = c(1, 1, 2, 2))
df_midterm

write.csv(df_midterm, file="df_midterm.csv")

#RData 파일 활용하기
save(df_midterm, file="df_midterm.rda")

rm(df_midterm)
df_midterm
load("df_midterm.rda")
df_midterm

rm(df_exam)
rm(df_csv_exam)

df_exam <- read_excel("excel_exam.xlsx")
df_exam

df_csv_exam <- read.csv("csv_exam.csv")
df_csv_exam
