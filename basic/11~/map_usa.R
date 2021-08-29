#미국 지도
us_state = map_data(map='state')
str(us_state)
head(us_state)
ggplot(data=us_state,
       mapping = aes(x= long, y= lat, group = group, fill = region))+
  geom_polygon(color = 'black', fill = 'gray')+ coord_map() # 전부 회색으로 칠

#-----------------------------------------------------------------------------
#미국(1973년 주별 강력 범죄율)에 대한 데이터 시각화

install.packages("ggiraphExtra")
library(ggiraphExtra)

# 문자로 바꿔주기 
str(USArrests)
head(USArrests)

# 행렬 변환(state 변수)
library(tibble) # 데이터프레임 
crime = rownames_to_column(USArrests, var='state')
head(crime)

#지도 표시를 위해 일괄적으로 소문자로 변환
crime$state = tolower(crime$state) # 소문자로 변환 
crime$state
str(crime)

#미국 지도 데이터 준비
library(ggplot2)
install.packages("maps")
library(maps)

states_map = map_data('state')
str(states_map)

install.packages("mapproj")
library(mapproj)


#ggiraphExtra패키지의 ggChoropleth()
#fill-Murder -> 4개 , fill=Murder => 1개
ggChoropleth(data=crime,      # 지도에 표시할 데이터 
             aes(fill-Murder, #색깔로 표시할 변수 
             map_id=state),   # 지역 기준 변수 
             map=states_map)  # 지도데이터 

#Murder : 살인, Assault: 폭행,  UrbanPop : 인구밀도, Rape : 강간

#interactive = T : 마우스의 움직임에 반응.
ggChoropleth(data= crime, # 지도에 표시할 데이터 
             aes(fill=Murder,# 색깔로 표시할 변수
                 map_id=state), # 지역 기준 변수 
             map=states_map, # 지도 데이터 
             interactive = T)

------------------------------------------------------------------
#미국 범죄율 데이터를 미국지도에 적용

library(dplyr) # 데이터 전처리
search()

# 데이터 프레임 확인
# USArrests: R에서 제공하는 학습용 데이터 프레임
str(USArrests)
head(USArrests)
tail(USArrests)

# USArrests 데이터 프레임에는 미국 주(state)의 이름들이
# 각 행의 이름으로 설정되어 있음.
# us_map 데이터 프레임과 조인하기 위해서는 주 이름들이 변수가 되어야 함. -> tibble 라이브러리
library(tibble)
us_crime = rownames_to_column(USArrests, var = 'state')
str(us_crime)
head(us_crime)


# 미국 주 이름을 표시하는
# us_state의 region 변수는 소문자로만 되어 있고,
# us_crime의 state의 변수는 첫 글자가 대문자로 되어있다.
us_crime$state = tolower(us_crime$state)



library(dplyr)  # 아래 left_join 인식 않될때 사용
# 지도/범죄를 합친 데이터 프레임(join)
state_crime = left_join(us_state, us_crime, by = c('region'='state'))
head(state_crime)

#주별 살인 범죄율           # 아래 그림에서는 진할수록 범죄율이 낮음.
ggplot(data = state_crime, mapping = aes(x = long, y = lat, group = group,fill = Murder))+
  geom_polygon(color = 'black')+ coord_map()

# 진한색이 범죄율이 높도록 수정 : 위의 Murder -> -Murder 로 수정 또는 scale_fill_continuous 사용
ggplot(data = state_crime, mapping = aes(x = long, y = lat, group = group,fill = Murder))+
  geom_polygon(color = 'black')+ coord_map() + scale_fill_continuous(low = 'white', high = 'darkred')

# 단계구분도 Choropoleth map 이용
# 지도위에 통계 값들을 색깔로 구분해서 표현하는 방법
# 인구, 질병, 범죄 ...
# data와 map 파라미터를 알아서 join해서 지도를 그려준다.
install.packages('ggiraphExtra')
library(ggiraphExtra)
ggChoropleth(data = us_crime, mapping = aes(fill = Murder, map_id = state),
             map = us_state)

# ggChropleth()함수의 변수들
# data = 통계값이 들어있는 데이터 프레임(ex미국 주별 범죄율)
# map = 지도(위도, 경도, 지역, 그룹, ... )정보 데이터 프레임

# mapping
# 1) map_id = data와 map을 join할 수 있는 변수 이름
#    map의 region과 일치되는 데이터의 변수
# 2) fill = 지도의 각 그룹을 색깔로 채울 변수
# 3) inetactive = interactive = T 적용시 : 마우스를 올리면 데이터가 표시됨.

ggChoropleth(data = us_crime, map = us_state,
             mapping =aes(fill = Murder, map_id = state),
             interactive = T)
