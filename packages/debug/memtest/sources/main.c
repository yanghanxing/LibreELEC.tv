
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define ALLOC_SIZE (1 * 1024 * 1024)

int main()
{
	char *data = NULL;
	int size = 0;
	printf("size = %d, data = %p (start)\n", size, data);
	while (1)
	{
		printf("size = %d, data = %p (pre-malloc)\n", size, data);
		data = (char *)malloc(ALLOC_SIZE);
		printf("size = %d, data = %p (post-malloc)\n", size, data);
		if (data != NULL) {
			size += ALLOC_SIZE / 1024 / 1024;
			printf("size = %d, data = %p (pre-memset)\n", size, data);
			memset(data, 0, ALLOC_SIZE);
			printf("size = %d, data = %p (post-memset)\n", size, data);
		}
		printf("size = %d, data = %p (pre-usleep)\n", size, data);
		usleep(20000);
		printf("size = %d, data = %p (post-usleep)\n", size, data);
	}
	return 0;
}
