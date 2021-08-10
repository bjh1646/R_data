# 기본 매트릭스
m1 = matrix(data = 0,
            nrow = 2,
            ncol = 3)
m1

# 매트릭스 기본값 지정 (행우선)
m2 = matrix(data = 1:20,
            nrow = 4,
            byrow = TRUE)
m2

# 매트릭스 bybor = FALSE (열우선)
m3 = matrix(data = 1:20,
            nrow = 4,
            byrow = FALSE)
m3

# 인텍싱 - 위치값 추출
m2
m2[2,3]
m2[2,] #2행 전체
m2[,3] #3열 전체
m2[,c(1,3)]
m2[,-2]

# 행열 연산
m2
m3
m4 = m2 + m3
m4
m5 = m2 - m3
m5
m6 = m2 + 2
m6
m7 = m2 * 4
m7

# 행렬과 벡터 연산
m2
m2 * c(1,2,3,4,5)

# 행렬의 곱셈
m8 = matrix(data = 1:6, nrow = 2)
m8
m9 = matrix(data = 10:15, ncol = 2)
m9
m10 = m8 %*% m9
m10


# 데이터 프레임 생성
df1 = data.frame(
  v1 = 1:3,
  v2 = c("A","B","C"),
  v3 = seq(4,6,length.out=3),
  v4 = rep(Sys.Date(),3)
)
df1


# 데이터 프레임 구조 확인
# - str(), dim(), nrow(), ncol()

dim(df1)

nrow(df1)

ncol(df1)

str(df1)

# 행열의 이름을 출력
df1
rownames(df1)
colnames(df1)

# 행열의 이름 변경
rownames(df1) = c("A","B","C")
colnames(df1) = c("Number", "Alphabet", "Number2", "DATE")
df1


# 특정 열의 인텍스 탐색 - grep()
grep("DATE", colnames(df1))

# 프레임에서 변수 추가
df1$Alphabet2 = c("D","E","F")
df1$Alphabet2
df1$DATE2 = format(df1$DATE, "%A")
df1

str(df1$DATE2)

