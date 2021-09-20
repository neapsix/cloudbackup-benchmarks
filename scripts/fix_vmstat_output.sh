#!/bin/sh

document_name=$(basename "$1" | cut -d'.' -f 1)

# Add a top-level node to enclose the vmstat output, save as .xml
sed '1s/^/<statistics>\n/;$a</statistics>' $1 | tee $document_name.xml
