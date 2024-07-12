# getENRICH
getENRICH - Automated pipeline for enrichment analysis in non-model organisms!

getENRICH is designed to address the unique needs of researchers working with non-model organisms (and model organisms). The tool features a user-friendly command line interface (CLI), ensuring that researchers can easily input data and interpret results. Web application (GUI) is also available at the location www.getenrich/github.com. getENRICH is compatible with a wide range of non-model organisms and integrates extensively with major biological databases to ensure comprehensive and up-to-date data analysis. The results of the enrichment analysis show a CSV file and several types of plots such as Bar Plots, BarPlot_qScore, Dot Plots, Lollipop Plots, Cnet Plots, Heatmap Plots, Upset Plots, Tree Plots, PubMed Trend Plots along with the KEGG Pathway Diagrams.

# Getting Started
Clone the repository using git:

git clone https://github.com/jnarayan81/getENRICH.git

# Dependencies
getENRICH requires the following dependencies to be installed:

#### Secure internet connection
 
#### Bash dependencies:

•	wget

•	jq
 
 #### R dependencies:
 
•	R 4.4.1

##### Required libraries:

o	jsonlite 1.8.8

o	dplyr 1.1.4

o	tidyverse 2.0.0

o	clusterProfiler 4.12.0

o	pheatmap 1.0.12

o	visNetwork 2.1.2

o	enrichplot 1.24.0

o	ggplot2 3.5.1

o	UpSetR 1.4.0

o	pathview 1.44.0

o	plotly 4.10.4

o	cowplot 1.1.3


# Usage
####COMPULSORY FLAG:
./getENRICH -c config.json -a

####OPTIONAL FLAGS:


1.	-f (delete previous folders of result)
This flag allows the user to delete any previous result folders before running a new analysis. This can be useful for ensuring that old results do not interfere with new ones. If this flag is not used, then the old folder will be over-written with the contents of the new folder.
Usage Example:
./getENRICH -c config.json -f
2.	-g (p-value and p.adjust significance threshold value)
This flag sets the significance threshold for both p-value and adjusted p-value. The default value is 0.05, but the user can specify a different threshold if needed. If there are no P-value or P-adjust values below the set threshold in the resultant Excel file generated, blank plots for P-adjust and P-value will be generated.
Usage Example:
./getENRICH -c config.json -g 0.01

In this example, the threshold is set to 0.01, so all the P-values and adjusted P-values which are below 0.01 will be plotted in the resultant graphs and plots and if there are no P-value or adjusted P-values below the set threshold in the resultant Excel file generated, blank plots for P-adjust and P-value will be generated.
3.	-i (generate heatmap of p-value significant pathways)
This flag generates a heatmap for pathways that are significant based on the p-value. This visualisation helps in identifying patterns and clusters of significant pathways.
Usage Example:
./getENRICH -c config.json -i
4.	-j (generate heatmap of p.adjust significant pathways)
Similar to -i, this flag generates a heatmap but for pathways significant based on the adjusted p-value.
Usage Example:
./getENRICH -c config.json -j
5.	-k (generate upset plot of p-value significant pathways)
This flag generates an upset plot for pathways significant based on the p-value. Upset plots are useful for visualising the intersections of sets.
Usage Example:
./getENRICH -c config.json -k
6.	-l (generate upset plot of p.adjust significant pathways)
Similar to -k, this flag generates an upset plot but for pathways significant based on the adjusted p-value.
Usage Example:
./getENRICH -c config.json -l
7.	-m (generate treeplot of p-value significant pathways)
This flag generates a tree plot for pathways significant based on the p-value. Tree plots help in visualising hierarchical relationships.
Usage Example:
./getENRICH -c config.json -m
8.	-n (generate treeplot of p.adjust significant pathways)
Similar to -m, this flag generates a tree plot but for pathways significant based on the adjusted p-value.
            Usage Example:
./getENRICH -c config.json -n
9.	-o (generate pubMed trends plot of p-value significant pathways)
This flag generates a PubMed trends plot for pathways significant based on the p-value. This plot shows the publication trends over time for the significant pathways.
Usage Example:
./getENRICH -c config.json -o
10.	-p (generate pubMed trends plot of p.adjust significant pathways)
Similar to -o, this flag generates a PubMed trends plot but for pathways significant based on the adjusted p-value.
Usage Example:
./getENRICH -c config.json -p
11.	-v (generate KEGG pathway diagrams of p-value significant pathways)
This flag generates KEGG pathway diagrams for pathways significant based on the p-value. KEGG pathway diagrams are useful for understanding the biological pathways involved.
Usage Example:
./getENRICH -c config.json -v
12.	-a (generate KEGG pathway diagrams of p.adjust significant pathways)
Similar to -v, this flag generates KEGG pathway diagrams but for pathways significant based on the adjusted p-value.
Usage Example:
./getENRICH -c config.json -a

