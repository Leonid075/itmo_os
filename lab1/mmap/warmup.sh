sync
echo 3 | sudo tee /proc/sys/vm/drop_caches
./graph_traverse_mmap 1 ../graph-seq.bin 2> /dev/null
./graph_traverse_mmap --write 1 ../graph-seq.bin 2> /dev/null
