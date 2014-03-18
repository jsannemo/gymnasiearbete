#pragma once

#include <iostream>
#include <vector>

typedef std::pair<int,int> Edge;
typedef std::vector<int> Adj;
typedef std::vector<Adj> AdjList;

struct Instance {
    int vertices;
    std::vector<Edge> edges;
    AdjList adj;

    Instance(int v) : vertices(v) {
        adj.resize(v);
    }

    void addEdge(int u, int v){
        adj[u].push_back(v);
        adj[v].push_back(u);
        edges.push_back(Edge(u, v));
    }

};

Instance readInstance(){
    int v, e;
    std::cin >> v >> e;
    Instance inst(v);
    for(int i = 0; i < e; ++i){
        int u, v;
        std::cin >> u >> v;
        inst.addEdge(u, v);
    }
    return inst;
}
