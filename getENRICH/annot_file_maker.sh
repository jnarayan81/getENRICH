#!/bin/bash

# Default values for input files
kass_file=""
blastkoala_file=""
emapper_file=""

# Parse command line arguments
while getopts ":k:b:e:" opt; do
  case $opt in
    k)
      kass_file="$OPTARG"
      ;;
    b)
      blastkoala_file="$OPTARG"
      ;;
    e)
      emapper_file="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

# Check if at least one file is provided
if [ -z "$kass_file" ] && [ -z "$blastkoala_file" ] && [ -z "$emapper_file" ]; then
  echo "Error: No input files provided. Use -k [KASS output file], -b [blastKOALA output file], or -e [eggNOG-emapper output file] to specify input files."
  exit 1
fi

# Temporary files
kass_processed_file="kass_processed_file.tmp"
blastkoala_processed_file="blastkoala_processed_file.tmp"
eggNOGfile1="eggNOGfile1.tmp"
eggNOGfile2="eggNOGfile2.tmp"
all_merged_kegg_annot_file="all_merged_kegg_annot_file.tmp"
uniq_merged_kegg_annotation_file="uniq_merged_kegg_annotation_file.tmp"

# KASS annotation file processing
if [ -n "$kass_file" ]; then
  cut -d' ' -f2 "$kass_file" | grep "K" > "$kass_processed_file"
fi

# BlastKOALA annotation file processing
if [ -n "$blastkoala_file" ]; then
  cut -d' ' -f2 "$blastkoala_file" | grep "K" > "$blastkoala_processed_file"
fi

# eggNOG annotation file processing
if [ -n "$emapper_file" ]; then
  awk -F"\t" 'NR > 1 {print $1"\t"$12}' "$emapper_file" > "$eggNOGfile1"
  sed -i 's/ko://g' "$eggNOGfile1"
  sed -i 's/-//g' "$eggNOGfile1"
  sed -i '/^#/d' "$eggNOGfile1"
  awk '{split($2, arr, ","); for (i in arr) {print $1 "\t" arr[i];}}' "$eggNOGfile1" > "$eggNOGfile2"
fi

# Conditional merge based on presence of flags
if [ -n "$kass_file" ] && [ -n "$blastkoala_file" ] && [ -n "$emapper_file" ]; then
  cat "$kass_processed_file" "$blastkoala_processed_file" "$eggNOGfile2" > "$all_merged_kegg_annot_file"
elif [ -n "$kass_file" ] && [ -n "$blastkoala_file" ]; then
  cat "$kass_processed_file" "$blastkoala_processed_file" > "$all_merged_kegg_annot_file"
elif [ -n "$kass_file" ] && [ -n "$emapper_file" ]; then
  cat "$kass_processed_file" "$eggNOGfile2" > "$all_merged_kegg_annot_file"
elif [ -n "$blastkoala_file" ] && [ -n "$emapper_file" ]; then
  cat "$blastkoala_processed_file" "$eggNOGfile2" > "$all_merged_kegg_annot_file"
elif [ -n "$kass_file" ]; then
  cat "$kass_processed_file" > "$all_merged_kegg_annot_file"
elif [ -n "$blastkoala_file" ]; then
  cat "$blastkoala_processed_file" > "$all_merged_kegg_annot_file"
else
  cat "$eggNOGfile2" > "$all_merged_kegg_annot_file"
fi

# Extract unique annotations
sort "$all_merged_kegg_annot_file" | uniq > "$uniq_merged_kegg_annotation_file"

# Add header name
sed '1i gene\tterm' "$uniq_merged_kegg_annotation_file" > "$uniq_merged_kegg_annotation_file_with_header.tmp"

# Flip the columns
awk -F"\t" '{print $2"\t"$1}' "$uniq_merged_kegg_annotation_file_with_header.tmp" > "3kegg_annotationTOgenes.sb"

# Clean up temporary files
rm -f "$kass_processed_file" "$blastkoala_processed_file" "$eggNOGfile1" "$eggNOGfile2" "$all_merged_kegg_annot_file" "$uniq_merged_kegg_annotation_file" "$uniq_merged_kegg_annotation_file_with_header.tmp"

echo "Processing complete. Output file: 3kegg_annotationTOgenes.sb"
