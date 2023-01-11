#include <stdio.h>
#include <math.h>
extern "C" double calc(double,float,float);
int main()
{
	printf("(8*lg(d+1)-c)/(a/2+d*c) c > d\n");
	printf("(4*c-ln(d-1))/(a/d+18) c <= d\n");
	double a;
	float c,d;
	double res = 0;
	printf("Enter numbers:\n");
	printf("c = ");
	scanf_s("%f", &c);
	printf("d = ");
	scanf_s("%f", &d);
	printf("a = ");
	scanf_s("%lf", &a);
	if (c > d)
	{
		while (true)
		{
			if (d > -1)
			{
				printf("\n(8*lg(d+1)-c)/(a/2+d*c) = %0.32lf\n", (8 * log10(d + 1) - c) / (a / 2 + d * c));
				break;
			}
			else
			{
				printf("d must be more than -1!\n");
				printf("Enter numbers:\n");
				printf("d = ");
				scanf_s("%f", &d);
			}
		}
	}
	else
	{
		while (true)
		{
			if (d > 1)
			{
				printf("\n(4*c-ln(d-1))/(a/d+18) = %0.32lf\n", (4 * c - log(d - 1)) / (a / d + 18));
				break;
			}
			else
			{
				printf("d must be more than 1!\n");
				printf("Enter numbers:\n");
				printf("d = ");
				scanf_s("%f", &d);
			}
		}
	}
	res = calc(a,c,d);
	printf("\nResult of func calc is:   %0.32lf\n", res);
	return 0;
}
