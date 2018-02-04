####11-1 미국 주별 강력 범죄율 단계 구분도 만들기####
#미국 주별 강력 범죄율 단계 구분도 만들기#
install.packages("ggiraphExtra")
library(ggiraphExtra)

str(USArrests) #미국 주별 강력 범죄율 정보
head(USArrests)

library(tibble)
crime <- rownames_to_column(USArrests, var = "state") #행 이름을 state 변수로 바꿈
crime$state <- tolower(crime$state) #소문자로 수정

str(crime)

#미국 주 지도 데이터 준비하기
library(ggplot2)
states_map <- map_data("state") #state 데이터를 데이터 프레임 형태로 불러옴
str(states_map)

#단계 구분도 만들기
ggChoropleth(data = crime,
             aes(fill = Murder,   #색깔로 표현할 변수
                 map_id = state), #지역 기준 변수
             map = states_map)

#인터랙티브 단계 구분도 만들기
ggChoropleth(data = crime,
             aes(fill = Murder,   
                 map_id = state),
             map = states_map,
             interactive = T)     #마우스 움직임에 반응하는 인터랙티브 단계 구분
