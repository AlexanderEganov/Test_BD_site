#include<stdio.h>
#include<iostream>
#include<math.h>
using namespace std;
float func(float x) 
{
	float F=0;
	F=(x/((x*x)+9));
 
	 return F;

}

int main()
{
	
float a;
printf("введите левую границу \n");
cin >> a;
printf("a= %f \n", a);
float b;
printf("введите правую границу \n");
cin >> b;
printf("b= %f \n", b);

float h1;
printf("введите шаг 1 \n");
cin >> h1;
printf("h1= %f \n", h1);

float h2;
printf("введите шаг 2 \n");
cin >> h2;
printf("h2= %f \n", h2);

float rez1=0;
float rez2=0;
float chislo_shagov1 = (b-a)/h1;
float chislo_shagov2 = (b-a)/h2;
printf("число шагов 1 %f \n", chislo_shagov1);
printf("число шагов 2 %f \n", chislo_shagov2);


float i=a;

while (i!=b)
{

float xprosh=i-h1;

float chislo_funkcii=((xprosh+i)/2);

float F=func(chislo_funkcii);  	
  	rez1 = rez1+(h1*(F));
  	i=i+h1;  
  }
printf(" результат для первого шага %f \n", rez1);

i=a;

while (i!=b)
{

float xprosh=i-h2;

float chislo_funkcii=((xprosh+i)/2);

float F=func(chislo_funkcii);  	
  	rez2= rez2+(h2*(F));
  	i=i+h2;  
  }
printf(" результат для втогого шага %f \n", rez2);


printf(" ПРОВЕРКА РУНГЕ-РУМБЕР \n");

float k;
k=h1/h2;
int p=2;

 float znach=(abs(rez1-rez2))/((k*k)-1);

printf(" результат для проверки %f \n", znach);



}