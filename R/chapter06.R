####06-2 조건에 맞는 데이터만 추출하기####
#조건에 맞는 데이터만 추출하기
library(dplyr)
exam <- read.csv("csv_exam.csv")
exam

exam %>% filter(class == 1) #class가 1인 행만 출력
exam %>% filter(class == 2)
exam %>% filter(class != 1) #1반이 아닌 경
exam %>% filter(class != 3)

#초과, 미만, 이상, 이하 조건 걸기
exam %>% filter(math > 50)
exam %>% filter(math < 50)
exam %>% filter(english >= 80)
exam %>% filter(english <= 80)

#여러 조건을 충족하는 행 추출하기
exam %>% filter(class == 1 & math >= 50)
exam %>% filter(class == 2 & english >= 80)

#여러 조건 중 하나 이상 충족하는 행 추출하기
exam %>% filter(math >= 90 | english >= 90)
exam %>% filter(english < 90 | science < 50)

#목록에 해당하는 행 추출하기
exam %>% filter(class == 1 | class == 3 | class == 5)
exam %>% filter(class %in% c(1,3,5)) #1, 3, 5반 해당하면 추출

#추출한 행으로 데이터 만들기
class1 <- exam %>% filter(class == 1)
class2 <- exam %>% filter(class == 2)
mean(class1$math) #1반 수학 점수 평균
mean(class2$math) #2반 수학 점수 평균

#혼자서 해보기#
#Q1
mpg <- as.data.frame(ggplot2::mpg)
displ1 <- mpg %>% filter(displ <= 4)
displ2 <- mpg %>% filter(displ >= 5)
mean(displ1$hwy)
mean(displ2$hwy)

#Q2
manu_a <- mpg %>% filter(manufacturer == "audi")
manu_t <- mpg %>% filter(manufacturer == "toyota")
mean(manu_a$cty)
mean(manu_t$cty)

#Q3
mpg_new <- mpg %>% filter(manufacturer %in% c("chevrolet", "ford", "honda"))
mean(mpg_new$hwy)


####06-3 필요한 변수만 추출하기####
#변수 추출하기
exam %>% select(math)
exam %>% select(english)
exam %>% select(class, math, english)
exam %>% select(-math) #math 제외
exam %>% select(-math, -english)

#dplyr 함수 조합하기
exam %>% 
  filter(class == 1) %>%  #class가 1인 행 추출
  select(english) #english 추출

exam %>% 
  select(id, math) %>% 
  head #앞부분 6행까지 추출

exam %>% 
  select(id, math) %>%
  head(10)

#혼자서 해보기#
#Q1
mpg <- as.data.frame(ggplot2::mpg)
new_mpg <- mpg %>% select(class, cty)
head(new_mpg, 10)

#Q2
s_cty <- new_mpg %>% filter(class == "suv")
c_cty <- new_mpg %>% filter(class == "compact")
mean(s_cty$cty)
mean(c_cty$cty)


####06-4 순서대로 정렬하기####
#오름차순으로 정렬하기
exam %>% arrange(math)

#내림차순으로 정렬하기
exam %>% arrange(desc(math)) #math 내림차순
exam %>% arrange(class, math) #같은 반이면 math 오름차순

#혼자서 해보기#
#Q1
mpg <- as.data.frame(ggplot2::mpg)
mpg %>% 
  filter(manufacturer == "audi") %>% 
  arrange(desc(hwy)) %>% 
  head(5)


####06-5 파생변수 추가하기####
#파생변수 추가하기
exam %>% 
  mutate(total = math + english + science) %>% 
  head

#여러 파생변수 한 번에 추가하기
exam %>% 
  mutate(total = math + english + science,
         mean = (math + english + science) / 3) %>% 
  head

#mutate에 ifelse() 적용하기
exam %>% 
  mutate(test = ifelse(science >= 60, "pass", "fail")) %>% 
  head

#추가한 변수를 dplyr 코드에 바로 활용하기
exam %>% 
  mutate(total = math + english + science) %>% 
  arrange(total) %>% 
  head

