#include <algorithm>
#include "input.h"

using namespace std;

bool color(Instance &g, vector<int> &a, int i, int k, int maxA){
    if(i == g.vertices){
        for(int j = 0; j < int(g.edges.size()); ++j){
            if(a[g.edges[j].first] == a[g.edges[j].second]){
                return false;
            }
        }
        return true;
    }
    int lim = min(k, maxA + 2);
    for(int c = 0; c < lim; ++c){
        a[i] = c;
        if(color(g, a, i + 1, k, max(maxA, c))){
            return true;
        }
    }
    return false;
}

int chromaticNumber(Instance &inst){
    int d = 0;
    for(int i = 0; i < inst.vertices; ++i){
        d = max(d, int(inst.adj[i].size()));
    }
    int lo = 0, hi = d + 1;
    vector<int> a(inst.vertices);
    while(hi - lo > 1){
        int mid = (hi + lo) / 2;
        if(color(inst, a, 0, mid, -1)){
            hi = mid;
        } else {
            lo = mid;
        }
    }
    return hi;
}

int main(){
    Instance inst = readInstance();
    cout << chromaticNumber(inst) << endl;
}
