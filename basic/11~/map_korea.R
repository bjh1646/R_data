#아시아 맵

# 지도 위에 통계 값들 표시하기
rm(list=ls())
#ggplot2::map_data() 함수가 지도 데이터를 처리하기 위해 필요한 패키지
install.packages('maps')
install.packages('ggplot2')
install.packages('mapproj')
library(ggplot2)
search()

asia_map = map_data(map = 'world', region = c('North Korea','South Korea', 'Japan', 'China','India'))
korea_map =map_data(map = 'world', region = c('North Korea','South Korea'))

asia_map2 = map_data(map = 'world', region = c('North Korea','South Korea', 'Japan', 'China','India','Russia'))
str(asia_map)
tail(asia_map2)

#longitude(경도) : 영국의 그리니치 천문대를 기준으로 동/서방향 좌표
#latituide(위도) : 적도를 기준으로 남/북 방향 좌표
#group : 함께 연결한 위도/경도 점들의 그룹(나라, 주, 도시, ...)
#order : 위도, 경도 점들을 연결할 순서
#region : 지역 이름
#ggplot2 패키지를 사용할 때
#data 파라미터는 위도/경도 정보를 가지고 있는 map 데이터를 전달
#x축 파라미터 = 경도(long)
#y축 매핑 파라미터 = 위도(lat)
#그래프의 종류 : 다각형 그래프(polygon)
#coord_map(): 간격 조정

ggplot(data = asia_map,
       mapping = aes(x = long, y = lat,group = group, fill = region)) +              geom_polygon()+  coord_map()

#작게 보면 휘어짐
ggplot(data = asia_map2,
       mapping = aes(x = long, y = lat,group = group,fill = region)) +  geom_polygon()+ coord_map('polyconic') 

#한국
ggplot(data = korea_map,
       mapping = aes(x = long, y = lat,group = group,fill = region)) +  geom_polygon(color='black')+ coord_map() # 검정테두리가 생성

#------------------------------------------------------------------------------------

# 문자 인코딩, 변환 관련 기능 패키지
install.packages('stringi') # ICU(International Component of Unicode)

# 개발자 도구 패키지
install.packages('devtools')   

# 깃허브에서 패키지 다운받기=======>사이트 정확하지 않으면 오류 발생함...!!!
devtools::install_github('cardiomoon/kormaps2014')  

# https://github.com/cardiomoon/kormaps2014


# install.packages() : R 공식 홈페이지(패키지 저장소)에서 다운로드
# devtools::install_github(): github.com 사이트에서 다운로드
library(kormaps2014)
library(ggplot2)
library(dplyr)
library(ggiraphExtra)
search()

# kormaps2014 패키지에 있는 인구 조사 데이터 프레임
# str(korpop1)
# 데이터 프레임의 컬럼 이름들이 한글이어서 결과가 제대로 보이지 않음
str(changeCode(korpop1))
#kormaps2014::changeCode(): 데이터 프레임의 한글 컬럼(변수) 이름을 처리해준다.
head(korpop1)

head(changeCode(korpop1))

# 한글로 되어있는 컬럼들은 에러가 발생할 수 있어서 영어로 변경
korpop1 = rename(korpop1, name = 행정구역별_읍면동, pop = 총인구_명)

#interactive =  T 사용할때 한글깨짐 방지

install.packages("ggiraphExtra")
library(ggiraphExtra)

korpop1$name = iconv(korpop1$name, "UTF-8", "CP949")

ggChoropleth(data = korpop1,           #지도에 표현할 데이터 
             map = kormap1,            #지도 데이터
             mapping = aes(fill = pop, #색깔로 표현할 변수
             map_id = code),           #지역 기준 데이터
             interactive =  T )        #인터랙티브

# 행정구역번호가 행정구역이름으로 표시됨
ggChoropleth(data = korpop1,
             map = kormap1,
             mapping = aes(fill = pop,
             map_id = code,
             tooltip = name),
             interactive =  T ) 

# 결핵 환자 숫자 데이터 프레임
head(changeCode(tbc))
ggChoropleth(data = tbc, 
             map = kormap1,
             mapping = aes(fill= NewPts, 
             map_id = code))

