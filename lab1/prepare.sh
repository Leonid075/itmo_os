python3 ../os-course/lab/util/graphgen.py -s 10M --seed 471855 --topology chain -b 0.5 --min-step-pages 2 -o graph-rand.bin
python3 ../os-course/lab/util/graphgen.py -s 200M --seed 471855 --topology sequential -o graph-seq.bin

gcc -o ./mmap/graph_traverse_mmap ../os-course/lab/intro-exp/src/graph_traverse_mmap.c
gcc -o ./readwrite/graph_traverse ../os-course/lab/intro-exp/src/graph_traverse.c