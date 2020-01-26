#include "StdAfx.h"
#include "Polynomial.h"
#include "Term.h"

#include <iostream>
using namespace std;

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////
Polynomial::Polynomial(void)
{
    capacity = 4;
	terms = 0 ;
	termArray = new Term[capacity] ;  // 크기 4 로 배열 생성
}

Polynomial::~Polynomial(void)
{

}

Polynomial Polynomial::Add(Polynomial b)
// a(x)(*this의 값)와 b(x)를 더한 결과를 반환한다.
{
  Polynomial c; 
  int aPos = 0, bPos = 0 ;

  while ((aPos < terms) && (bPos < b.terms))
    if(termArray[aPos].exp == b.termArray[bPos].exp) {
        float t = termArray[aPos].coef + b.termArray[bPos].coef;
        if (t) c.NewTerm(t, termArray[aPos].exp);
        aPos++; bPos++;
	}
	else if (termArray[aPos].exp < b.termArray[bPos].exp) {
        c.NewTerm(b.termArray[bPos].coef, b.termArray[bPos].exp);
        bPos++;
	}
	else {
        c.NewTerm(termArray[aPos].coef, termArray[aPos].exp);
        aPos++;
    } 

  // A(x)(*this)의 나머지 항들을 추가한다.
  for (; aPos < terms; aPos++)
    c.NewTerm(termArray[aPos].coef, termArray[aPos].exp);

  // B(x)의 나머지 항들을 추가한다.
  for (; bPos < b.terms; bPos++)
    c.NewTerm(b.termArray[bPos].coef, b.termArray[bPos].exp);
 
  return c;
} // Add의 끝


void Polynomial::NewTerm(const float theCoeff, const int theExp)
// 새로운 항을 termArray 끝에 첨가한다.
{
    if (terms == capacity) 
    {//termArray의 크기를 두 배로 확장
          capacity *= 2; 
          Term *temp = new Term [capacity];           // 새로운 배열
		  for(int i=0; i<terms ; i++) 
			  temp[i] = termArray[i] ;
          delete [ ] termArray;                       // 그전 메모리를 반환
          termArray = temp;
	} 
    termArray[terms].coef = theCoeff;
    termArray[terms++].exp = theExp;
}


void Polynomial::Print()
{
   int i ;

   cout << "\n" ;
   if (terms) {
      for (i = 0 ; i < terms-1 ; i++)
	      cout << termArray[i].coef << " x^" << termArray[i].exp << " + " ;
      // 마지막 항을 출력
      cout << termArray[i].coef << " x^" << termArray[i].exp << "\n" ;
   }
   else
	  cout << " No terms " ;

}
