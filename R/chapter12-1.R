####12-1 plotly 패키지로 인터랙티브 그래프 만들기####
install.packages("plotly")
library(plotly)

#ggplot2로 만든 그래프를 ggplotly()에 적용
library(ggplot2)
p <- ggplot(data = mpg, aes(x = displ, y = hwy, col = drv)) +
  geom_point() #산점

ggplotly(p)

#인터랙티브 막대 그래프 만들기
p <- ggplot(data = diamonds, aes(x = cut, fill = clarity)) +
  geom_bar(position = "dodge")

ggplotly(p)
