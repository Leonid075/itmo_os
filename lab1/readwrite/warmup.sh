sync
echo 3 | sudo tee /proc/sys/vm/drop_caches
./graph_traverse 1 ../graph-seq.bin 2> /dev/null
./graph_traverse --write 1 ../graph-seq.bin 2> /dev/null
