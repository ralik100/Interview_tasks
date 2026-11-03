#!/bin/bash
# Counts ERROR lines in all .log files and fails if any are found.

set -euo pipefail

dir=${1:-.};

if ! find "$dir" -type f -name '*.log' -print -quit | grep -q .; then
    echo "No .log files found"
    exit 0
fi

if line_count=$(grep -r -h 'ERROR' --include='*.log' "$dir" | wc -l); then
    grep_status=${PIPESTATUS[0]}
    echo "Found $line_count lines with errors, exitting with code 2"
    exit 2


else
    grep_status=${PIPESTATUS[0]}
    if [ $grep_status -eq 1 ]; then
        echo "Found .log files, no ERROR lines found"
        exit 0
    else
        echo "Pipeline exit code: $grep_status unable to proceed"
        exit 2
    fi
fi