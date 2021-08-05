#워드클라우드 - 텍스트 마이닝

install.packages("rJava")

install.packages("remotes")

remotes::install_github('haven-jeon/KoNLP',upgrade = "never", 
                        INSTALL_opts=c("--no-multiarch"))

library(KoNLP)

#extractNoun 테스트용
txt = "문장에 대한 이해가 필요하다"
extractNoun(txt)


# 1. 데이터 불러오기
txt = readLines("hiphop.txt")
head(txt)


# 2. 특수문자 제거용 환경설정
install.packages("stringr")
library(stringr)

# 3. 특수문자 제거
txt = str_replace_all(txt, "\\w", " ")

# 4. 명사 추출
nouns = extractNoun(txt)

# 5. 명사 list -> 문자열 벡터 변환
# 단어별 빈도표 생성
wordcount = table(unlist(nouns))

library(dplyr)

# 6. 데이터 프레임으로 변환
df_word = as.data.frame(wordcount, stringsAsFactors = F) 


# 7. 변수명 수정
df_word = rename(df_word,
                 word=Var1,
                 freq = Freq)

# 8. 두글자 이상 단어 추출
df_word = filter(df_word, nchar(word) >= 2)


# 빈도순으로 정렬 후 상위 20개 (확인용)
top_20 = df_word %>% 
  arrange(desc(freq)) %>% 
  head(20)
top_20


# 9. 워드클라우드 패키지 설치 및 로드
install.packages("wordcloud")
library(wordcloud)
library(RColorBrewer)

# 10. 색상 지정
pal = brewer.pal(8, "Dark2")

# 11. 난수 고정
set.seed(1234)

# 12.워드 클라우드 만들기
wordcloud(words = df_word$word,    #단어
          freq = df_word$freq,     #빈도
          min.freq = 2,            #최소 단어 빈도
          max.words = 200,         #표현 단어 수
          random.order = F,        #고빈도 단어 중앙에 배치
          rot.per = .1,            #회전 단어 비율
          scale = c(4, 0.3),       #단어 크기 범위
          colors = pal)            #색상목록





