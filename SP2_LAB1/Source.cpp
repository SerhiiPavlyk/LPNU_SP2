#include <stdio.h>
extern "C" int calc(int, char, short);
extern "C" short K = 0x614;//1556
//extern "C" int K = 0;
int main()
{
	printf("A4 - B1 - 1556 - D2/2 + 4 * B1 \n");
	int a;
	char b;
	short d;
	printf("Enter numbers:\n");
	while (true)
	{
		printf("A = ");
		scanf_s("%d", &a);
		if (a < 2147483648 && a >-2147483648)
			break;
		else
			printf("Out of the range! Try another number\n");
	}
	while (true)
	{
		printf("B = ");
		scanf_s("%hhu", &b);
		if (b < 128 && b >-128)
			break;
		else
			printf("Out of the range! Try another number\n");
	}
	while (true)
	{
		printf("D = ");
		scanf_s("%hd", &d);
			if (d < 32768 && d >-32768)
				break;
			else
				printf("Out of the range! Try another number\n");
	}
	printf("\nA4 - B1 - K - D2/2 + 4 * B1 = %d\n", a - b - K - d/2+4*b);
	printf("\nResult of procedure calc is: %d\n", calc(a, b, d));
	return 0;
}
