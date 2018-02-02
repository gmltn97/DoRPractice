####'한국복지패널데이터' 분석 준비하기####
#1. 데이터 준비하기
#2. 패키지 설치 및 로드하기
install.packages("foreign")

library(foreign) #SPSS 파일 불러오기
library(dplyr) #전처리
library(ggplot2) #시각화
library(readxl) #엑셀 파일 불러오기
 
#3. 데이터 불러오기
raw_welfare <- read.spss(file = "Koweps_hpc10_2015_beta1.sav", to.data.frame=T)기
#   복사본 만들기
welfare <- raw_welfare

#4. 데이터 검토하기
head(welfare)
tail(welfare)
View(welfare)
dim(welfare)
str(welfare)
summary(welfare)

#5. 변수명 바꾸기
welfare <- rename(welfare,
                  sex = h10_g3,
                  birth = h10_g4,
                  marriage = h10_g10,
                  religion = h10_g11,
                  income = p1002_8aq1,
                  code_job = h10_eco9,
                  code_region = h10_reg7)

####데이터 분석 절차####
#1. 변수 검토 및 전처리
#2. 변수 간 관계 분석