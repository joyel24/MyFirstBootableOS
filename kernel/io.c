#include "io.h"

int scr_x = 0;
int scr_y = 0;
termColor color = WHITE;

void setColor(termColor color){

}

void printChar(char c){
    *(unsigned char*)(VIDEO_BUFFER + (scr_y*SCREEN_WIDTH+scr_x)*2) = c;
    *(unsigned char*)(VIDEO_BUFFER + (scr_y*SCREEN_WIDTH+scr_x)*2+1) = color;

    if (c == '\n'){
        scr_y++;
        scr_x=0;
        return;
    }

    scr_x++;

    if (scr_x == SCREEN_WIDTH){
        scr_y++;
        scr_x=0;
    }
}

void pintString(char *s){

}
