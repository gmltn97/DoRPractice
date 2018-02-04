####10-2 국정원 트윗 텍스트 마이닝####
#국정원 트윗 텍스트 마이닝#
twitter <- read.csv("twitter.csv",
                    header = T,
                    stringsAsFactors = F,
                    fileEncoding = "UTF-8")

#변수명 수정
twitter <- rename(twitter,
                  no = 번호,
                  id = 계정이름,
                  date = 작성일,
                  tw = 내용)

#특수문자 제거
library(stringr)
twitter$tw <- str_replace_all(twitter$tw, "\\W", " ")
head(twitter$tw)

#단어 빈도표 만들기
nouns <- extractNoun(twitter$tw)  #명사 추출
wordcount <- table(unlist(nouns)) #문자열 벡터로 변환, 단어별 빈도표
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)

df_word <- filter(df_word, nchar(word) >= 2)
top20 <- df_word %>% 
  arrange(desc(freq)) %>% 
  head(20)

top20

#단어 빈도 막대 그래프 만들기
library(ggplot2)

order <- arrange(top20, freq)$word #빈도 순서 변수 생성

ggplot(data = top20, aes(x = word, y = freq)) +
  ylim(0, 2500) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limit = order) +
  geom_text(aes(label = freq), hjust = -0.3) #빈도 표시

#워드 클라우드 만들기
pal <- brewer.pal(8, "Dark2")
set.seed(1234)

wordcloud(words = df_word$word,
          freq = df_word$freq,
          min.freq = 10,
          max.words = 200,
          random.order = F,
          rot.per = .1,
          scale = c(6, 0.2),
          colors = pal)

#색상 바꾸기
pal <- brewer.pal(9, "Blues")[5:9]
set.seed(1234)

wordcloud(words = df_word$word,
          freq = df_word$freq,
          min.freq = 10,
          max.words = 200,
          random.order = F,
          rot.per = .1,
          scale = c(6, 0.2),
          colors = pal)
