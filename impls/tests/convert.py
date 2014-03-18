from sys import stdin

for line in stdin.readlines():
    parts = line.split()
    if parts[0] == 'c':
        continue
    if parts[0] == 'p':
        print("%s %s" % (parts[2], parts[3]))
    if parts[0] == 'e':
        u, v = [int(parts[1]), int(parts[2])]
        print("%d %d" % (u - 1, v - 1))
