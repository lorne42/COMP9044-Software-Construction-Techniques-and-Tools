#!/bin/dash

tmp1=$(mktemp -t tmp.XXX)
tmp2=$(mktemp -t tmp.XXX)

echo -e "apple\nbanana\ncherry" | ./eddy -n '1p' > "$tmp1"
echo -e "apple\nbanana\ncherry" | 2041 eddy -n '1p' > "$tmp2"

if diff "$tmp1" "$tmp2" >/dev/null; then
    echo "No Print Option Test: PASS"
else
    echo "No Print Option Test: FAIL"
    exit 1
fi

