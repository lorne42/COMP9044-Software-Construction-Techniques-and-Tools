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

cat > "$expected_output" <<EOF
Committed as commit 0
EOF

pushy-commit -m 'Add test.txt' > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test: pushy-commit"
    exit 1
fi

pushy-branch b1 > "$actual_output" 2>&1

cat > "$expected_output" <<EOF
EOF


if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test: pushy-branch"
    exit 1
fi

cat > "$expected_output" <<EOF
EOF

pushy-checkout b1 > "$actual_output" 2>&1

cat > "$expected_output" <<EOF
Switched to branch 'b1'
EOF


if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test: pushy-checkout"
    exit 1
fi

echo "Passed test: pushy-checkout"
exit 0
