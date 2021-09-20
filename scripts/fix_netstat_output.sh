#!/bin/sh

document_name=$(basename "$1" | cut -d'.' -f 1)

# Close the top-level node enclosing the netstat output, save as .xml
sed '$a</statistics>' $1 | tee $document_name.xml
