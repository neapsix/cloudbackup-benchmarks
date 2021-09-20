#!/bin/sh

__usage="
Usage: $(basename $0) <file>

Copies file from the materials directory to a file in the current working
directory with a name generated from the relative path in the materials
directory..

Examples:
    To copy a single file:
    \$ $(basename $0) /path/to/materials/relativepath/to/file

    To copy all xml files from the directories under materials:
    \$ ls /path/to/materials/*/*/*.xml | xargs -n 1 $(basename $0)
"

usage() { echo "$__usage"; }

# Print usage and quit if there isn't one argument
if [ "$#" -ne 1 ]; then
   usage;
   exit 1
fi

abs_file_name=$(echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")")
file_name=$(basename "$1")
rel_file_name=$(echo "$abs_file_name" | sed -e 's@.*materials/@@')
utility_name=$(echo "$rel_file_name" | cut -d'/' -f 1)
test_name=$(echo "$rel_file_name" | cut -d'/' -f 2)

target_file_name=$(echo "$utility_name"_"$test_name"_"$file_name")

cp -a $1 ./$target_file_name
