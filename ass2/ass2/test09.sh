#!/bin/dash

tmp1=$(mktemp -t tmp.XXX)
tmp2=$(mktemp -t tmp.XXX)

echo -e "apple:3\nbanana:4\ncherry:5" | ./eddy ':2s/[0-9]/X/' > "$tmp1"
echo -e "apple:3\nbanana:4\ncherry:5" | 2041 eddy ':2s/[0-9]/X/' > "$tmp2"

if diff "$tmp1" "$tmp2" >/dev/null; then
    echo "Delimiter Substitution Test: PASS"
else
    echo "Delimiter Substitution Test: FAIL"
    exit 1
fi

