library(data.table)
library(ggplot2)
library(dplyr)
library(reshape)

Womens = read.csv("Womens Clothing E-Commerce Reviews.csv")
str(Womens)

#연속형 변수의 범주화 - cut()
#고객의 연령이 다양하기 때문에 연령대로 변환한 변수
Age_G = cut(as.numeric(Womens$Age),
            breaks = seq(10, 100, by = 10),
            include.lowest = TRUE,
            right = FALSE,
            labels = paste0(seq(10,90,by = 10), "th"))

Age_G

#고객을 연령을 10~90대 까지 나눔
Womens$Age_G = Age_G
summary(Womens$Age_G)

#텍스트 용량이 매우 크므로 20%만 추출
set.seed(1234)
SL = sample(1:nrow(Womens), nrow(Womens) * 0.2, replace = FALSE)

Womens_T = Womens[SL,]
Womens_T

#워드 추출
install.packages("tm")
library(tm)

TEXT = as.character(Womens_T$Review.Text)

TEXT[1]

# 대소문자 변환
tolower(TEXT[1])

# 알파벳 이외의 문자열 제거
gsub("[A-Z]"," ",TEXT[1])
gsub("[a-z]"," ",TEXT[1])
gsub("[^a-z]"," ",TEXT[1])


#데이터 기본 분석
#항목별 판매 순위
Product_Ranking = Womens %>%
  group_by(Department.Name,Class.Name,Clothing.ID) %>%
  summarise(Count = n()) %>%
  arrange(-Count)

Product_Ranking

#세대별 판매 순위
Product_Ranking2 = Womens %>%
  filter(Age_G %in% c("20th","30th","40th","50th","60th", "70th")) %>%
  group_by(Age_G, Department.Name,Class.Name,Clothing.ID) %>%
  summarise(Count = n()) %>%
  arrange(-Count) %>%
  ungroup() %>%
  group_by(Age_G) %>%
  top_n(n = 5,wt = Count) %>%
  mutate(Rank = row_number()) %>%
  arrange(Age_G)

Product_Ranking2

#20대와 30대가 가장 많이 구매한 상품을 시각화.
ggplot(Product_Ranking2) +
  geom_bar(aes(x = Rank, y = Count, fill = Department.Name), 
           stat = 'identity') +
  geom_label(aes(x = Rank, y = 100, label = paste0(Class.Name,"-",Clothing.ID))) +
  scale_x_reverse(breaks = 1:7) +
  coord_flip() +
  theme_bw() +
  theme(legend.position = "bottom") +
  facet_wrap(~Age_G)

#간단하게 고객 평점 확인
ggplot(Womens) +
  geom_bar(aes(x = Rating)) +
  theme_bw()

#가장 인기 높은 상품 10개를 출력
Rating_Ranking = Womens %>%
  group_by(Clothing.ID,
           Department.Name,Class.Name) %>%
  summarise(Count = n(),
            Mean = mean(Rating)) %>%
  ungroup() %>%
  top_n(n = 100, wt = Count) %>%
  top_n(n = 10, wt = Mean)

Rating_Ranking

#판매량과 평균 평점을 시각화
Rating_Ranking_Total = Womens %>%
  group_by(Clothing.ID,
           Department.Name,Class.Name) %>%
  summarise(Count = n(),
            Mean = mean(Rating)) 

ggplot(Rating_Ranking_Total) +
  geom_label(aes(x = Count, y = Mean, col = Department.Name,
                 label = Clothing.ID)) +
  theme_bw() +
  theme(legend.position = "bottom")

#리뷰 텍스트 마이닝
# install.packages("tm")
library(tm)
TEXT_tolower = tolower(TEXT)
CORPUS = Corpus(VectorSource(TEXT_tolower)) 
CORPUS_TM = tm_map(CORPUS,removePunctuation) 
CORPUS_TM = tm_map(CORPUS_TM, removeNumbers) 
CORPUS_TM = tm_map(CORPUS_TM,removeWords, c(stopwords("english")))

#키워드의 등장 빈도를 분석
TDM = TermDocumentMatrix(CORPUS_TM)
TDM_Matrix = as.matrix(TDM)

#행별로 값을 모두 합산하면 키워드의 총 등장 빈도를 계산
#Word Counter
Freq = rowSums(TDM_Matrix)

TERM_FREQ = data.frame(
  Words = names(Freq),
  Freq = Freq
)

TERM_FREQ = TERM_FREQ %>%
  arrange(-Freq)

TERM_FREQ

#토큰화를 통해 같은 의미를 가진 키워드로 묶음.
#같은 어근을 어근을 가진 키워드들은 서로 동일한 키워드로 인식
install.packages("tokenizers")
library(tokenizers)
tokenize_word_stems(TEXT[1])

#다시 문장으로 이어 붙임
Sentence = ""

for(tk in unlist(tokenize_word_stems(TEXT[1]))){
  
  Sentence = paste(Sentence, tk)
  
}

Sentence

#모든 리뷰 적용
TEXT_Token = c()

for(i in 1:length(TEXT)){
  
  Words_token = unlist(tokenize_word_stems(TEXT[i]))
  
  Sentence = ""
  
  for(tk in Words_token){
    
    Sentence = paste(Sentence, tk)
    
  }
  
  TEXT_Token[i] = Sentence
}

#토큰화된 단어에 대한 빈도 분석 진행
CORPUS_Token = Corpus(VectorSource(TEXT_Token)) 
CORPUS_TM_Token = tm_map(CORPUS_Token,removePunctuation) 
CORPUS_TM_Token = tm_map(CORPUS_TM_Token, removeNumbers) 
CORPUS_TM_Token = tm_map(CORPUS_TM_Token,removeWords, c(stopwords("english")))

TDM_Token = TermDocumentMatrix(CORPUS_TM_Token)
TDM_Matrix_Token = as.matrix(TDM_Token)
Freq_Token = rowSums(TDM_Matrix_Token)

TERM_FREQ_Token = data.frame(
  Words = names(Freq_Token),
  Freq = Freq_Token
)

TERM_FREQ_Token = TERM_FREQ_Token %>%
  arrange(-Freq)

nrow(TERM_FREQ)
nrow(TERM_FREQ_Token)

#워드 클라우드
#install.packages("wordcloud")
library(wordcloud)

wordcloud(words = TERM_FREQ_Token$Words,
          freq = TERM_FREQ_Token$Freq,
          max.words = 300,
          random.order = FALSE,
          random.color = TRUE,
          colors = brewer.pal(8, "Dark2"))
