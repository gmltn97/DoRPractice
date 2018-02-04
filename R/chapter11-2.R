####11-2 대한민국 시도별 인구, 결핵 환자 수 단계 구분도 만들기####
#대한민국 시도별 인구 단계 구분도 만들기#
install.packages("stringi")
install.packages("devtools")
devtools::install_github("cardiomoon/kormaps2014")

library(kormaps2014) #대한민국의 지역 통계 데이터와 지도 데이터

#대한민국 시도별 인구 데이터 준비하기
str(changeCode(korpop1))

install.packages("dplyr")
library(dplyr)
korpop1 <- rename(korpop1,
                  pop = 총인구_명,
                  name = 행정구역별_읍면동)

#대한민국 시도 지도 데이터 준비하기
str(changeCode(kormap1))

#단계 구분도 만들기
options(encoding="UTF-8") #options(encoding="CP949")
library(ggplot2)
library(ggiraphExtra)
ggChoropleth(data = korpop1,
             aes(fill = pop,      #색깔로 표현할 변수
                 map_id = code,   #지역 기준 변수
                 tooltip = name), #지도 위에 표시할 지역명
             map = kormap1,
             interactive = T)

#대한민국 시도별 결핵 환자 수 단계 구분도 만들기#
str(changeCode(tbc)) #NewPts(결핵 환자 수)

ggChoropleth(data = tbc,
             aes(fill = NewPts,
                 map_id = code,
                 tooltip = name),
             map = kormap1,
             interactive = T)
