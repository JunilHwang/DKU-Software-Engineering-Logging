#pragma once

#include "Term.h"

class Polynomial  
{
private:
 	Term *termArray;
	int capacity;    // 배열의 크기
	int terms;       // 0이 아닌 항의 수
public:
	void Print(void);
	void NewTerm(const float theCoeff, const int theExp);
	Polynomial Add(Polynomial b);

	Polynomial(void);
	~Polynomial(void);
};