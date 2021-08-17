# 반복문과 조건문

for(k in 1:5) {
  print(k)
}

for(i in c("A", "B")) {
  for(j in 1:2) {
    print(paste0(i,j))
  }
}


for(i in 2:9) {
  for(j in 1:9) {
    print(i*j)
  }
}


Multiply = list()

for(i in 2:9) {
  vec = c()
  
  for(j in 1:9) {
    vec[j] = i*j
  }
  
  Multiply[[i]] = vec
}
Multiply


# list를 이용해서 여러 파일을 한꺼번에
List_Files = list.files("./data/")
List_Files

List_Length = length(List_Files)
List_Length

for(k in 1:List_Length) {
  
  assign(List_Files[k],
         read.csv(paste0("./data/", List_Files[k])))
}


for(t in 1:length(List_Files)) {
  print(List_Files[t])
}


v10 = 1:6
v10

which(v10 < 4)


# 조건문
grade = c(85, 73, 53, 42, 93, 59, 60, 58, 89, 23)

grade2 = ifelse(grade >= 60, "P", "F")
grade2

grade3 = ifelse(grade >= 90, "A",
                ifelse(grade >= 80, "B",
                       ifelse(grade >= 70, "C",
                              ifelse(grade >= 60, "D", "F"))))
grade3


i_text = c("A","B","C","D")

if("A" %in% i_text) {
  print("True A")
} else {
  print("False A")
}


if("E" %in% i_text) {
  print("True E")
} else if ("B" %in% i_text) {
  print("True B")
} else {
  print("False")
}


# 합/교집합 조건문 생성
# 합집합 |
# 교집합 &

english = c("A","B","C")
math = c("C","B","A")

grade_a1 = ifelse(english == "A" | math == "A", "A", "Else")
grade_a1

grade_a2 = ifelse(english == "B" | math == "B", "B", "Else")
grade_a2
