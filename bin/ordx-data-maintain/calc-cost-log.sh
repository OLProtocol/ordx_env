#!/bin/bash

if [ -z "$1" ]; then
    echo "Please provide a positive time(second) threshold value as the first argument."
    exit 1
fi

if ! [[ $1 =~ ^[1-9][0-9]*$ ]]; then
    echo "Please provide a positive integer as the time(second) threshold value."
    exit 1
fi

threshold=$1

if [ -z "$2" ]; then
    echo "Please provide the directory name as the second argument."
    exit 1
fi

if [ ! -d "$2" ]; then
    echo "The provided directory does not exist."
    exit 1
fi

logPath=$2

for file in "$logPath"/*[0-9].log; do
    filename=$(basename -- "$file")
    filename_no_ext="${filename%.*}"
    awk -v threshold="$threshold" '{
        if (match($0, /processed block [0-9]+ .* with [0-9]+ transactions took/)) {
            if (match($0, /([0-9]+\.[0-9]+)s/)) {
                time_value = substr($0, RSTART, RLENGTH-1)
                sum_time += time_value
                if (time_value > threshold) {
                    print $0, ",sumtime:" sum_time "s("sum_time/3600"h)"
                }

            }
        }
    }' "$file" > "${logPath}/${filename_no_ext}-filtered.log" || { echo "Error: Awk command failed for file: $file"; exit 1; }
done