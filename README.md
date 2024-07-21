# getENRICH

![getEENRICH3](https://github.com/user-attachments/assets/2447b04a-54b4-4538-8aa1-9338a1f044ee)

[![Build Status](https://img.shields.io/github/workflow/status/jnarayan81/getENRICH/CI)](https://github.com/jnarayan81/getENRICH/actions)
[![License](https://img.shields.io/github/license/jnarayan81/getENRICH)](https://github.com/jnarayan81/getENRICH/blob/main/LICENSE)
[![Version](https://img.shields.io/github/v/release/jnarayan81/getENRICH)](https://github.com/jnarayan81/getENRICH/releases)
[![Issues](https://img.shields.io/github/issues/jnarayan81/getENRICH)](https://github.com/jnarayan81/getENRICH/issues)
[![Pull Requests](https://img.shields.io/github/issues-pr/jnarayan81/getENRICH)](https://github.com/jnarayan81/getENRICH/pulls)
[![Code Coverage](https://img.shields.io/codecov/c/github/jnarayan81/getENRICH)](https://codecov.io/gh/jnarayan81/getENRICH)

**getENRICH** - Automated pipeline for enrichment analysis in non-model organisms!

**getENRICH** is designed to address the unique needs of researchers working with non-model organisms (and model organisms). The tool features a user-friendly command line interface (CLI), ensuring that researchers can easily input data and interpret results. A web application (GUI) is also available at [www.getenrich/github.com](www.getenrich/github.com). **getENRICH** is compatible with a wide range of non-model organisms and integrates extensively with major biological databases to ensure comprehensive and up-to-date data analysis. The results of the enrichment analysis include a CSV file and several types of plots such as:

- Bar Plots
- BarPlot_qScore
- Dot Plots
- Lollipop Plots
- Cnet Plots
- Heatmap Plots
- Upset Plots
- Tree Plots
- PubMed Trend Plots
- KEGG Pathway Diagrams

## Getting Started

Clone the repository using git:

```bash
git clone https://github.com/jnarayan81/getENRICH.git
```

## Dependencies

**getENRICH** requires the following dependencies to be installed:

### Secure Internet Connection

### Bash Dependencies

- `wget`
- `jq`

### R Dependencies

- R 4.4.1

#### Required Libraries

- `jsonlite` 1.8.8
- `dplyr` 1.1.4
- `tidyverse` 2.0.0
- `clusterProfiler` 4.12.0
- `pheatmap` 1.0.12
- `visNetwork` 2.1.2
- `enrichplot` 1.24.0
- `ggplot2` 3.5.1
- `UpSetR` 1.4.0
- `pathview` 1.44.0
- `plotly` 4.10.4
- `cowplot` 1.1.3

## Usage

### Compulsory Flag

```bash
./getENRICH -c config.json
```

#### `-c` (config.json file)

This flag specifies the configuration file that contains the necessary parameters and settings for running the tool. The `config.json` file should be formatted correctly and include all required fields. It is the compulsory flag and the minimum flag the user requires to run the enrichment analysis.

### Optional Flags

```bash
./getENRICH -c config.json -f -i -j -k -l -m -n -o -p -v -a -g 0.05
```

#### `-f` (delete previous folders of result)

This flag allows the user to delete any previous result folders before running a new analysis. This can be useful for ensuring that old results do not interfere with new ones. If this flag is not used, then the old folder will be over-written with the contents of the new folder.

**Usage Example:**

```bash
./getENRICH -c config.json -f
```

#### `-g` (p-value and p.adjust significance threshold value)

This flag sets the significance threshold for both p-value and adjusted p-value. The default value is 0.05, but the user can specify a different threshold if needed. If there are no P-value or P-adjust values below the set threshold in the resultant Excel file generated, blank plots for P-adjust and P-value will be generated.

**Usage Example:**

```bash
./getENRICH -c config.json -g 0.01
```

In this example, the threshold is set to 0.01, so all the P-values and adjusted P-values which are below 0.01 will be plotted in the resultant graphs and plots and if there are no P-value or adjusted P-values below the set threshold in the resultant Excel file generated, blank plots for P-adjust and P-value will be generated.

#### `-i` (generate heatmap of p-value significant pathways)

This flag generates a heatmap for pathways that are significant based on the p-value. This visualization helps in identifying patterns and clusters of significant pathways.

**Usage Example:**

```bash
./getENRICH -c config.json -i
```

#### `-j` (generate heatmap of p.adjust significant pathways)

Similar to `-i`, this flag generates a heatmap but for pathways significant based on the adjusted p-value.

**Usage Example:**

```bash
./getENRICH -c config.json -j
```

#### `-k` (generate upset plot of p-value significant pathways)

This flag generates an upset plot for pathways significant based on the p-value. Upset plots are useful for visualizing the intersections of sets.

**Usage Example:**

```bash
./getENRICH -c config.json -k
```

#### `-l` (generate upset plot of p.adjust significant pathways)

Similar to `-k`, this flag generates an upset plot but for pathways significant based on the adjusted p-value.

**Usage Example:**

```bash
./getENRICH -c config.json -l
```

#### `-m` (generate treeplot of p-value significant pathways)

This flag generates a tree plot for pathways significant based on the p-value. Tree plots help in visualizing hierarchical relationships.

**Usage Example:**

```bash
./getENRICH -c config.json -m
```

#### `-n` (generate treeplot of p.adjust significant pathways)

Similar to `-m`, this flag generates a tree plot but for pathways significant based on the adjusted p-value.

**Usage Example:**

```bash
./getENRICH -c config.json -n
```

#### `-o` (generate pubMed trends plot of p-value significant pathways)

This flag generates a PubMed trends plot for pathways significant based on the p-value. This plot shows the publication trends over time for the significant pathways.

**Usage Example:**

```bash
./getENRICH -c config.json -o
```

#### `-p` (generate pubMed trends plot of p.adjust significant pathways)

Similar to `-o`, this flag generates a PubMed trends plot but for pathways significant based on the adjusted p-value.

**Usage Example:**

```bash
./getENRICH -c config.json -p
```

#### `-v` (generate KEGG pathway diagrams of p-value significant pathways)

This flag generates KEGG pathway diagrams for pathways significant based on the p-value. KEGG pathway diagrams are useful for understanding the biological pathways involved.

**Usage Example:**

```bash
./getENRICH -c config.json -v
```

#### `-a` (generate KEGG pathway diagrams of p.adjust significant pathways)

Similar to `-v`, this flag generates KEGG pathway diagrams but for pathways significant based on the adjusted p-value.

**Usage Example:**

```bash
./getENRICH -c config.json -a
```

## Flowchart

![KASS Annotation file](https://github.com/user-attachments/assets/41060ae5-b63a-45a4-8ea8-9ac124eb7a31)

## News

## Blogs and Publications

## Citation

## Contributing and Feedback
