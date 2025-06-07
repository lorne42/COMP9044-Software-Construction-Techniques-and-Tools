#!/bin/dash

PATH="$PATH:$(pwd)"

test_dir="$(mktemp -d)"
cd "$test_dir" || exit 1

expected_output="$(mktemp)"
actual_output="$(mktemp)"

trap 'rm "$expected_output" "$actual_output" -rf "$test_dir"' INT HUP QUIT TERM EXIT

cat > "$expected_output" <<EOF
Initialized empty pushy repository in .pushy
EOF

pushy-init > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test: pushy-init"
    exit 1
fi

echo "This is a test file." > test.txt

cat > "$expected_output" <<EOF
EOF

pushy-add test.txt > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test: pushy-add"
    exit 1
fi

echo "This is a test file." > test2

cat > "$expected_output" <<EOF
EOF

pushy-status > "$actual_output" 2>&1

cat > "$expected_output" <<EOF
test2 - untracked
test.txt - added to index
EOF

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test: pushy-status"
    exit 1
fi

echo "Passed test: pushy-status (untracked and added to index)"
exit 0

