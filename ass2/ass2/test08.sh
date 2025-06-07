#!/bin/dash

tmp1=$(mktemp -t tmp.XXX)
tmp2=$(mktemp -t tmp.XXX)

echo -e "apple\nbanana\ncherry\ngrape" | ./eddy '2,3s/.*/orange/' > "$tmp1"
echo -e "apple\nbanana\ncherry\ngrape" | 2041 eddy '2,3s/.*/orange/' > "$tmp2"

if diff "$tmp1" "$tmp2" >/dev/null; then
    echo "Addition Multiple Lines Test: PASS"
else
    echo "Addition Multiple Lines Test: FAIL"
    exit 1
fi

