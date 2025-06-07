#!/bin/dash

tmp1=$(mktemp -t tmp.XXX)
tmp2=$(mktemp -t tmp.XXX)

seq 1 4 | ./eddy '5s/1/2/' > "$tmp1"
seq 1 4 | 2041 eddy '5s/1/2/' > "$tmp2"

if diff "$tmp1" "$tmp2" >/dev/null; then
    echo "Substitution Test: PASS"
else
    echo "Substitution Test: FAIL"
    exit 1
fi

