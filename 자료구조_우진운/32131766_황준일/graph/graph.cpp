// graph.cpp : 콘솔 응용 프로그램에 대한 진입점을 정의합니다.
// 템플리트의 사용으로 한 파일에 모든 클래스들을 포함하고 있음

#include "stdafx.h"
#include <iostream>
using namespace std;

class Graph;   //전방선언

 //연결리스트로 그래프를 표현하기 위한 노드 선언
class ChainNode {       // 하나의 노드 클래스
friend class Graph; 
private:
   int data;       // 데이터 필드
   ChainNode *link;  // 링크 필드
};

typedef ChainNode *ChainNodePointer ;

class Graph
{
public:
	Graph(int size) ;
	void InsertEdge(int v, int u);    // 인접리스트로 표현
    void PrintVertex();               // 인접리스트의 출력
    void DFS(const int v);            // 깊이 우선 탐색
    void Components();                // 연결요소 구하기
private:
    ChainNodePointer *HeadNodes;   // 인접리스트에서 한 정점의 헤드 노드
	int n ;                        // n: 정점의 수
	bool *visited ;                // 방문 여부를 표시
};

Graph::Graph(int size)
{ 
	HeadNodes = new ChainNodePointer[size]; // n개의 헤드노드 배열 생성
	visited   = new bool[size];          // n개의 visited 필드 생성
	n = size;
    for(int i=0; i<n; i++) {
	   HeadNodes[i] = 0 ;     // 헤드 노드의 초기화
       visited[i] = false;    // visited 필드의 초기화
	}
}

void Graph::InsertEdge(int u, int v) 
{
   // 정점 u의 연결리스트의 맨 앞에 노드를 삽입
   ChainNode *p = new ChainNode();
   p->data = v; 
   p->link = HeadNodes[u] ;
   HeadNodes[u] = p ;

   // 정점 v의 연결리스트의 맨 앞에 노드를 삽입
   p = new ChainNode();
   p->data = u ;
   p->link = HeadNodes[v] ;
   HeadNodes[v] = p ;
}

void Graph::PrintVertex()
{
   cout << "\n\n 리스트로 표현했을 때  -----   ";

   for(int i=0; i<n; i++)
   {
       cout << "\n " << i << " 의 인접정점: ";
       for(ChainNode *p = HeadNodes[i]; p; p=p->link)
           cout << p->data << "  ";
   }
}

void Graph::DFS(const int v)
{
   cout << v << "  ";
   visited[v] = true;
   for(ChainNode *p = HeadNodes[v]; p; p=p->link)
   {
       int w = p->data;
       if (!visited[w])
       {
           DFS(w);
       }
   }
}

void Graph::Components()
{
   cout << "\n\n DFS로 연결 요소 구하기:";
   for(int i=0; i<n; i++)
       if(!visited[i]) {
		   cout << "\n 하나의 연결 요소 - ";
           DFS(i);      // 하나의 요소 발견
	   }
}

int _tmain(int argc, _TCHAR* argv[])
{
   int n, e ;  // n: 정점의 수, e: 간선의 수
   int k, u, v ;
   cout << " 정점의 수와 간선의 수를 입력하시오: ";
   cin >> n >> e ;

   Graph g(n);
   
   for(int i=0; i<e; i++) {
	   k = i+1;
       cout << k << "번째 간선(u, v)를 입력 > ";
	   cin >> u >> v ;
       g.InsertEdge(u, v);
   }
   g.PrintVertex();  // 입력된 그래프의 연결리스트 출력
   g.Components();   // 입력된 그래프의 연결 요소 구하기
   cout << "\n\n";

   return 0;
}