#혼자서 해보기#
#Q1
mpg <- as.data.frame(ggplot2::mpg)
new_mpg <- mpg
new_mpg <- new_mpg %>% mutate(total = cty + hwy)

#Q2
new_mpg <- new_mpg %>% mutate(average = total / 2)

#Q3
new_mpg %>% 
  arrange(desc(average)) %>% 
  head(3)

#Q4
mpg %>% 
  mutate(total = cty + hwy,
         average = total / 2) %>% 
  arrange(desc(average)) %>% 
  head(3)


####06-6 집단별로 요약하기####
#집단별로 요약하기
exam %>% summarise(mean_math = mean(math))

exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math)) #반별 수학 점수 평균

exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math),
            sum_math = sum(math),
            median_math = median(math),
            n = n()) #학생 수

mpg %>%
  group_by(manufacturer, drv) %>%  #회사별, 구동 방식별
  summarise(mean_cty = mean(cty)) %>% 
  head(10)

#dplyr 조합하기
mpg %>% 
  group_by(manufacturer) %>% 
  filter(class == "suv") %>% 
  mutate(tot = (cty + hwy) / 2) %>% 
  summarise(mean_tot = mean(tot)) %>% 
  arrange(desc(mean_tot)) %>% 
  head(5)

#혼자서 해보기#
#Q1
mpg <- as.data.frame(ggplot2::mpg)
mpg %>%
  group_by(class) %>% 
  summarise(mean_cty = mean(cty))

#Q2
mpg %>%
  group_by(class) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty))

#Q3
mpg %>%
  group_by(manufacturer) %>% 
  summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy)) %>% 
  head(3)

#Q4
mpg %>% 
  filter(class == "compact") %>% 
  group_by(manufacturer) %>% 
  summarise(count = n()) %>% 
  arrange(desc(count))


####06-7 데이터 합치기####
#가로로 합치기
test1 <- data.frame(id = c(1, 2, 3, 4, 5),
                    midterm = c(60, 80, 70, 90, 85))
test2 <- data.frame(id = c(1, 2, 3, 4, 5),
                    final = c(70, 83, 65, 95, 80))
test1
test2

total <- left_join(test1, test2, by="id")
total

#다른 데이터를 활용해 변수 추가하기
name <- data.frame(class = c(1, 2, 3, 4, 5),
                   teacher = c("kim", "lee", "park", "choi", "jung"))
name

exam_new <- left_join(exam, name, by="class")
exam_new

#세로로 합치기 (변수명이 같아야 함)
group_a <- data.frame(id = c(1, 2, 3, 4, 5),
                      test = c(60, 80, 70, 90, 85))
group_b <- data.frame(id = c(6, 7, 8, 9, 10),
                      test = c(70, 83, 65, 95, 80))
group_a
group_b

group_all <- bind_rows(group_a, group_b)
group_all

#혼자서 해보기#
fuel <- data.frame(fl = c("c", "d", "e", "p", "r"),
                   price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
                   stringsAsFactors = F)
fuel
#Q1
mpg <- as.data.frame(ggplot2::mpg)
mpg <- left_join(mpg, fuel, by="fl")

#Q2
mpg %>% 
  select(model, fl, price_fl) %>% 
  head(5)


#분석 도전!#
#문제1
midwest <- as.data.frame(ggplot2::midwest)
midwest <- midwest %>% 
  mutate(ratio_child = (poptotal - popadults) / poptotal * 100)

#문제2
midwest %>%
  arrange(desc(ratio_child)) %>% 
  select(county, ratio_child) %>% 
  head(5)

#문제3
midwest <- midwest %>% 
  mutate(range = ifelse(ratio_child >= 40, "large",
                        ifelse(ratio_child >= 30, "middle", "small"))) %>% 
  group_by(range) %>% 
  summarise(count = n())
midwest

#문제4
midwest <- midwest %>% 
  mutate(ratio = popasian / poptotal * 100) %>% 
  select(state, county, ratio) %>% 
  arrange(ratio) %>% 
  head(10)
midwest
