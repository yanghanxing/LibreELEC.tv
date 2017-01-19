
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main()
{
	char *data = NULL;
	int size = 0;
	printf("size = %d\n", size);
	while (1)
	{
		data = (char *)malloc(1024 * 1024);
		if (data == NULL) {
			printf("data = %p\n", data);
		} else {
			printf("size = %d, data = %p\n", ++size, data);
			memset(data, 0, 1024 * 1024);
		}
		usleep(20000);
	}
	return 0;
}
