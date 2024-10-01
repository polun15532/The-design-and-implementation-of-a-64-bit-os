/***************************************************
*		版权声明
*
*	本操作系统名为：MINE
*	该操作系统未经授权不得以盈利或非盈利为目的进行开发，
*	只允许个人学习以及公开交流使用
*
*	代码最终所有权及解释权归田宇所有；
*
*	本模块作者：	田宇
*	EMail:		345538255@qq.com
*
*
***************************************************/

#include "init.h"
#include "stddef.h"
#include "unistd.h"
#include "stdio.h"
#include "stdlib.h"
#include "fcntl.h"
#include "string.h"
#include "keyboard.h"
#include "printf.h"
#include "reboot.h"
#include "errno.h"
#include "dirent.h"
#include "wait.h"

#define MAX_PATH_LEN 1024
char current_dir[MAX_PATH_LEN] = "/";

int read_line(int fd,char *buf);
int parse_command(char *buf, int *argc, char ***argv);
void run_command(int index, int argc, char **argv);

int main()
{
    int fd = 0;
    unsigned char buf[256] = {0};
    char path[] = "/KEYBOARD.DEV";
    int index = -1;

    fd = open(path, 0);
    
    while (1) {
        int argc = 0;
        char **argv = NULL;
        printf("[SHELL]#:");
        memset(buf, 0, 256);
        read_line(fd, buf);
        printf("\n");
        index = parse_command(buf, &argc, &argv);
        if (index < 0)
            printf("Invalid command\n");
        else
            run_command(index, argc, argv);
    }
    close(fd);
    return 0;
}

void simplifyPath(char *tmp, char *input) {
    int tmp_len = 0;
    int input_len = strlen(input);
    int i = 0;

    if (input[0] == '/') {
        strcpy(tmp, "/");
        tmp_len = 1;
        i = 1;
    } else {
        tmp_len = strlen(tmp);
        // 確保tmp以 / 結尾
        if (tmp_len > 1 && tmp[tmp_len - 1] != '/') {
            tmp[tmp_len++] = '/';
            tmp[tmp_len] = '\0';
        }
    }

    while (i <= input_len) {
        while (input[i] == '/') {
            i++;
        }

        char segment[MAX_PATH_LEN];
        int seg_len = 0;

        // 提取路徑段
        while (input[i] != '/' && input[i] != '\0') {
            if (seg_len < MAX_PATH_LEN - 1) {
                segment[seg_len++] = input[i];
            }
            i++;
        }
        segment[seg_len] = '\0';

        if (seg_len == 0) {
            break;
        } else if (strcmp(segment, "..") == 0) {
            // 返回上級目錄
            if (tmp_len > 1) {
                if (tmp[tmp_len - 1] == '/') {
                    tmp_len--;
                }
                while (tmp_len > 0 && tmp[tmp_len - 1] != '/') {
                    tmp_len--;
                }
                tmp[tmp_len] = '\0';
            }
        } else if (strcmp(segment, ".") == 0) {
        } else {
            if (tmp_len < MAX_PATH_LEN - 1) {
                if (tmp_len > 1 && tmp[tmp_len - 1] != '/') {
                    tmp[tmp_len++] = '/';
                }
                int j;
                for (j = 0; j < seg_len && tmp_len < MAX_PATH_LEN - 1; j++) {
                    tmp[tmp_len++] = segment[j];
                }
                tmp[tmp_len] = '\0';
            } else {
                // 緩衝區不足
                printf("Path too long\n");
                break;
            }
        }

        while (input[i] == '/') {
            i++;
        }
    }

    if (tmp_len == 0) {
        strcpy(tmp, "/");
    } else {
        tmp[tmp_len] = '\0';
    }
}



