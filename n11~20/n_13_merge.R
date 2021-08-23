Audi = read.csv("audi.csv")
Audi

library(dplyr)

Audi12 = Audi %>% 
  group_by(model) %>% 
  summarise(Count=n()) %>% 
  filter(model %in% c(" A1", " A2", " A3", " A4"))


Audi13 = Audi %>% 
  group_by(model) %>% 
  summarise(Mean = mean(price)) %>% 
  filter(model %in% c(" A1", " A2", " A3", " A4"))


Audi14 = Audi %>% 
  left_join(Audi13, by = "model")

head(Audi14)


Audi15 = Audi %>% 
  right_join(Audi13, by = "model")

head(Audi15)




