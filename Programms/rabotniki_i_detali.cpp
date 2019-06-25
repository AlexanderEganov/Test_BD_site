#include <iostream>
using namespace std;
int main()
{
int sum = 0 ;
int evol = 60000000;
int m=20;
int n=30;
int Spisok[m][n];
int etallon_rab[n+1];
int array_rand[n];
int chempion_rab[n];
int i;
int j;
for (int i = 0; i < m; i++)
    for (int j = 0; j < n; j++)
{
    Spisok[i][j] = 20 + rand() % 60;
}

for (int t = 0; t < evol; t++)
    {
    sum = 0;
    for (int i = 0; i < n; i++)
        {
        array_rand[i] = 0 + rand() % 19;
        etallon_rab[i] = Spisok[array_rand[i]][i];
        sum = sum + etallon_rab[i];
        }
    if (sum > etallon_rab[n+1])
        etallon_rab[n+1] = sum;
        for (int i = 0; i < n; i++)
        {
         chempion_rab[i] = array_rand[i];
        }
    }
cout << "luchshiy rezultat dostigaetsya kogda:"<<endl;
for (int i = 0; i < n; i++)
{
    cout << "Nad detalu # " << i+1 << " rabotaet: " << chempion_rab[i]+1 << " rabotnik" <<endl;
}
cout <<"obshimi silami ih trudovoy kooficient sostavil: "<< etallon_rab[n+1]<<" slava geroyam truda))"<<endl;
}
