#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
	//takes the first argument
	if (argc != 2) {
        	fprintf(stderr, "Usage: %s <n>\n", argv[0]);
        	return 1;
    	}
	
	char *ptr;
	long n = strtol(argv[1], &ptr, 10);

	if (ptr == argv[1] || *ptr != '\0') {
		printf("ERROR: %s is not a valid number.\n", argv[1]);
		exit(1);
	} 
	if (n < 0) {
		printf("ERROR: n must be a positive number.\n");
		exit(1);
	}

	long result = 1;

    	//multiplication
    	for (int i = 2; i <= n; i++) {
        	result *= i;
    	}

    	printf("%ld\n", result);
    	return 0;
}
