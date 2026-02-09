#ifndef IO_H
#define IO_H

#define VIDEO_BUFFER 0x8000
#define SCREEN_WIDTH 80
#define SCREEN_HIGH 25

typedef enum {
    BLACK = 0x0,
    DARK_BLUE,
    DARK_GREEN,
    DARK_CYAN,
    DARK_RED,
    DARK_PINK,
    ORANGE,
    LIGHT_GRAY,
    GREY,
    BLUE,
    GREEN,
    CYAN,
    RED,
    PINK,
    YELLOW,
    WHITE
} termColor;

void setColor(termColor color);
void printChar(char c);
void pintString(char *s);

#endif
