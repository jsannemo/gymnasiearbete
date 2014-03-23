#include "input.h"
#include <vector>
#include <gmpxx.h>
#include <gmp.h>

using namespace std;

const int MAX_VERTICES = 32;

typedef unsigned int BitSet;

vector<int> a;
vector<BitSet> adj;

BitSet mask;

int getA(BitSet x){
    if(a[x] != -1) return a[x];
    int ans = 0;
    BitSet ffs = 1 << __builtin_ctz(x^mask);
    ans += getA(x | ffs); // don't include ffs
    ans += getA(x | adj[ffs]); // include ffs
    return a[x] = ans;
}

void calculateA(Instance &inst){
    mask = (1u << inst.vertices) - 1u;
    adj.resize(1u << inst.vertices, -1);
    adj[mask] = 0;
    for(size_t i = 0; i <= mask; ++i) getA(i);
}

bool color(Instance &inst, int mid){
    mpz_class ck;
    for(size_t i = 0; i < (1u << inst.vertices); ++i){
        bool par = __builtin_popcount(i)&1;
        mpz_class x = a[i];
        mpz_class ans;
        mpz_pow_ui(ans.get_mpz_t(), x.get_mpz_t(), mid);
        if(par){
            ck -= ans;
        } else {
            ck += ans;
        }
    }
    if(ck > 0) return true;
    return false;
}

int chromaticNumber(Instance &inst){
    a.resize(1u << inst.vertices);
    calculateA(inst);
    int d = 0;
    for(int i = 0; i < inst.vertices; ++i)
        d = max(d, int(inst.adj[i].size()));
    int lo = 0, hi = d + 1;
    while(hi - lo > 1){
        int mid = (hi + lo)/2;
        if(color(inst, mid)){
            hi = mid;
        } else {
            lo = mid;
        }
    }
    return hi;
}

int main(){
    Instance inst = readInstance();
    if(inst.vertices > MAX_VERTICES){
        cerr << "invalid" << endl;
    } else {
        cout << chromaticNumber(inst) << endl;
    }
}
