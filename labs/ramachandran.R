library(gridExtra)
library(ggplot2)
library(lattice)
library(ggrepel)

amber.no.solv <- read.table("/Users/brian/books/chem430/labs/lab1/amber.rama.coords.txt")
amber.no.solv$energies <- round(amber.no.solv$V2 + amber.no.solv$V4,2)
# https://stackoverflow.com/questions/29453348/how-to-add-horizontal-line-to-xy-plot-in-lattice
# amber.no.solv.plt <- xyplot(amber.no.solv$V3 ~ amber.no.solv$V1, main="Amber ff99sb No Solvent", xlab="phi", ylab="psi",
#                             panel =function(x,y,...){ 
#                               panel.xyplot(x,y,...);
#                               panel.lines(x=-180:180, y=rep(0.0,10), col="black", lwd=2);
#                               panel.lines(y=-180:180, x=rep(0.0,10), col="black", lwd=2)},
#                             xlim=c(-180,180), ylim=c(-180,180))

amber.no.solv.plt <- ggplot(amber.no.solv, aes(x=V1, y=V3)) +
  geom_point(shape=21, size=2, color="blue") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  ggtitle("Amber ff99sb No Solvent") +
  xlim(c(-180,180)) + xlab("phi") +
  ylim(c(-180,180)) + ylab("psi") +
  geom_text_repel(aes(label=energies), hjust = 0, vjust = 0, size = 3) +
  geom_hline(yintercept = 0, lwd=0.8) +
  geom_vline(xintercept = 0, lwd=0.8)
  


amber.solv <- read.table("/Users/brian/books/chem430/labs/lab1/amber.GBSA.rama.coords.txt")
amber.solv$energies <- round(amber.solv$V2 + amber.solv$V4, 2)
# amber.solv.plt <- xyplot(amber.solv$V3 ~ amber.solv$V1, main="Amber ff99sb w/ Solvent", xlab="phi", ylab="psi",
#                          panel =function(x,y,...){ 
#                            panel.xyplot(x,y,...);
#                            panel.lines(x=-180:180, y=rep(0.0,10), col="black", lwd=2);
#                            panel.lines(y=-180:180, x=rep(0.0,10), col="black", lwd=2)},
#                          xlim=c(-180,180), ylim=c(-180,180))
amber.solv.plt <- ggplot(amber.solv, aes(x=V1, y=V3)) +
  geom_point(shape=21, size=2, color="blue") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  ggtitle("Amber ff99sb w/ Solvent") +
  xlim(c(-180,180)) + xlab("phi") +
  ylim(c(-180,180)) + ylab("psi") +
  geom_text_repel(aes(label=energies), hjust = 0, vjust = 0, size = 3) +
  geom_hline(yintercept = 0, lwd=0.8) +
  geom_vline(xintercept = 0, lwd=0.8)


charmm22cmap.no.solv <- read.table("/Users/brian/books/chem430/labs/lab1/charmm22cmap.rama.coords.txt")
charmm22cmap.no.solv$energies <- round(charmm22cmap.no.solv$V2 + charmm22cmap.no.solv$V4, 2)
# https://stackoverflow.com/questions/29453348/how-to-add-horizontal-line-to-xy-plot-in-lattice
# charmm22cmap.no.solv.plt <- xyplot(charmm22cmap.no.solv$V3 ~ charmm22cmap.no.solv$V1, main="Charmm22cmap No Solvent", xlab="phi", ylab="psi",
#                             panel =function(x,y,...){ 
#                               panel.xyplot(x,y,...);
#                               panel.lines(x=-180:180, y=rep(0.0,10), col="black", lwd=2);
#                               panel.lines(y=-180:180, x=rep(0.0,10), col="black", lwd=2)},
#                             xlim=c(-180,180), ylim=c(-180,180))
charmm22cmap.no.solv.plt <- ggplot(charmm22cmap.no.solv, aes(x=V1, y=V3)) +
  geom_point(shape=21, size=2, color="blue") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  ggtitle("Charmm22cmap No Solvent") +
  xlim(c(-180,180)) + xlab("phi") +
  ylim(c(-180,180)) + ylab("psi") +
  geom_text_repel(aes(label=energies), hjust = 0, vjust = 0, size = 3) +
  geom_hline(yintercept = 0, lwd=0.8) +
  geom_vline(xintercept = 0, lwd=0.8)

