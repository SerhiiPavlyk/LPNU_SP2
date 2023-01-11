#ifndef _DLLMAIN_H_
#define _DLLMAIN_H_
#include <iostream>

extern "C" __declspec(dllexport) std::string removeMiddleLetter(std::string text);
#endif