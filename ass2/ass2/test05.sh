#!/bin/dash

tmp1=$(mktemp -t tmp.XXX)
tmp2=$(mktemp -t tmp.XXX)

echo -e "apple\nbanana" | ./eddy '2s/apple/pear/' > "$tmp1"
echo -e "apple\nbanana" | 2041 eddy '2s/apple/pear/' > "$tmp2"

if diff "$tmp1" "$tmp2" >/dev/null; then
    echo "Targeted Substitution Test: PASS"
else
    echo "Targeted Substitution Test: FAIL"
    exit 1
fi

