# 데이터 로드
twitter = read.csv("twitter.csv",
                   header = T,
                   stringsAsFactors = F,
                   fileEncoding = "UTF-8")
twitter

# 변수명 변경 -> 구분하기 쉽게 하기 위함.
twitter = rename(twitter,
                 no = 번호,
                 id = 계정이름,
                 date = 작성일,
                 tw = 내용)

# 특수문자 제거
twitter$tw = str_replace_all(twitter$tw, "\\W", " ") #제거
head(twitter$tw)  #특수문자 제거 확인


# 트윗에서 명사 추출
nouns = extractNoun(twitter$tw)

# list를 문자열 벡터로 변환
wordcount = table(unlist(nouns))

# 데이터 프레임으로 변환
df_word = as.data.frame(wordcount, stringsAsFactors = F)

# 변수명 수정
df_word = rename(df_word,
                 word = Var1,
                 freq = Freq)

#두 글자 이상 단어만 추출
df_word = filter(df_word, nchar(word) >=2 )

#상위 20개 추출
top20 = df_word %>% 
  arrange(desc(freq)) %>% 
  head(20)

top20 #출력


library(ggplot2)

order = arrange(top20, freq)$word

ggplot(data = top20, aes(x=word, y=freq)) + 
  ylim(0,2500) + 
  geom_col() + 
  coord_flip() + 
  scale_x_discrete(limit = order) +         #빈도분 막대 정렬
  geom_text(aes(label=freq), hjust = -0.3)  #빈도표시












