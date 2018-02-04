####10-1 힙합 가사 텍스트 마이닝####
#텍스트 마이닝 준비하기#

install.packages("rJava")
install.packages("memoise")
install.packages("KoNLP") #한글 자연어 분석 패키지

library(KoNLP)
library(dplyr)

useNIADic() #사전 설정하기

txt <- readLines("hiphop.txt")
head(txt)

#특수문자 제거하기
install.packages("stringr")
library(stringr)
txt <- str_replace_all(txt, "\\W", " ")


#가장 많이 사용된 단어 알아보기#
extractNoun("대한민국의 영토는 한반도와 그 부속도서로 한다") #명사 추출

nouns <- extractNoun(txt)
wordcount <- table(unlist(nouns)) #문자열 벡터로 변환 -> 단어별 빈도표
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)

#자주 사용된 단어 빈도표 만들기
df_word <- filter(df_word, nchar(word) >= 2) #두 글자 이상 단어만 추출

top_20 <- df_word %>% 
  arrange(desc(freq)) %>% 
  head(20)

top_20

#워드 클라우드(단어 빈도를 구름 모양으로 표현한 그래프) 만들기#
#1. 패키지 준비하기
install.packages("wordcloud")

library(wordcloud)
library(RColorBrewer)

#2. 단어 색상 목록 만들기
pal <- brewer.pal(8, "Dark2") #Dark2 색상 목록에서 8개 색상 추출

#3. 난수 고정하기
set.seed(1234)

#4. 워드 클라우드 만들기
wordcloud(words = df_word$word,
          freq = df_word$freq,
          min.freq = 2,
          max.words = 200,
          random.order = F,  #고빈도 단어 중앙 배치
          rot.per = .1,      #회전 단어 비율
          scale = c(4, 0.3), #단어 크기 범위
          colors = pal)

#5. 단어 색상 바꾸기
#빈도 높을수록 진한 파란색으로
pal <- brewer.pal(9, "Blues")[5:9]
set.seed(1234)

wordcloud(words = df_word$word,
          freq = df_word$freq,
          min.freq = 2,
          max.words = 200,
          random.order = F,  
          rot.per = .1,     
          scale = c(4, 0.3), 
          colors = pal)
