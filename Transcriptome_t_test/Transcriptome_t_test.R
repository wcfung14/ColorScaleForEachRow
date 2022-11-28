#' @title t.test and boxplot for selected genes in the transcriptome gene count matrix
#' @description t.test for selected genes in the transcriptome gene count matrix, generate boxplot for each gene

setwd(dirname(rstudioapi::getSourceEditorContext()$path))
setwd(here::here())
setwd(paste0("C:/Users/",Sys.info()[["user"]],"/Desktop/R/Transcriptome/Transcriptome_t_test"))

library(xlsx)
library(ggplot2)
library(ggpubr)
library(ggsignif)

test_df <- read.xlsx("./data.xlsx", sheetIndex = 1)

for (n in 1:nrow(test_df)) {
  name <- test_df[n, 1]
  list <- as.vector(unlist(test_df[n, 2:10]))
  temp <- c(rep("25C", 15*3), rep("30C", 15*3), rep("35C", 15*3))
  rep <- c(rep("rep1", 15), rep("rep2", 15), rep("rep3", 15))
  
  df <- data.frame(name = name, temp = temp, rep = rep, val = list)

  t.test(list[1:3], list[7:9])
  test_aov <- aov(val ~ temp, data = df)
  summary(test_aov)
  TukeyHSD(test_aov)[[1]][,"p adj"]
  

  ggboxplot(df, x="temp", y="val", color="temp", add = "jitter", shape="temp") +
    stat_signif(comparisons = list(c("25C", "30C"), c("35C", "30C"), c("25C", "35C")), 
                test = "t.test", map_signif_level = TRUE,
                y_position  = c(1.1, 1.2, 1.3))
  
  ggboxplot(df, x="temp", y="val", color="temp", add = "jitter", shape="temp") +
    facet_wrap(~name) +
    stat_compare_means(comparisons = list(c("25C", "30C"), c("35C", "30C"), c("25C", "35C")), 
                method = "t.test", label = "p.signif")
  
  ggsave(paste0(name, ".png"), width=20, height=20)
  print(paste0("Printing ", name))
}