charmm22cmap.solv <- read.table("/Users/brian/books/chem430/labs/lab1/charmm22cmap.GBSA.rama.coords.txt")
charmm22cmap.solv$energies <- round(charmm22cmap.solv$V2 + charmm22cmap.solv$V4,2)
# charmm22cmap.solv.plt <- xyplot(charmm22cmap.solv$V3 ~ charmm22cmap.solv$V1, main="Charmm22cmap w/ Solvent", xlab="phi", ylab="psi",
#                          panel =function(x,y,...){ 
#                            panel.xyplot(x,y,...);
#                            panel.lines(x=-180:180, y=rep(0.0,10), col="black", lwd=2);
#                            panel.lines(y=-180:180, x=rep(0.0,10), col="black", lwd=2)},
#                          xlim=c(-180,180), ylim=c(-180,180))
charmm22cmap.solv.plt <- ggplot(charmm22cmap.solv, aes(x=V1, y=V3)) +
  geom_point(shape=21, size=2, color="blue") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  ggtitle("Charmm22cmap w/ Solvent") +
  xlim(c(-180,180)) + xlab("phi") +
  ylim(c(-180,180)) + ylab("psi") +
  geom_text_repel(aes(label=energies), hjust = 0, vjust = 0, size = 3) +
  geom_hline(yintercept = 0, lwd=0.8) +
  geom_vline(xintercept = 0, lwd=0.8)


oplsaa.no.solv <- read.table("/Users/brian/books/chem430/labs/lab1/oplsaa.rama.coords.txt")
oplsaa.no.solv$energies <- round(oplsaa.no.solv$V2 + oplsaa.no.solv$V4,2)
# https://stackoverflow.com/questions/29453348/how-to-add-horizontal-line-to-xy-plot-in-lattice
# oplsaa.no.solv.plt <- xyplot(oplsaa.no.solv$V3 ~ oplsaa.no.solv$V1, main="oplsaa No Solvent", xlab="phi", ylab="psi",
#                                    panel =function(x,y,...){ 
#                                      panel.xyplot(x,y,...);
#                                      panel.lines(x=-180:180, y=rep(0.0,10), col="black", lwd=2);
#                                      panel.lines(y=-180:180, x=rep(0.0,10), col="black", lwd=2)},
#                                    xlim=c(-180,180), ylim=c(-180,180))
oplsaa.no.solv.plt <- ggplot(oplsaa.no.solv, aes(x=V1, y=V3)) +
  geom_point(shape=21, size=2, color="blue") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  ggtitle("oplsaa No Solvent") +
  xlim(c(-180,180)) + xlab("phi") +
  ylim(c(-180,180)) + ylab("psi") +
  geom_text_repel(aes(label=energies), hjust = 0, vjust = 0, size = 3) +
  geom_hline(yintercept = 0, lwd=0.8) +
  geom_vline(xintercept = 0, lwd=0.8)

oplsaa.solv <- read.table("/Users/brian/books/chem430/labs/lab1/oplsaa.GBSA.rama.coords.txt")
oplsaa.solv$energies <- round(oplsaa.solv$V2 + oplsaa.solv$V4,2)
# oplsaa.solv.plt <- xyplot(oplsaa.solv$V3 ~ oplsaa.solv$V1, main="oplsaa w/ Solvent", xlab="phi", ylab="psi",
#                                 panel =function(x,y,...){ 
#                                   panel.xyplot(x,y,...);
#                                   panel.lines(x=-180:180, y=rep(0.0,10), col="black", lwd=2);
#                                   panel.lines(y=-180:180, x=rep(0.0,10), col="black", lwd=2)},
#                                 xlim=c(-180,180), ylim=c(-180,180))
oplsaa.solv.plt <- ggplot(oplsaa.solv, aes(x=V1, y=V3)) +
  geom_point(shape=21, size=2, color="blue") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  ggtitle("oplsaa w/ Solvent") +
  xlim(c(-180,180)) + xlab("phi") +
  ylim(c(-180,180)) + ylab("psi") +
  geom_text_repel(aes(label=energies), hjust = 0, vjust = 0, size = 3) +
  geom_hline(yintercept = 0, lwd=0.8) +
  geom_vline(xintercept = 0, lwd=0.8)

grid.arrange(amber.no.solv.plt, amber.solv.plt,
             charmm22cmap.no.solv.plt, charmm22cmap.solv.plt, 
             oplsaa.no.solv.plt, oplsaa.solv.plt,
             ncol=2)


      