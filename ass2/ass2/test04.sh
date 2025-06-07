#!/bin/dash

tmp1=$(mktemp -t tmp.XXX)
tmp2=$(mktemp -t tmp.XXX)

echo -e "hello\nworld" | ./eddy 's/hello/hi/' > "$tmp1"
echo -e "hello\nworld" | 2041 eddy 's/hello/hi/' > "$tmp2"

if diff "$tmp1" "$tmp2" >/dev/null; then
    echo "Global Substitution Test: PASS"
else
    echo "Global Substitution Test: FAIL"
    exit 1
fi

