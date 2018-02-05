####15-3 데이터 구조####
#1. 벡터: 하나의 값 또는 여러 개의 값으로 구성, 한 가지 타입으로만 구성
a <- 1
a
class(a)

b <- "Hello"
b
class(b)

#2. 데이터 프레임: 행과 열로 구성, 다양한 변수 타입 구성 가능
x1 <- data.frame(var1 = c(1, 2, 3),
                 var2 = c("a", "b", "c"))
x1
class(x1)

#3. 매트릭스: 행과 열로 구성, 한 가지 변수 타입으로만 구성
x2 <- matrix(c(1:12), ncol = 2)
x2
class(x2)

#4. 어레이: 2차원 이상으로 구성된 매트릭스, 한 가지 변수 타입으로만 구성
x3 <- array(1:20, dim = c(2, 5, 2)) #2행X5열X2차원
x3
class(x3)

#5. 리스트: 모든 데이터 구조 포함
x4 <- list(f1 = a,  #벡터
           f2 = x1, #데이터 프레임
           f3 = x2, #매트릭스
           f4 = x3) #어레이
x4
class(x4)

mpg <- ggplot2::mpg
x <- boxplot(mpg$cty)
x
x$stats[,1]
x$stats[,1][3]
x$stats[,1][2]
