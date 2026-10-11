#!/usr/bin/env bash
set -euo pipefail

TIMEFORMAT="%3R,%3U,%3S"

bash ./warmup.sh

N=100
OUT=results.csv

echo "n,mode,timestamp,real,user,sys" > "$OUT"

for i in $(seq 1 "$N"); do
  echo -n "$i,read," >> "$OUT"
  { time nice -n -20 taskset -c 0 ./graph_traverse_mmap 1 graph-seq.bin 2> /dev/null ; } 2>> "$OUT"
  echo -n "$i,write," >> "$OUT"
  { time nice -n -20 taskset -c 0 ./graph_traverse_mmap --write 1 graph-seq.bin 2> /dev/null ; } 2>> "$OUT"
done
