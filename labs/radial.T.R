radial.in <- read.table("/Users/brian/books/chem430/labs/lab2/radial.graph.txt", sep = "\t")
colnames(radial.in) <- c("Distance", "raw_g(r)", "smooth_g(r)")

radial.in$`raw_g(r)`

ggplot()
ggplot(radial.in, aes(x=Distance, y=`raw_g(r)`, col="raw_g(r)")) +
  geom_line() +
  geom_line(aes(x=Distance, y=`smooth_g(r)`, col="smooth_g(r)"), alpha=0.5) +
  scale_color_manual(name = "", values = c("raw_g(r)" = "red", "smooth_g(r)" = "blue")) +
  ylab("g(r)") +
  xlab("distance (\uc5)") + 
  ggtitle("Radial distribtion between 2\npolar oxygens in ethylene glycol") +
  geom_segment(x = 4.0, y = 2.8, xend = 2.95, yend = 2.8,
               arrow = arrow(length = unit(0.25, "cm")),
               show.legend = FALSE,
               size=0.2) +
  geom_text(x=4.9,y=2.8,label="2.675 \uc5", size=3.5, show.legend = FALSE) +
  geom_segment(x = 6.2, y = 1.47, xend = 5, yend = 1.4,
               arrow = arrow(length = unit(0.25, "cm")),
               show.legend = FALSE,
               size=0.2) +
  geom_text(x=7.2,y=1.5,label=paste0(`second_max_g(r)`," \uc5"), size=3.5, show.legend = FALSE)

apply(radial.in, 2, max)[2]

`max_g(r)` <- radial.in$Distance[which(radial.in$`raw_g(r)`==apply(radial.in, 2, max)[2])]
second <- radial.in[radial.in$Distance > 4,]
`second_max_g(r)` <- second$Distance[which(second$`raw_g(r)`==apply(second, 2, max)[2])]
 arrows()
 
 diffuse <-  read.table("/Users/brian/books/chem430/labs/lab2/diffuse.txt")
 #load necessary libraries
 library(ggplot2)
 library(ggpubr)
 
 #create plot with regression line and regression equation
 ggplot(data=diffuse, aes(x=V1, y=V2)) +
   geom_smooth(method="lm") +
   geom_line() +
   stat_regline_equation(label.x=90, label.y=14) +
   xlab("Time (ps)") + ylab("MSD (\uc5^2, df=6)") + ggtitle("Ethylene Glycol: tinker diffuse")
 plot(diffuse$V1, diffuse$V2, type = "l",
      xlab="Time (ps)", ylab="MSD (Angstrom^2)", main="Ethylene Glycol: tinker diffuse")

