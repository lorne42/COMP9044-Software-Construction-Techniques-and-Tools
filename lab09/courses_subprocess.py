#!/usr/bin/python3
import subprocess
import sys
if len(sys.argv) != 2:
    sys.exit(1)

prefix = sys.argv[1]
command = f'curl --location --silent "http://www.timetable.unsw.edu.au/2024/{prefix}KENS.html" | grep -E "{prefix}[0-9]{{4}}.*" | grep -oP \'(?<=>).*?(?=<)\' | paste -d\' \' - - | sort | uniq'

# 执行命令并获取输出
result = subprocess.run(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

if result.returncode == 0:
    # 输出命令的标准输出
    print(result.stdout.strip())

