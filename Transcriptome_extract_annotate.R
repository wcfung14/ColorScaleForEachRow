#' @title Extract gene of interest from transcriptome data and annotate gene name (gene count matrix)
#' @description Extract gene of interest from transcriptome data and annotate gene name (gene count matrix.FPKM or gene count matrix.TPM)

setwd(dirname(rstudioapi::getSourceEditorContext()$path))
setwd(here::here())
setwd(paste0("C:/Users/",Sys.info()[["user"]],"/Desktop/R/Transcriptome"))

library(xlsx)

SPECIES_CLASS <- "Ch" # "Ch" for Chilopoda, "Di" for Diplopoda
SPECIES <- "Lni" # "Ch": Ttu", "Lni", "Rim", "Sma"; "Di": Gma", "Ato", "Hho", "Nno", "Tco"
SPECIES_CODE <- paste(SPECIES_CLASS, SPECIES, sep="_")
FOLDER_NAME <- "Myriapod_gene_modele_transcriptomes_expression"
transcriptome_file <- grep(SPECIES, list.files(FOLDER_NAME, pattern = ".TPM"), value=TRUE)

{
  # read gene annotation result (.xlsx) (by BLAST and phylogenetic trees)
  gene_annotation <- read.xlsx(file = "Millipede_Ecdysteroid_blast_20210715.xlsx", sheetName = SPECIES_CODE)

  # extract row with confirmed annotated gene (X... %in% 1), columns: Gene, blastp ID, and +/- (c(1,9,12))
  gene_annotation_extracted <- gene_annotation[gene_annotation$X... %in% 1, c(1,9,12)]
  #gene_annotation_extracted <- gene_annotation_extracted[grep(SPECIES, gene_annotation_extracted[,2]),] ##remove rows with no gene model id
  
  # formatting gene ID
  gene_annotation_extracted$gene_model_id <- sub(".*\\|(.*)-T.*", "\\1", gene_annotation_extracted[, 2])
  #gene_annotation_extracted$gene_model_id <- sub(paste0(".*(",SPECIES,"_\\d+).*"),"\\1", gene_annotation_extracted[,2])
  
  
  # load transcriptome data matrix
  transcriptome_data <- tryCatch({
    read.table(paste0(FOLDER_NAME, "/", transcriptome_file[1]), 
               header = TRUE, fill=TRUE, na.strings = "")},
    error = function(e) {
      read.csv(paste0(FOLDER_NAME,"/", transcriptome_file[2]), fileEncoding="UTF-8-BOM")
  })
  
  # correct for a bug where some data shift one column to the left
  try(
    transcriptome_data[which(is.na(transcriptome_data[, ncol(transcriptome_data)])), 2:ncol(transcriptome_data)] <- 
      transcriptome_data[which(is.na(transcriptome_data[, ncol(transcriptome_data)])), 1:ncol(transcriptome_data)-1]
  )
  
  # merge transcriptome data matrix and annotated gene matrix
  merged <- 
    merge(transcriptome_data, gene_annotation_extracted, by.x="Gene_ID", by.y="gene_model_id")
  
  write.xlsx(subset(merged, select=-X...),"Transcriptome_data.xlsx", row.names=FALSE, sheetName = SPECIES_CODE, append=TRUE)  
}

# also see ColorScaleForEachRow.bas for Heatmap visualization for transcriptome data gene count matrix (or any other matrix) in Excel with VBA

