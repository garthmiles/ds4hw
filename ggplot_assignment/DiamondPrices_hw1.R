# load the ggplot library package
library(ggplot2)

# use the 'attach' function to read in the 'diamonds' dataset 
# from the ggplot2 package and make the fields directly accessable
data(diamonds)
attach(diamonds)

# perform a preliminary investigation of the dataset
names(diamonds)
head(diamonds)
summary(diamonds)

# initialize the ggplot object and specify the different components 
# of the plot itself (i.e., aesthetics or aes)
the.plot <- ggplot(data=diamonds, aes(x=carat, y=price, color=cut))
# add a layer to the plot using the 'layer' function in ggplot2
the.plot <- the.plot + layer(geom='point')
# add and format the plot title
the.plot <- the.plot + labs(title='Diamond Price(s) by Carat Size')
the.plot <- the.plot + theme(plot.title=element_text(size=rel(2), face='bold'))
# render the actual plot
the.plot

# create a variable equal to the fields used in the plot
# note: this is where the 'attach' function becomes useful
plot.data <- cbind(carat, price, cut)

# make sure the matrix contains the data we're expecting
head(plot.data)
summary(plot.data)