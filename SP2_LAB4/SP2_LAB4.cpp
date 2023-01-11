#include "..\SP2_LAB4_DLL\dllmain.h"
#include <string>
int main()
{
    std::string text;
    while (true)
    {
        std::cout << "Enter text:\n";
        std::getline(std::cin, text);
        std::cout << removeMiddleLetter(text) << std::endl;
    }
    system("pause");
    return 0;
}