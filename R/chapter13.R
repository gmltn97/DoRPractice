####13-1 통계적 가설 검정이란?####
#통계 분석: 기술 통계, 추론 통계
#유의확률: 실제로는 집단 간 차이가 없는데 우연히 차이가 있는 데이터가 추출될 확률


####13-2 t검정(두 집단의 평균 비교)####
#compact 자동차와 suv 자동차의 도시 연비 t검정#
mpg <- as.data.frame(ggplot2::mpg)

library(dplyr)
mpg_diff <- mpg %>% 
  select(class, cty) %>% 
  filter(class %in% c("compact", "suv"))

head(mpg_diff)
table(mpg_diff$class)

t.test(data = mpg_diff, cty ~ class, var.equal = T) #cty(비교할 값), class(비교할 집단)
#결론: p-value가 0.05보다 작으므로 'compact와 suv 간 평균 도시 연비 차이가 통계적으로 유의하다'
#      suv보다 compact의 도시 연비가 더 높다

#일반 휘발유와 고급 휘발유의 도시 연비 t검정#
mpg_diff2 <- mpg %>% 
  select(fl, cty) %>% 
  filter(fl %in% c("r", "p"))

table(mpg_diff2$fl)

t.test(data = mpg_diff2, cty ~ fl, var.equal = T)
#결론: '일반 휘발유와 고급 휘발유를 사용하는 자동차 간 도시 연비 차이가 통계적으로 유의하지 않다'


####13-3 상관분석(두 변수의 관계성 분석)####
#두 연속 변수가 서로 관련이 있는지 검정하는 통계 분석 기법
#상관계수가 1에 가까울수록 관련성이 크다

#실업자 수와 개인 소비 지출의 상관관계#
economics <- as.data.frame(ggplot2::economics)
cor.test(economics$unemploy, economics$pce)
#결론: 실업자 수와 개인 소비 지출의 상관이 통계적으로 유의하다
#      실업자 수와 개인 소비 지출은 정비례 관계이다

#상관행렬 히트맵 만들기#
head(mtcars)

car_cor <- cor(mtcars) #상관행렬 생성
round(car_cor, 2) #소수점 셋째 자리에서 반올림

install.packages("corrplot")
library(corrplot)

corrplot(car_cor)                    #원
corrplot(car_cor, method = "number") #상관계수

col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))

corrplot(car_cor,
         method = "color",
         col = col(200),        #색상 200개 선정
         type = "lower",        #왼쪽 아래 행렬만 표시
         order = "hclust",      #유사한 상관계수끼리 군집화
         addCoef.col = "black", #상관계수 색깔
         tl.col = "black",      #변수명 색깔
         tl.srt = 45,           #변수명 45도 기울임
         diag = F)              #대각 행렬 제
