#ifndef MAIN_H
#define MAIN_H

#if WID == 0 || HEI == 0
	#error "You haven't set your screen resolution. Please go to lib/main.h and change the WID and HEI macros."
#endif

char bytes[WID * HEI * 3];

int main(int argc, char *argv[]);
void draw();

#endif
