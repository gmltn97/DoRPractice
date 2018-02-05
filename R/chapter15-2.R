####15-2 변수 타입####
#연속 변수(Numeric), 범주 변수(Factor)

#변수 타입 간 차이 알아보기#
var1 <- c(1, 2, 3, 1, 2)
var2 <- factor(c(1, 2, 3, 1, 2))

var1
var2 #값의 범주를 의미하는 Levels 정보

var1 + 2
var2 + 2 #연산 불가능

class(var1) #numeric
class(var2) #factor

levels(var1) #NULL
levels(var2)

var3 <- c("a", "b", "b", "c")
var4 <- factor(c("a", "b", "b", "c"))

var3
var4

class(var3) #character
class(var4) #factor

mean(var1)
mean(var2) #에러 메시지 + NA

#변수 타입 바꾸기#
var2 <- as.numeric(var2)
mean(var2)
class(var2)
levels(var2)

#혼자서 해보기#
#Q1
class(mpg$drv)

#Q2
mpg$drv <- as.factor(mpg$drv)
class(mpg$drv)

#Q3
levels(mpg$drv)
