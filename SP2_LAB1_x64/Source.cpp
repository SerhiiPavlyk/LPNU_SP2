#include <stdio.h>
extern "C" long long int calc(int, char, short);
extern "C" short K = 0x614;//1556
int main()
{
	printf("A4 - B1 - 1556 - D2/2 + 4 * B1 \n");
	int a;
	char b;
	short d;
	long long int res;
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
	printf("\nA - B - K - D/2 + 4 * B = %lld\n", a - b - K - d / 2 + 4 * b);
	res = calc(a, b, d);
	printf("\nResult of procedure calc is: %lld\n", res);
	return 0;
}