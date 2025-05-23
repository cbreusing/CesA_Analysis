library(phangorn)
library(ggtree)
library(ggplot2)
library(ape)
library(dplyr)
library(glue)

# Analysis for reference trees
setwd("/Users/corinna/Documents/Work/Schwartz_Lab/Plant_paralog_evolution/Bryophyta/CESA/CESA_trees_refs")

#Tree with de novo assembled contigs for reference species
data <- read.table("tree_metadata.txt", header=T)
data2 <- data %>% mutate(NewLab = ifelse(Info== "n.a.", glue("italic({Genus}~{Species})"), glue("italic({Genus}~{Species})~{Info}")))

col <- c("Anthoceros" = "red2", "Ceratodon" = "cornflowerblue", "Entodon" = "mediumturquoise", "Fontinalis" = "darkcyan", "Hypnum" = "lightseagreen", "Marchantia" = "mediumpurple", "Penium" = "royalblue3", "Physcomitrium" = "plum", "Sphagnum" = "violetred4", "Takakia" = "darkgoldenrod1")

tree <- read.tree("RAxML_bipartitions.CESA_ref_exon.tre")

t <- ggtree(tree, layout="rectangular", size=1, branch.length="none") + geom_text(aes(label=node)) + geom_tiplab(align=TRUE, hjust=-.15)
t

rooted_tree <- root(tree, node=109, resolve.root = TRUE, edgelabel=TRUE)
 
pdf("RAxML_bipartitions.CESA_ref_exon.pdf", width=12, height=10)
t <- ggtree(rooted_tree, layout="rectangular", size=1) + xlim(0, 2.5) + geom_treescale(x=0, y=53) + geom_nodelab(aes(subset = !is.na(as.numeric(label))), geom="label", color="black", fill="whitesmoke", size=3, label.size=NA, nudge_x=-0.05)
t2 <- t %<+% data2 + geom_tippoint(aes(color=factor(Genus)), shape=19, size=3) + theme(legend.position = "none") + aes(color=factor(Genus)) + scale_color_manual(values = col, name="Genus", na.value="black") + geom_tiplab(aes(label=NewLab), align=FALSE, hjust=-.15, parse=T, family="Helvetica") + geom_cladelab(node=94, label="CESA A", family="Helvetica", fontface="bold", offset=0.65) + geom_cladelab(node=74, label="CESA B", family="Helvetica", fontface="bold", offset=0.75)
t2
dev.off()

tree <- read.tree("RAxML_bestTree.CESA_ref_exon.tre")

t <- ggtree(tree, layout="rectangular", size=1, branch.length="none") + geom_text(aes(label=node)) + geom_tiplab(align=TRUE, hjust=-.15)
t

rooted_tree <- root(tree, node=110, resolve.root = TRUE, edgelabel=TRUE)
 
pdf("RAxML_bestTree.CESA_ref_exon.pdf", width=12, height=10)
t <- ggtree(rooted_tree, layout="rectangular", size=1) + xlim(0, 2.5) + geom_treescale(x=0, y=53)
t2 <- t %<+% data2 + geom_tippoint(aes(color=factor(Genus)), shape=19, size=3) + theme(legend.position = "none") + aes(color=factor(Genus)) + scale_color_manual(values = col, name="Genus", na.value="black") + geom_tiplab(aes(label=NewLab), align=FALSE, hjust=-.15, parse=T, family="Helvetica") + geom_cladelab(node=95, label="CESA A", family="Helvetica", fontface="bold", offset=0.65) + geom_cladelab(node=75, label="CESA B", family="Helvetica", fontface="bold", offset=0.75)
t2
dev.off()

#Tree with all reference genes (de novo assembled and BLASTx searches)
data <- read.table("tree_metadata2.txt", header=T)
data2 <- data %>% mutate(NewLab = ifelse(Fontface==3 & Info== "n.a.", glue("italic({Genus}~{Species})"), ifelse(Fontface==3 & Info!= "n.a.", glue("italic({Genus}~{Species})~{Info}"), ifelse(Fontface==4 & Info== "n.a.", glue("bolditalic({Genus}~{Species})"), glue("bolditalic({Genus}~{Species})~bold({Info})")))))