int cd_command(int argc, char **argv) {
    char tmp[MAX_PATH_LEN];

    if (argc < 2) {
        printf("cd: missing argument\n");
        return 1;
    }

    strncpy(tmp, current_dir, MAX_PATH_LEN - 1);
    tmp[MAX_PATH_LEN - 1] = '\0';

    // 簡化路徑
    simplifyPath(tmp, argv[1]);

    printf("Simplified Path: %s\n", tmp);

    if (chdir(tmp) == 0) {
        // 存在目標路徑
        strncpy(current_dir, tmp, MAX_PATH_LEN - 1);
        current_dir[MAX_PATH_LEN - 1] = '\0';
        printf("pwd switch to %s\n", current_dir);
    } else {
        printf("Can't goto dir %s\n", tmp);
    }
    return 1;
}


int ls_command(int argc, char **argv)
{
    struct DIR *dir = NULL;
    struct dirent *buf = NULL;

    dir = opendir(current_dir);
    printf("ls_command opendir:%d\n", dir->fd);
    buf = (struct dirent*)malloc(256);
    while (1) {
        buf = readdir(dir);
        if (buf == NULL)
            break;
        printf("ls_command readdir len:%d,name:%s\n", buf->d_name_len, buf->d_name);
    }
    closedir(dir);
    return 0;
}
int pwd_command(int argc, char **argv)
{
    if (current_dir)
        printf("%s\n", current_dir);
    return 0;
}
int cat_command(int argc,char **argv)
{
    int len = 0;
    char *filename = NULL;
    int fd = 0;
    char *buf = NULL;
    int i = 0;
    len = strlen(current_dir);
    i = len + strlen(argv[1]);
    filename = (char*)malloc(i + 2);
    memset(filename, 0, i + 2);
    strcpy(filename, current_dir);
    if (len > 1)
        filename[len] = '/';
    strcat(filename, argv[1]);
    printf("cat_command filename:%s\n", filename);
    fd = open(filename, O_RDONLY);
    if (fd < 0) {
        printf("cannot find %s\n", filename);
        return -1;
    }
    i = lseek(fd, 0, SEEK_END);
    lseek(fd, 0, SEEK_SET);
    buf = malloc(i + 1);
    memset(buf, 0, i + 1);
    len = read(fd, buf, i);
    printf("length:%d\t%s\n", len, buf);
    free(buf);
    free(filename);
    close(fd);
    return 0;
}

int touch_command(int argc,char **argv){}
int mkdir_command(int argc, char **argv){}
int rmdir_command(int argc, char **argv){}
int rm_command(int argc, char **argv){}
int exec_command(int argc, char **argv)
{
    int errno = 0;
    long retval = 0;
    int len = 0;
    char *filename = NULL;
    int i = 0;

    errno = fork();

    if (errno == 0) {
        printf("child process\n");
        len = strlen(current_dir);
        i = len + strlen(argv[1]);
        filename = malloc(i + 2);
        memset(filename, 0, i + 2);
        strcpy(filename, current_dir);
        if(len > 1)
            filename[len] = '/';
        strcat(filename, argv[1]);

        printf("exec_command filename:%s\n", filename);
        for(i = 0; i < argc; i++)
            printf("argv[%d]:%s\n", i, argv[i]);

        execve(filename, argv, NULL);
        exit(0);       
    } else {
        printf("parent process childpid:%#d\n", errno);
        waitpid(errno, (int*)&retval, 0);
        printf("parent process waitpid:%#018lx\n", retval);        
    }
    return 1;
}
int reboot_command(int argc, char **argv)
{
    reboot(SYSTEM_REBOOT, NULL);
    return 1;
}

struct buildincmd shell_internal_cmd[] = {
    {"cd", cd_command},
    {"ls", ls_command},
    {"pwd", pwd_command},
    {"cat", cat_command},
    {"touch", touch_command},
    {"mkdir", mkdir_command},
    {"rmdir", rmdir_command},
    {"rm", rm_command},
    {"exec", exec_command},
    {"reboot", reboot_command},
};

int find_cmd(char *cmd)
{
    int i = 0;
    // 看以後要不要修改成哈希表
    for (i = 0; i < sizeof(shell_internal_cmd) / sizeof(struct buildincmd); i++) {
        if (!strcmp(cmd, shell_internal_cmd[i].name))
            return i;
    }
    return -1;
}

