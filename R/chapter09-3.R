####09-3 나이와 월급의 관계####

#나이 변수 검토 및 전처리
#1. 변수 검토하기
class(welfare$birth)
summary(welfare$birth)
qplot(welfare$birth)

#2. 전처리
#만약 이상치 있다면?
welfare$birth <- ifelse(welfare$birth == 9999, NA, welfare$birth)
table(is.na(welfare$birth))

#3. 파생변수 만들기 - 나이
welfare$age <- 2015 - welfare$birth + 1
summary(welfare$age)
qplot(welfare$age)


#나이와 월급의 관계 분석하기
#1. 나이에 따른 월급 평균표 만들기
age_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(mean_income = mean(income))

head(age_income)

#2. 그래프 만들기
ggplot(data = age_income, aes(x = age, y = mean_income)) + geom_line()