#include<stdio.h>
#include<iostream>
#include<math.h>
using namespace std;
float func(float x, float y) 
{
	float F=0;
	F=(x*x)-(2*y);
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

float y0;
float y;
printf("введите значение y при 0 \n");
cin >> y0;
printf("y0= %f \n", y0);

float chislo_shagov1 = (b-a)/h1;
printf("число шагов  %f \n", chislo_shagov1);
float i=a;
int iteraciya=1;
float delta_y;
//delta_y=h*func((i+(h/2)),(y0+(h/2)*func(i;y0))
while(i<=b)
{
printf("итерация %d \n",iteraciya );
delta_y=h1*func((i+(h1/2)),(y0+(h1/2)*func(i,y0)));
	printf("delta_y= %f \n", delta_y );
y=y0+delta_y;
printf("значения x и y в %dой итерации = %f и %f \n",iteraciya,i+h1,y );
y0=y;
i=i+h1;
iteraciya=iteraciya+1;

}





}