void run_command(int index, int argc, char **argv)
{
    printf("run_command: %s\n", shell_internal_cmd[index].name);
    shell_internal_cmd[index].function(argc, argv);
}

unsigned char get_scancode(int fd)
{
    unsigned char ret = 0;
    read(fd, &ret, 1);
    return ret;
}

int analysis_keycode(int fd)
{
    unsigned char x = 0;
    int i;
    int key = 0;
    int make = 0;

    x = get_scancode(fd); // 從緩衝區取得鍵盤掃描碼。
    
    if (x == 0xE1) { //pause break;
        key = PAUSEBREAK;
        for (i = 1; i < 6; i++) {
             if (get_scancode(fd) != pausebreak_scode[i]) {
                key = 0;
                break;
            }
        }
    } else if (x == 0xE0) {  //print screen
        x = get_scancode(fd);

        switch (x) {
            case 0x2A: // press printscreen
        
                if (get_scancode(fd) == 0xE0) {
                    if (get_scancode(fd) == 0x37) {
                        key = PRINTSCREEN;
                        make = 1;
                    }
                }
                break;

            case 0xB7: // UNpress printscreen
        
                if (get_scancode(fd) == 0xE0) {
                    if (get_scancode(fd) == 0xAA) {
                        key = PRINTSCREEN;
                        make = 0;
                    }
                }
                break;

            case 0x1d: // press right ctrl
        
                ctrl_r = 1;
                key = OTHERKEY;
                break;

            case 0x9d: // UNpress right ctrl
        
                ctrl_r = 0;
                key = OTHERKEY;
                break;
            
            case 0x38: // press right alt
        
                alt_r = 1;
                key = OTHERKEY;
                break;

            case 0xb8: // UNpress right alt
        
                alt_r = 0;
                key = OTHERKEY;
                break;
            default:
                key = OTHERKEY;
                break;
        }
    }

    if (key == 0) {
        unsigned int * keyrow = NULL;
        int column = 0;

        // make = x & FLAG_BREAK ? 0 : 1;
        make = !(x & FLAG_BREAK);

        keyrow = &keycode_map_normal[(x & 0x7F) * MAP_COLS];

         if (shift_l || shift_r)
            column = 1;

        key = keyrow[column];
        
        switch (x & 0x7F) {
            case 0x2a: //SHIFT_L:
                shift_l = make;
                key = 0;
                break;

            case 0x36: //SHIFT_R:
                shift_r = make;
                key = 0;
                break;

            case 0x1d: //CTRL_L:
                ctrl_l = make;
                key = 0;
                break;

            case 0x38: //ALT_L:
                alt_l = make;
                key = 0;
                break;

            default:
                 if (!make)
                    key = 0;
                break;
        }

        if (key)
            return key;
    }
    return 0;
}

int read_line(int fd, char *buf)
{
    int key = 0;
    int count = 0;
    while (1) {
        key = analysis_keycode(fd);
        if (key == '\n')
            return count;
        if (key) {
            buf[count++] = key;
            printf("%c", key);
        }
    }
}

int parse_command(char *buf, int *argc, char ***argv)
{
    int i = 0;
    int j = 0;
    while (buf[i] == ' ')
        j++;
    
    for (i = j; i < 256 && buf[i]; i++) {
        if (buf[i] != ' ' && (buf[i + 1] == ' ' || buf[i + 1] == '\0'))
            (*argc)++;
    }

    // printf("parse_command: argc = %d\n", *argc);

    if (*argc == 0)
        return -1;

    *argv = (char**)malloc(sizeof(char**) * (*argc));
    // printf("parse_command argv:%#018lx,*argv:%#018lx\n", argv, *argv);

    for (i = 0; i < *argc && j < 256; i++) {
        *((*argv) + i) = buf + j;
        while (buf[j] && buf[j] != ' ')
            j++;
        buf[j++] = '\0';
        while (buf[j] == ' ')
            j++;
        // printf("%s\n", (*argv)[i]);
    }
    return find_cmd(**argv);
}
