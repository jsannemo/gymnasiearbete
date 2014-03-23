PS=(0.05 0.1 0.3 0.5 0.7 0.9 0.95)
NS=(10 15 20 25 30 40)
for p in "${PS[@]}"
do
    for n in "${NS[@]}"
    do
        for i in {1..3}
        do
            ./a.out <<< "$n $p" > random-$n-$p-$i.in
            sleep 2
        done
    done
done
