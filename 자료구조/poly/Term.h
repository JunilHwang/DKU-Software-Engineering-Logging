#pragma once

class Polynomial; //전방선언
class Term
{
friend Polynomial;
private:
	float coef;   // 계수
	int exp;      // 지수

public:
	Term(void);
	virtual ~Term(void);
};
