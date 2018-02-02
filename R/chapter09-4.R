####09-4 연령대에 따른 월급 차이####
#연령대 변수 검토 및 전처리하기
welfare <- welfare %>%
  mutate(ageg = ifelse(age < 30, "young",
                       ifelse(age <= 59, "middle", "old")))
table(welfare$ageg)
qplot(welfare$ageg)

#연령대에 따른 월급 차이 분석하기
#1. 연령대별 월급 평균표 만들기
ageg_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg) %>% 
  summarise(mean_income = mean(income))

ageg_income

#2. 그래프 만들기
ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) + 
  geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old")) #초년, 중년, 노년 순 정렬

