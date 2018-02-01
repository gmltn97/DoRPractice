####08-2 산점도(변수 간 관계 표현하기)####
#산점도 만들기
library(ggplot2)
ggplot(data = mpg, aes(x = displ, y = hwy)) #배경 설정

ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point() #그래프 추가

ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  xlim(3, 6) #x축 범위 3~6

ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  xlim(3, 6) + 
  ylim(10, 30) #y축 10~30

#혼자서 해보기#
#Q1
ggplot(data = mpg, aes(x = cty, y = hwy)) +
  geom_point()

#Q2
midwest <- as.data.frame(ggplot2::midwest)
ggplot(data = midwest, aes(x = poptotal, y = popasian)) + 
  geom_point() + 
  xlim(0, 500000) + 
  ylim(0, 10000)


####08-3 막대 그래프(집단 간 차이 표현하기)####
#요약표 : geom_col(), 원자료 : geom_bar()
#평균 막대 그래프 만들기
library(dplyr)
mpg <- as.data.frame(ggplot2::mpg)
df_mpg <- mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))
df_mpg

ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) +
  geom_col()

ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + 
  geom_col() #내림차순 정렬

#빈도 막대 그래프 만들기
ggplot(data = mpg, aes(x = drv)) + 
  geom_bar()

ggplot(data = mpg, aes(x = hwy)) + 
  geom_bar() #값의 분포 파악

#혼자서 해보기#
#Q1
mpg <- as.data.frame(ggplot2::mpg)
df <- mpg %>% 
  filter(class == "suv") %>% 
  group_by(manufacturer) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty)) %>% 
  head(5)

ggplot(data = df, aes(x = reorder(manufacturer, -mean_cty), y = mean_cty)) +
  geom_col()

#Q2
ggplot(data = mpg, aes(x = class)) +
  geom_bar()


####08-4 선 그래프(시간에 따라 달라지는 데이터 표현)####
#시계열 그래프 만들기
ggplot(data = economics, aes(x = date, y = unemploy)) + 
  geom_line()

#혼자서 해보기
ggplot(data = economics, aes(x = date, y = psavert)) + 
  geom_line()


####08-5 상자 그림(집단 간 분포 차이 표현하기)####
#상자 그림 만들기
ggplot(data = mpg, aes(x = drv, y = hwy)) +
  geom_boxplot()

#혼자서 해보기
mpg <- as.data.frame(ggplot2::mpg)
class_mpg <- mpg %>% 
  filter(class %in% c("compact", "subcompact", "suv"))
ggplot(data = class_mpg, aes(x = class, y = cty)) + 
  geom_boxplot()