col <- c("Anthoceros" = "red2", "Ceratodon" = "cornflowerblue", "Entodon" = "mediumturquoise", "Fontinalis" = "darkcyan", "Hypnum" = "lightseagreen", "Marchantia" = "mediumpurple", "Penium" = "royalblue3", "Physcomitrium" = "plum", "Sphagnum" = "violetred4", "Takakia" = "darkgoldenrod1")

tree <- read.tree("RAxML_bipartitions.CESA_all_refs_exon.tre")

t <- ggtree(tree, layout="rectangular", size=1, branch.length="none") + geom_text(aes(label=node)) + geom_tiplab(align=TRUE, hjust=-.15)
t

rooted_tree <- root(tree, node=200, resolve.root = TRUE, edgelabel=TRUE)

pdf("RAxML_bipartitions.CESA_all_refs_exon.pdf", width=15, height=15)
t <- ggtree(rooted_tree, layout="rectangular", size=1) + xlim(0, 2.5) + geom_treescale(x=0, y=100) + annotate("point", x=0, y=97, shape=21, fill="darkgray", color="black", size=3) + annotate("text", x=0.04, y=97, label = "> 75% node support", hjust = "left") + geom_nodepoint(aes(subset = !is.na(as.numeric(label)) & as.numeric(label) > 75), size=3, shape=21, fill="darkgray", color="black")
t2 <- t %<+% data2 + geom_tippoint(aes(color=factor(Genus)), shape=19, size=3) + theme(legend.position = "none") + aes(color=factor(Genus)) + scale_color_manual(values = col, name="Genus", na.value="black") + geom_tiplab(aes(label=NewLab), align=FALSE, hjust=-.15, parse=T, family="Helvetica") + geom_cladelab(node=168, label="CESA A", family="Helvetica", fontface="bold", offset=0.5) + geom_cladelab(node=114, label="CESA B", family="Helvetica", fontface="bold", offset=0.6)
t2
dev.off()


# Analysis for full tree
setwd("/Users/corinna/Documents/Work/Schwartz_Lab/Plant_paralog_evolution/Bryophyta/CESA/CESA_trees_all_samples")

data <- read.table("tree_metadata3.txt", header=T)
data2 <- data %>% mutate(NewLab = ifelse(Info== "n.a.", glue("italic({Genus}~{Species})"), glue("italic({Genus}~{Species})~{Info}")))

col <- c("Andreaeales" = "royalblue4", "Bartramiales" = "mediumturquoise", "Bryales" = "darkcyan", "Buxbaumiales" = "orange", "Dicranales" = "pink1", "Diphysciales" = "slateblue", "Encalyptales" = "plum4", "Grimmiales" = "palevioletred", "Orthotrichales" = "paleturquoise4", "Polytrichales" = "tomato", "Pottiales" = "hotpink", "Rhizogoniales" = "paleturquoise3", "Scouleriales" = "deeppink3", "Tetraphidales" = "gold", "Timmiales" = "salmon", "Anthocerotales" = "red2", "Pseudoditrichales" = "cornflowerblue", "Hypnales" = "lightseagreen", "Marchantiales" = "mediumpurple", "Desmidiales" = "royalblue3", "Funariales" = "plum", "Sphagnales" = "violetred4", "Takakiales" = "darkgoldenrod1")

tree <- read.tree("RAxML_bipartitions.CESA_exon.tre")

t <- ggtree(tree, layout="rectangular", size=1, branch.length="none") + geom_text(aes(label=node), size=3) + geom_tiplab(align=TRUE, hjust=-.15)
t

rooted_tree <- root(tree, node=662, resolve.root = TRUE, edgelabel=TRUE)
 
