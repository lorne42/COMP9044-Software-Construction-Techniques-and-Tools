#!/bin/dash

tmp1=$(mktemp -t tmp.XXX)
tmp2=$(mktemp -t tmp.XXX)

seq 1 4 | ./eddy '/2/d' > "$tmp1"
seq 1 4 | 2041 eddy '/2/d' > "$tmp2"

if diff "$tmp1" "$tmp2" >/dev/null; then
    echo "Delete Test: PASS"
    exit 0
else
    echo "Delete Test: FAIL"
    exit 1
fi

