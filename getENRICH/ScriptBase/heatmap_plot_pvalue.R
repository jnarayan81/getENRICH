library(jsonlite)
library(ggplot2)
library(UpSetR)
library(dplyr)
library(tidyverse)
library(pheatmap)
library(visNetwork)
library(clusterProfiler)
library(enrichplot)

# Get the present working directory
pwd <- getwd()

# Load configuration
config <- fromJSON("config.json")

# Extract paths from configuration and convert to absolute paths
outdir <- file.path(config$output_files$outdir)
graph <- file.path(outdir, config$output_files$graph)
enrichment_KEGG_results_csv <- file.path(outdir, config$output_files$enrichment_KEGG_results_csv)

setwd(graph)

# Read data from CSV file
csv_file_path <- enrichment_KEGG_results_csv
enrichment_data <- read.csv(csv_file_path)

# Get p-value threshold from command line arguments
args <- commandArgs(trailingOnly = TRUE)
pvalue_threshold <- ifelse(length(args) > 0, as.numeric(args[1]), 0.05)

# Filter data based on the provided p-value threshold
pvalue_filtered_data <- subset(enrichment_data, pvalue <= pvalue_threshold)



# Calculate the number of unique terms in the Description column in p.adjust data
pvalue_num_terms <- length(unique(pvalue_filtered_data$Description))
pvalue_num_gene <- length(unique(pvalue_filtered_data$geneID))


# Set dynamic text size based on the number of terms in p.adjust plots
if (pvalue_num_terms > 50) {
  pvalue_text_col_size <- 6
} else if (pvalue_num_terms > 30) {
  pvalue_text_col_size <- 10
} else if (pvalue_num_terms > 20) {
  pvalue_text_col_size <- 12
} else {
  pvalue_text_col_size <- 8
}

# Set dynamic text size based on the number of genes in p.adjust plots
if (pvalue_num_gene > 50) {
  pvalue_text_row_size <- 6
} else if (pvalue_num_gene > 30) {
  pvalue_text_row_size <- 10
} else if (pvalue_num_gene > 20) {
  pvalue_text_row_size <- 12
} else {
  pvalue_text_row_size <- 14
}






# Heatmap plot
gene_list <- strsplit(pvalue_filtered_data$geneID, "/")
gene_term_df <- data.frame(
  term = rep(pvalue_filtered_data$Description, sapply(gene_list, length)),
  gene = unlist(gene_list)
)

# Create a binary matrix for the heatmap
heatmap_data <- gene_term_df %>%
  mutate(value = 1) %>%
  spread(term, value, fill = 0)

# Convert the data frame to a matrix
heatmap_matrix <- as.matrix(heatmap_data[,-1])
rownames(heatmap_matrix) <- heatmap_data$gene

# Function to customize pheatmap appearance
customize_pheatmap <- function(heatmap_matrix, title_size = 1) {
  pheatmap(
    heatmap_matrix,
    color = colorRampPalette(c("navy", "white", "firebrick3"))(50),
    cluster_rows = TRUE,
    cluster_cols = TRUE,
    fontsize_row = 5,
    fontsize_col = pvalue_text_col_size,
    fontsize_main = title_size, # Adjust the main title size here
    main = "Heatmap of Gene-Pathway Associations"
  )
}



# Generate heatmap plot based on the number of genes
if (pvalue_num_gene < 30) {
  png("pvalue_heatmap_plot.png", width = 200 * pvalue_num_terms, height = 150 * pvalue_num_gene, res = 150)
  customize_pheatmap(heatmap_matrix)
  dev.off()
} else {
  png("pvalue_heatmap_plot.png", width = 70 * pvalue_num_terms, height = 50 * pvalue_num_gene, res = 150)
  customize_pheatmap(heatmap_matrix)
  dev.off()
}



