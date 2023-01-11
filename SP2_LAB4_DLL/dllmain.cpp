#include "pch.h"
#include "dllmain.h"
extern "C" __declspec(dllexport)std::string removeMiddleLetter(std::string text)
{
    if (text[text.size() - 1] != ' ' && text[text.size() - 1] != '.' && text[text.size() - 1] != ',')
    {
        text += '\0';
    }
    std::string word = "";
    std::string res = "";
    for (int i = 0; i < text.size(); i++)
    {
        if (text[i] == ' ' || text[i] == '.' || text[i] == ',' || text[i] == '\0' || text[i] == ';')
        {
            if (word.size() % 2 != 0 && word.size() != 1)
            {
                std::string temp = word.substr(0, (int)word.size() / 2);
                word = word.substr((int)word.size() / 2 + 1, (int)word.size() / 2);
                word = temp + word;
                res += word + text[i];
                word = "";
                if (text[i + 1] == ' ')
                {
                    res += ' ';
                    i++;
                }
            }

            else
            {
                res += word + text[i];
                word = "";
                if (text[i + 1] == ' ')
                {
                    res += ' ';
                    i++;
                }
            }

        }

        else
        {
            word += text[i];
        }
    }
    return res;
}
