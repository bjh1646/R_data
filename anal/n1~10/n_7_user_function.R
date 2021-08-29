f1 = function(x) {
  
  y = 2*x + 1
  
  return(y)
  
}

f1(x=3)
f1(3)


f2 = function(x1, x2) {
  
  y= 3*x1^2 + 2*x2 + 3
  
  return(y)
}

f2(3,4)


# 문자에 대한 사용자 정의 함수
F3 = function(Input) {
  if(Input == 'Hello') {
    
    Response = "Hi"
    
  } else if (Input == 'sorry') {
    
    Response = "It's OK"
    
  } else {
    
    Response = "Error"
    
  }
  
  return(Response)
  
}

F3("Hello")

F3("TTT")


# 사용자의 정의 함수를 사용할 때는 전체 소문자를 사용하지 말고
# 대문자를 혼용해서 사용하여 표준 함수와 구분될 수 있도록 한다.







