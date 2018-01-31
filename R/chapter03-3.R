install.packages("ggplot2")
library(ggplot2)

x <- c("a","a","b","c")
x
qplot(x)

qplot(data=mpg, x=hwy)

#x축 cty
qplot(data=mpg, x=cty)

#x축 drv, y축 hwy
qplot(data=mpg, x=drv, y=hwy)

#x축 drv, y축 hwy, 선 그래프 형태
qplot(data=mpg, x=drv, y=hwy, geom="line")

#x축 drv, y축 hwy, 상자 그림 형태
qplot(data=mpg, x=drv, y=hwy, geom="boxplot")

#x축 drv, y축 hwy, 상자 그림 형태, drv별 색 표현
qplot(data=mpg, x=drv, y=hwy, geom="boxplot", colour=drv)

?qplot

####혼자서 해보기####
#Q1
scores <- c(80, 60, 70, 50, 90)
scores

#Q2
mean(scores)

#Q3
(mscore <- mean(scores))
