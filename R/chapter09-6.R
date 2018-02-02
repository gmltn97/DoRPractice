####09-6 직업별 월급 차이####
#직업 변수 검토 및 전처리하기
class(welfare$code_job)
table(welfare$code_job)

library(readxl)
list_job <- read_excel("Koweps_Codebook.xlsx", col_names = T, sheet = 2) #'직종 코드' 시트 -> 직업분류코드
head(list_job)
dim(list_job)

welfare <- left_join(welfare, list_job, id = "code_job") #job변수를 welfare에 결합

welfare %>% 
  filter(!is.na(code_job)) %>%
  select(code_job, job) %>% 
  head(10)

#직업별 월급 차이 분석하기
#1. 직업별 월급 평균표 만들기
job_income <- welfare %>% 
  filter(!is.na(job) & !is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income))

head(job_income)

#2. 어떤 직업의 월급이 많은지 파악
top10 <- job_income %>% 
  arrange(desc(mean_income)) %>% 
  head(10)

top10

#3. 그래프 만들기
ggplot(data = top10, aes(x = reorder(job, mean_income), y = mean_income)) +
  geom_col() +
  coord_flip() #오른쪽으로 90도 회전

#4. 어떤 직업의 월급이 적은지 파악
bottom10 <- job_income %>% 
  arrange(mean_income) %>% 
  head(10)

bottom10

#5. 그래프 만들기
ggplot(data = bottom10, aes(x = reorder(job, -mean_income), y = mean_income)) +
  geom_col() +
  coord_flip() +
  ylim(0, 850)
