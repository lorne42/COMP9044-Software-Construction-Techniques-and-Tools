#!/bin/dash

tmp1=$(mktemp -t tmp.XXX)
tmp2=$(mktemp -t tmp.XXX)

seq 1 4 | ./eddy '/2/q' > "$tmp1"
seq 1 4 | 2041 eddy '/2/q' > "$tmp2"

if diff "$tmp1" "$tmp2" >/dev/null; then
    echo "Quit Test: PASS"
else
    echo "Quit Test: FAIL"
    exit 1
fi

