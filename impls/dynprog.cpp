#include "input.h"
#include <vector>

using namespace std;

const int MAX_VERTICES = 32;


typedef unsigned int BitSet;

vector<BitSet> adjs;
vector<int> dp;

int sol(BitSet);

int generateIndependent(BitSet left, BitSet now, BitSet neighbours, int last){
    int best = MAX_VERTICES;
    if(now) best = sol(left ^ now) + 1;
    for(int i = last; i < int(adjs.size()); ++i){
        if(!(left & (1 << i))) continue;
        BitSet nnow = now | (1 << i);
        BitSet nneighbours = neighbours | adjs[i];
        if(!(nnow & nneighbours)) best = min(best, generateIndependent(left, nnow, nneighbours, i + 1));
    }
    return best;
}

int sol(BitSet left){
    if(dp[left] != -1) return dp[left];
    return dp[left] = generateIndependent(left, 0u, 0u, 0);
}

int chromaticNumber(Instance &inst){
    dp.resize(1 << inst.vertices, -1);
    adjs.resize(inst.vertices);
    for(int i = 0; i < inst.vertices; ++i){
        for(int j = 0; j < int(inst.adj[i].size()); ++j) adjs[i] |= 1 << inst.adj[i][j];
    }
    dp[0] = 0;
    return sol((1 << inst.vertices)-1);
}

int main(){
    Instance inst = readInstance();
    if(inst.vertices > MAX_VERTICES){
        cerr << "invalid" << endl;
    } else {
        cout << chromaticNumber(inst) << endl;
    }
}
