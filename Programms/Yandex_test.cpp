#include <iostream>
#include "stdio.h"
#include "string.h"
#include <vector>

using namespace std;

int main() {
	int n,m, buf2;
	float buf, am = 0, SUMi = 0;
	vector <float> 			mas_buf;
	vector <vector <float>> x;
	vector <float>			a;
	vector <int> 			y;

	cin >> n;
	cin >> m;

	for (int i = 0; i < n; i++) {
		for (int j = 0; j < m; j++) {
			cin >> buf;
			mas_buf.push_back(buf);
		};

		x.push_back(mas_buf);
		mas_buf.clear();

		cin >> buf2;
		y.push_back(buf2);
	};

	for (int i = 0; i < n; i++) {
		for (int j = 0; j < m-1; j++) {
			SUMi += x[0][j]*x[i][j];
		};
		am = (am > (-SUMi/x[i][m-1])) ? am : -SUMi + 1;
		SUMi = 0;
	};


	for (int j = 0; j < m-1; j++)
		cout << x[0][j] << " ";

	cout << am;




};