pdf("RAxML_bipartitions.CESA_exon.pdf", width=25, height=60)
t <- ggtree(rooted_tree, layout="rectangular", size=1) + xlim(0, 2.5) + geom_treescale(x=0, y=480) + geom_nodelab(aes(subset = !is.na(as.numeric(label))), geom="label", color="black", fill="whitesmoke", size=3, label.size=NA, nudge_x=-0.05)
t2 <- t %<+% data2 + geom_tippoint(aes(color=factor(Order)), shape=19, size=3) + theme(legend.position = "none") + aes(color=factor(Order)) + scale_color_manual(values = col, name="Order", na.value="black") + geom_tiplab(aes(label=NewLab), align=FALSE, hjust=-.15, parse=T, family="Helvetica") + geom_cladelab(node=658, label="CESA A", family="Helvetica", fontface="bold", offset=0.2) + geom_cladelab(node=667, label="CESA B", family="Helvetica", fontface="bold", offset=0.25)
t2
dev.off()

t <- ggtree(rooted_tree, layout="rectangular", size=1) + xlim(0, 2.5) + annotate("point", x=0, y=155, shape=21, fill="darkgray", color="black", size=3) + annotate("text", x=0.04, y=155, label = "> 75% node support", hjust = "left") + geom_nodepoint(aes(subset = !is.na(as.numeric(label)) & as.numeric(label) > 75), size=3, shape=21, fill="darkgray", color="black")
t2 <- t %<+% data2 + geom_tippoint(aes(color=factor(Order)), shape=19, size=3) + theme(legend.position = "none") + aes(color=factor(Order)) + scale_color_manual(values = col, name="Order", na.value="black") + geom_tiplab(aes(label=NewLab), align=FALSE, hjust=-.15, parse=T, family="Helvetica")

MRCA(t2, "Sphagnum_compactum_4", "Sphagnum_fuscum_5")
t3 <- t2 %>% collapse(node=835) + geom_point2(aes(subset=(node==835)), shape=18, size=5, color="violetred4") + geom_cladelabel(835, "Sphagnales", color="violetred4", family="Helvetica")
MRCA(t3, "Leucodon_julaceus_4", "Brachythecium_rivulare_4")
t4 <- t3 %>% collapse(node=683) + geom_point2(aes(subset=(node==683)), shape=18, size=5, color="lightseagreen") + geom_cladelabel(683, "Hypnales", color="lightseagreen", family="Helvetica")
MRCA(t4, "Climacium_americanum_2", "Platyhypnidium_sp._2")
t5 <- t4 %>% collapse(node=748) + geom_point2(aes(subset=(node==748)), shape=18, size=5, color="lightseagreen") + geom_cladelabel(748, "Hypnales", color="lightseagreen", family="Helvetica")
MRCA(t5, "Eosphagnum_inretortum_6", "Sphagnum_divinum_3")
t6 <- t5 %>% collapse(node=910) + geom_point2(aes(subset=(node==910)), shape=18, size=5, color="violetred4") + geom_cladelabel(910, "Sphagnales", color="violetred4", family="Helvetica")
MRCA(t6, "Hygrohypnum_luridum_3", "Entodon_seductrix_4")
t7 <- t6 %>% collapse(node=611) + geom_point2(aes(subset=(node==611)), shape=18, size=5, color="lightseagreen") + geom_cladelabel(611, "Hypnales", color="lightseagreen", family="Helvetica")
MRCA(t7, "Fontinalis_antipyretica_2", "Campyliadelphus_chrysophyllus_2")
t8 <- t7 %>% collapse(node=520) + geom_point2(aes(subset=(node==520)), shape=18, size=5, color="lightseagreen") + geom_cladelabel(520, "Hypnales", color="lightseagreen", family="Helvetica")

pdf("RAxML_bipartitions.CESA_exon.collapsed.pdf", width=22, height=25)
t8 + geom_treescale(x=0, y=160) + geom_cladelab(node=658, label="CESA A", family="Helvetica", fontface="bold", offset=0.23) + geom_cladelab(node=667, label="CESA B", family="Helvetica", fontface="bold", offset=0.28)
dev.off()


