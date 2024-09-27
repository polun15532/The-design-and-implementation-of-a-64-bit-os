#include "unistd.h"
#include "stdio.h"
#include "fcntl.h"
#include "stdlib.h"

int main()
{
    int fd = 0;
    char string[] = "/JIOL123Llliwos/89AIOlejk.TXT";

    unsigned char buf[32] = {0};
    fd = open(string, 0);
    write(fd, string, 20);
    lseek(fd, 5, SEEK_SET);
    read(fd, buf, 30);
    close(fd);
    putstring(buf);

    if (fork() == 0)
        putstring("child process\n");
    else
        putstring("parent process\n");
    malloc(100);
    while (1);
    return 0;
}