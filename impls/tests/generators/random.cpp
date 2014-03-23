#include <iostream>
#include <cstdlib>
#include <ctime>
#include <vector>

using namespace std;

double randomDouble(){
    return (rand()+.0)/RAND_MAX;
}

typedef pair<int, int> E;

int main(){
    int n;
    double p;
    cin >> n >> p;
    srand(time(NULL));
    vector<E> edges;
    for(int i = 0; i < n; ++i)
        for(int j = 0; j < i; ++j){
            if(randomDouble() < p) edges.push_back(E(i, j));
        }
    cout << n << " " << edges.size() << endl;
    for(int i = 0; i < int(edges.size()); ++i)
        cout << edges[i].first << " " << edges[i].second << endl;
}