tree <- read.tree("RAxML_bestTree.CESA_exon.tre")

t <- ggtree(tree, layout="rectangular", size=1, branch.length="none") + geom_text(aes(label=node), size=3) + geom_tiplab(align=TRUE, hjust=-.15)
t

rooted_tree <- root(tree, node=501, resolve.root = TRUE, edgelabel=TRUE)
 
pdf("RAxML_bestTree.CESA_exon.pdf", width=25, height=60)
t <- ggtree(rooted_tree, layout="rectangular", size=1) + xlim(0, 2.5) + geom_treescale(x=0, y=480)
t2 <- t %<+% data2 + geom_tippoint(aes(color=factor(Order)), shape=19, size=3) + theme(legend.position = "none") + aes(color=factor(Order)) + scale_color_manual(values = col, name="Order", na.value="black") + geom_tiplab(aes(label=NewLab), align=FALSE, hjust=-.15, parse=T, family="Helvetica") + geom_cladelab(node=497, label="CESA A", family="Helvetica", fontface="bold", offset=0.2) + geom_cladelab(node=506, label="CESA B", family="Helvetica", fontface="bold", offset=0.25)
t2
dev.off()

t <- ggtree(rooted_tree, layout="rectangular", size=1) + xlim(0, 2.5)
t2 <- t %<+% data2 + geom_tippoint(aes(color=factor(Order)), shape=19, size=3) + theme(legend.position = "none") + aes(color=factor(Order)) + scale_color_manual(values = col, name="Order", na.value="black") + geom_tiplab(aes(label=NewLab), align=FALSE, hjust=-.15, parse=T, family="Helvetica")

MRCA(t2, "Sphagnum_compactum_4", "Sphagnum_fuscum_5")
t3 <- t2 %>% collapse(node=674) + geom_point2(aes(subset=(node==674)), shape=18, size=5, color="violetred4") + geom_cladelabel(674, "Sphagnales", color="violetred4", family="Helvetica")
MRCA(t3, "Leucodon_julaceus_4", "Brachythecium_rivulare_4")
t4 <- t3 %>% collapse(node=522) + geom_point2(aes(subset=(node==522)), shape=18, size=5, color="lightseagreen") + geom_cladelabel(522, "Hypnales", color="lightseagreen", family="Helvetica")
MRCA(t4, "Climacium_americanum_2", "Platyhypnidium_sp._2")
t5 <- t4 %>% collapse(node=587) + geom_point2(aes(subset=(node==587)), shape=18, size=5, color="lightseagreen") + geom_cladelabel(587, "Hypnales", color="lightseagreen", family="Helvetica")
MRCA(t5, "Eosphagnum_inretortum_6", "Sphagnum_divinum_3")
t6 <- t5 %>% collapse(node=749) + geom_point2(aes(subset=(node==749)), shape=18, size=5, color="violetred4") + geom_cladelabel(749, "Sphagnales", color="violetred4", family="Helvetica")
MRCA(t6, "Hygrohypnum_luridum_3", "Entodon_seductrix_4")
t7 <- t6 %>% collapse(node=941) + geom_point2(aes(subset=(node==941)), shape=18, size=5, color="lightseagreen") + geom_cladelabel(941, "Hypnales", color="lightseagreen", family="Helvetica")
MRCA(t7, "Fontinalis_antipyretica_2", "Campyliadelphus_chrysophyllus_2")
t8 <- t7 %>% collapse(node=853) + geom_point2(aes(subset=(node==853)), shape=18, size=5, color="lightseagreen") + geom_cladelabel(853, "Hypnales", color="lightseagreen", family="Helvetica")

pdf("RAxML_bestTree.CESA_exon.collapsed.pdf", width=22, height=25)
t8 + geom_treescale(x=0, y=160) + geom_cladelab(node=497, label="CESA A", family="Helvetica", fontface="bold", offset=0.23) + geom_cladelab(node=506, label="CESA B", family="Helvetica", fontface="bold", offset=0.28)
dev.off()
