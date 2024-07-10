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
padjust_filtered_data <- subset(enrichment_data, p.adjust <= pvalue_threshold)

# Calculate the number of unique terms in the Description column in p.adjust data
padjust_num_terms <- length(unique(padjust_filtered_data$Description))
padjust_num_gene <- length(unique(padjust_filtered_data$geneID))

# Set dynamic text size based on the number of terms in p.adjust plots
if (padjust_num_terms > 50) {
  padjust_text_col_size <- 6
} else if (padjust_num_terms > 30) {
  padjust_text_col_size <- 10
} else if (padjust_num_terms > 20) {
  padjust_text_col_size <- 12
} else {
  padjust_text_col_size <- 8
}

# Set dynamic text size based on the number of genes in p.adjust plots
if (padjust_num_gene > 50) {
  padjust_text_row_size <- 6
} else if (padjust_num_gene > 30) {
  padjust_text_row_size <- 10
} else if (padjust_num_gene > 20) {
  padjust_text_row_size <- 12
} else {
  padjust_text_row_size <- 14
}

# Heatmap plot
gene_list <- strsplit(padjust_filtered_data$geneID, "/")
gene_term_df <- data.frame(
  term = rep(padjust_filtered_data$Description, sapply(gene_list, length)),
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
    fontsize_col = padjust_text_col_size,
    fontsize_main = title_size, # Adjust the main title size here
    main = "Heatmap of Gene-Pathway Associations"
  )
}

# Generate heatmap plot based on the number of genes
if (padjust_num_gene < 30) {
  png("padjust_heatmap_plot.png", width = 200 * padjust_num_terms, height = 150 * padjust_num_gene, res = 150)
  customize_pheatmap(heatmap_matrix)
  dev.off()
} else {
  png("padjust_heatmap_plot.png", width = 70 * padjust_num_terms, height = 50 * padjust_num_gene, res = 150)
  customize_pheatmap(heatmap_matrix)
  dev.off()
}
