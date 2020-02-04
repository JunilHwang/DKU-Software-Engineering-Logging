// poly.cpp : 콘솔 응용 프로그램에 대한 진입점을 정의합니다.
//

#include "stdafx.h"


#include <iostream>
using namespace std;

#include "Polynomial.h"
#include "Term.h"

int _tmain(int argc, _TCHAR* argv[])
{
    Polynomial A, B, C;
    int i, n, e ;
	float c ;

	cout << "다항식 A의 항의 수 : " ;

	cin  >> n ;

	for ( i = 1; i <= n; i++ ) {
		cout << "다항식 A의 "<< i << " 번째 항의 계수와 지수 : " ;
		cin >> c >> e ;

		A.NewTerm(c, e) ;
	}

	cout << "다항식 B의 항의 수 : " ; 
	cin >> n ;

	for ( i = 1; i <= n; i++ ) {
		cout << "다항식 B의 "<< i << " 번째 항의 계수와 지수 : " ;
		cin >> c >> e ;

		B.NewTerm(c, e) ;
	}

	C = A.Add(B) ;
    C.Print() ;

//    cin >> n ;

	return 0;
}

