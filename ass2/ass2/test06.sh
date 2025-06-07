#!/bin/dash

tmp1=$(mktemp -t tmp.XXX)
tmp2=$(mktemp -t tmp.XXX)

echo -e "1\n2\n3\n4" | ./eddy '1s/1/one/' > "$tmp1"
echo -e "1\n2\n3\n4" | 2041 eddy '1s/1/one/' > "$tmp2"

if diff "$tmp1" "$tmp2" >/dev/null; then
    echo "Addition Substitution Test: PASS"
else
    echo "Addition Substitution Test: FAIL"
    exit 1
fi

