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



# Prepare data for UpSet plot
gene_list <- strsplit(pvalue_filtered_data$geneID, "/")
gene_term_df <- data.frame(
  term = rep(pvalue_filtered_data$Description, sapply(gene_list, length)),
  gene = unlist(gene_list)
)

# Create a binary matrix for the UpSet plot
upset_data <- gene_term_df %>%
  mutate(value = 1) %>%
  spread(term, value, fill = 0)

#print("This is a message.")

# Save the UpSet plot as a PNG file with custom dimensions and high resolution
png("pvalue_upset_plot.png", width = 4000, height = 3600, res = 300)
upset(
  upset_data,
  sets = colnames(upset_data)[-1],
  order.by = "freq",
  sets.bar.color = "skyblue",
  matrix.color = "red",
  main.bar.color = "blue",
  text.scale = c(1, 1, 1, 1, 0.8, 1),  # Adjust text sizes for different labels
  keep.order = TRUE,  # Keep the order of sets as in the data
  point.size = 1.2,  # Adjust the size of the points in the matrix
  line.size = 0.4  # Adjust the size of the lines in the matrix
)
dev.off()
