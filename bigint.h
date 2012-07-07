#ifndef bigint_h
#define bigint_h
#include <iostream>
#include <vector>
#include <istream>
#include <iostream>
#include <string>
using std::string;
using std::ostream;
using std::istream;
using std::vector;

class BigInt {
public:
	BigInt();
	BigInt(vector<int>);
	BigInt(int);
	BigInt(const string);
	bool operator==(const BigInt&);
	bool operator==(int);
	bool operator==(vector<int>);
	BigInt& operator++();
	friend BigInt operator+(const int&, const BigInt&);
	BigInt operator++(int);
	BigInt& operator+=(BigInt&);
	void times_10(int);
	void times_single_digit(const int);
	BigInt operator*(const BigInt&);
	int operator[](const int);
	BigInt operator+(const BigInt&) const;
	string operator+(const string&) const;
	string to_string  ();
	friend ostream& operator<< (ostream&,BigInt&);
	friend istream& operator>>(istream&, BigInt&);
private:
	vector<int> digits;
	void zero ();


};
#endif // bigint_h__