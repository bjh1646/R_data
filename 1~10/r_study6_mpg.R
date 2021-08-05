qplot(data = mpg, x=cty)

qplot(data = mpg, x=drv, y=hwy)

qplot(data = mpg, x=drv, y=hwy, geom = "line")

qplot(data = mpg, x=drv, y=hwy, geom = "boxplot")

qplot(data = mpg, x=drv, y=hwy, geom = "boxplot", colour=drv)






