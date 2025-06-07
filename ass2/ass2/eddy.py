#!/usr/bin/env python3
import sys
import re

# Function to handle 'q' command
def eddy_q(input_lines, regex=None, n=None):
    result = []
    count = 0
    if regex:
        pattern = re.compile(regex[1:-1])
        for line in input_lines:
            line = line.strip()
            result.append(line)
            if re.search(pattern, line):
                break
    elif n:
        for line in input_lines:
            if count >= n:
                break
            line = line.strip()
            result.append(line)
            count += 1
    return result

# Function to handle 'p' command
def eddy_p(input_lines, regex=None, n=None, no_print=False):
    result = []
    count = 0
    if regex:
        pattern = re.compile(regex[1:-1])
        for line in input_lines:
            line = line.strip()
            if not no_print:
                result.append(line)
            if re.search(pattern, line):
                result.append(line)
    elif n:
        for line in input_lines:
            line = line.strip()
            if not no_print:
                result.append(line)
            if count == n - 1:
                result.append(line)
            count += 1
    return result

# Function to handle 'ponly' command
def eddy_ponly(input_lines):
    result = []
    for line in input_lines:
        line = line.strip()
        result.append(line)
        result.append(line)
    return result

# Function to handle 'd' command
def eddy_d(input_lines, regex=None, n=None):
    result = []
    count = 0
    if regex:
        pattern = re.compile(regex[1:-1])
        for line in input_lines:
            line = line.strip()
            if not re.search(pattern, line):
                result.append(line)
    elif n:
        for line in input_lines:
            if count != n - 1:
                line = line.strip()
                result.append(line)
            count += 1
    return result

# Function to handle 's' command
def eddy_s(input_lines, add, regex, substitution, global_substitution=False, target=None):
    result = []
    pattern = re.compile(regex)
    if target is None:
        target = re.compile('.*')
    
    if add:
        count = 0
        for line in input_lines:
            line = line.strip()
            if count == int(add) - 1:
                if global_substitution:
                    substituted_line = re.sub(pattern, substitution, line)
                else:
                    substituted_line = re.sub(pattern, substitution, line, count=1)
                result.append(substituted_line)
            else:
                result.append(line)
            count += 1
    else:
        for line in input_lines:
            line = line.strip()
            substituted_line = line
            if re.search(target, line):
                if global_substitution:
                    substituted_line = re.sub(pattern, substitution, line)
                else:
                    substituted_line = re.sub(pattern, substitution, line, count=1)
            result.append(substituted_line)
    return result

if __name__ == "__main__":
    # Check if '-n' flag is present
    no_print = False
    if sys.argv[1] == '-n':
        no_print = True
    
    # Parse command list
    command_list = sys.argv[-1].replace(" ", "").split(";")
    
    # Read input lines
    input_lines = []
    u = 0
    for line in sys.stdin:
        u += 1
        input_lines.append(line)
        if u > 300000:
            break

    # Execute commands
    for command in command_list:
        # Remove comments
        command = command.split("#")[0]

        if command.endswith('q'):
            try:
                n = int(command[:-1])
                input_lines = eddy_q(input_lines, n=n)
            except ValueError:
                regex = command[:-1]
                input_lines = eddy_q(input_lines, regex=regex)

        elif command.endswith('p'):
            try:
                if command == 'p':
                    input_lines = eddy_ponly(input_lines)
                else:
                    n = int(command[:-1])
                    input_lines = eddy_p(input_lines, n=n, no_print=no_print)
            except ValueError:
                regex = command[:-1]
                input_lines = eddy_p(input_lines, regex=regex, no_print=no_print)

        elif command.endswith('d'):
            if no_print:
                sys.exit(0)
            try:
                n = int(command[:-1])
                input_lines = eddy_d(input_lines, n=n)
            except ValueError:
                regex = command[:-1]
                input_lines = eddy_d(input_lines, regex=regex)

        elif command.endswith('g'):
            try:
                delimiter = command[-2]
                parts = command.split(delimiter)
                target = None
                if len(parts) > 4:
                    target = parts[1]
                    add = parts[2]
                    regex = parts[3]
                    substitution = parts[4]
                else:
                    add = parts[0]
                    regex = parts[1]
                    substitution = parts[2]
                
                if add != 's':
                    add = add[-2]
                else:
                    add = None
                
                input_lines = eddy_s(input_lines, add, regex, substitution, global_substitution=True, target=target)
            except (ValueError, IndexError):
                print(parts)

        else:
            try:
                delimiter = command[-1]
                parts = command.split(delimiter)
                target = None
                if len(parts) > 4:
                    target = parts[1]
                    add = parts[2]
                    regex = parts[3]
                    substitution = parts[4]
                else:
                    add = parts[0]
                    regex = parts[1]
                    substitution = parts[2]
                
                if add != 's':
                    add = add[-2]
                else:
                    add = None
                
                input_lines = eddy_s(input_lines, add, regex, substitution, global_substitution=False, target=target)
            except (ValueError, IndexError):
                print(parts)

    # Output modified input lines
    for line in input_lines:
        print(line.strip())
