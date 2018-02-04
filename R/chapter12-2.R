####12-2 dygraphs 패키지로 인터랙티브 시계열 그래프 만들기####
#인터랙티브 시계열 그래프 만들기#
install.packages("dygraphs")
library(dygraphs)

economics <- ggplot2::economics #1967~2015 미국 월별 경제 지표 데이터
head(economics)

library(xts)
eco <- xts(economics$unemploy, order.by = economics$date) #시간 순서 속성 지니는 xts 데이터 타입
head(eco)

dygraph(eco)

dygraph(eco) %>% dyRangeSelector() #날짜 범위 선택 가능

#여러 값 표현하기
eco_a <- xts(economics$psavert, order.by = economics$date) #저축률
eco_b <- xts(economics$unemploy/1000, order.by = economics$date) #실업자 수

eco2 <- cbind(eco_a, eco_b)
colnames(eco2) <- c("psavert", "unemploy") #변수명 바꾸기
head(eco2)

dygraph(eco2) %>% dyRangeSelector()
