#!/bin/dash

tmp1=$(mktemp -t tmp.XXX)
tmp2=$(mktemp -t tmp.XXX)

seq 1 4 | ./eddy '/2/p' > "$tmp1"
seq 1 4 | 2041 eddy '/2/p' > "$tmp2"

if diff "$tmp1" "$tmp2" >/dev/null; then
    echo "Print Test: PASS"
else
    echo "Print Test: FAIL"
    exit 1
fi

