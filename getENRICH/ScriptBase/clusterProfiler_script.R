library(jsonlite)

# Get the present working directory
pwd <- getwd()

# Load configuration
config <- fromJSON("config.json")

# Extract paths from configuration and convert to absolute paths
outdir <- file.path(config$output_files$outdir)
graph <- file.path(outdir, config$output_files$graph)
kegg_annotationTOgenes_sb_3 <- file.path(config$input_files$kegg_annotationTOgenes_sb_3)
background_genes_sb <- file.path(config$input_files$background_genes_sb_1)
genes_of_interest_sb <- file.path(config$input_files$genes_of_interest_sb_2)
enrichment_KEGG_results_csv <- file.path(outdir, config$output_files$enrichment_KEGG_results_csv)

setwd(graph)

library(dplyr) 
library(tidyverse) 
library(clusterProfiler)

eggNOG_kegg <- read_tsv(kegg_annotationTOgenes_sb_3)

background_genes <- read_tsv(background_genes_sb) %>%
  unlist() %>%
  as.vector()

# read the gene list of interest
interesting_set <- read_tsv(genes_of_interest_sb) %>%
  unlist() %>%
  as.vector()

# create a list of kegg ortholog that includes all kegg orthologs which form my background
background_kegg <- eggNOG_kegg %>%
  dplyr::filter(gene %in% background_genes) %>%
  unlist() %>%
  as.vector()

# create a list of kegg ortholog that I am interested in
interesting_set_kegg <- eggNOG_kegg %>%
  dplyr::filter(gene %in% interesting_set) %>%
  unlist() %>%
  as.vector()

enrichment_kegg <- enrichKEGG(interesting_set_kegg,
                              organism = "ko",
                              keyType = "kegg",
                              pvalueCutoff = 0.05,
                              pAdjustMethod = "BH",
                              universe = background_kegg,
                              minGSSize = 10,
                              maxGSSize = 500,
                              qvalueCutoff = 0.05,
                              use_internal_data = FALSE)

#save the enrichment result
write.csv(file = paste0(enrichment_KEGG_results_csv),
          x = enrichment_kegg@result)
