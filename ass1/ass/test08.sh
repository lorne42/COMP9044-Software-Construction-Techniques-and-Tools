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

pushy-branch > "$actual_output" 2>&1

cat > "$expected_output" <<EOF
pushy-branch: error: this command can not be run until after the first commit
EOF


if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test: pushy-branch"
    exit 1
fi
echo "Passed test: pushy-branch (not commit)"
exit 0
