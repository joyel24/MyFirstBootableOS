#include "io.h"

void main(void) {

    for(int i=0; i<2332; i++){
        *((unsigned char*)0xB8000 + i*2) = 'N';
        *((unsigned char*)0xB8000 + i*2+1) = i;
    }
}
