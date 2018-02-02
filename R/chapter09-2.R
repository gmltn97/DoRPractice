####09-2 성별에 따른 월급 차이####여

#성별 변수 검토 및 전처리
#1. 변수 검토하기
class(welfare$sex)
table(welfare$sex) #이상치 확인

#2. 전처리
#만약 이상치가 있다면?
welfare$sex <- ifelse(welfare$sex == 9, NA, welfare$sex)
table(is.na(welfare$sex))

#성별 항목 이름 부여
welfare$sex <- ifelse(welfare$sex == 1, "male", "female")
table(welfare$sex)
qplot(welfare$sex)


#월급 변수 검토 및 전처리
#1. 변수 검토하기
class(welfare$income)
summary(welfare$income)

qplot(welfare$income)
qplot(welfare$income) + xlim(0, 1000)

#2. 전처리
#이상치 결측 처리
welfare$income <- ifelse(welfare$income %in% c(0, 9999), NA, welfare$income)
table(is.na(welfare$income))


#성별에 따른 월급 차이 분석하기
#1. 성별 월급 평균표 만들기
sex_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(sex) %>% 
  summarise(mean_income = mean(income))

sex_income

#2. 그래프 만들기
ggplot(data = sex_income, aes(x = sex, y = mean_income)) + geom_col()
