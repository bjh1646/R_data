df2 = data.frame(
  A = c(1,2,3),
  B = c(4,5,6)
)
df2

df3 = data.frame(
  A = c(5,4,1),
  B = c(3,2,1)
)
df3

rbind(df2, df3)

df4 = data.frame(
  A = c(1,2,3),
  B = c(4,5,6)
)

df5 = data.frame(
  C = c(4,5,6),
  D = c(7,8,9)
)

cbind(df4, df5)


# key 기준병합
df6 = data.frame(
  key = c("A", "B", "C", "D", "E"),
  A = c(1,2,3,4,5)
)

df7 = data.frame(
  key = c("C", "D", "E", "F", "G"),
  A = c(4,1,2,3,4)
)

df8 = merge(df6, df7, by="key", all = TRUE)
df8

# 리스트 생성
List1 = list()
v1 = 1:10
d1 = data.frame(
  A = 1:5,
  B = 6:10
)

List1[["vector"]] = v1
List1[["DateFrame"]] = d1


