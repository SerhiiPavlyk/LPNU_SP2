#include <windows.h>
#include <stdio.h>
#include <iostream>

 int main()
{
    TCHAR szPath[MAX_PATH];
    std:: cout << GetModuleFileName(NULL, szPath, MAX_PATH);

}