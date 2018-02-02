####09-5 연령대 및 성별 월급 차이####
#1. 연령대 및 성별 월급 차이 분석하기
sex_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg, sex) %>% 
  summarise(mean_income = mean(income))

sex_income

#2. 그래프 만들기
ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) +
  geom_col(position = "dodge") + #막대 분리
  scale_x_discrete(limits = c("young", "middle", "old"))


####나이 및 성별 월급 차이 분석하기####
#성별 연령별 월급 평균표 만들기
sex_age <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age, sex) %>% 
  summarise(mean_income = mean(income))

head(sex_age)

#그래프 만들기
ggplot(data = sex_age, aes(x = age, y = mean_income, col = sex)) + geom_line() #성별에 따라 다른 색

