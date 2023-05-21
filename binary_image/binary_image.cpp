// binary_image.cpp : This file contains the 'main' function. Program execution begins and ends there.
//
#define _CRT_SECURE_NO_WARNINGS

#include <stdio.h>
#define STB_IMAGE_IMPLEMENTATION
#include "stbi_image.h"

int main()
{
    int width,  height, num_channels;

    int desired_channels = 3;

    const char* filename = "Original_image.png";

    FILE* bin_image = NULL;
    bin_image = fopen("Original _image.hex", "w");


    unsigned char* data = stbi_load(filename, &width, &height, &num_channels, 0);
    
    printf("Width : %d, Height : %d", width, height);

    for (int j = 0; j < height; j++)
    {
        for (int i = 0; i < width; i++)
        {
            //fputc((char)data[j + i * j], bin_image);
            fprintf(bin_image, "%x\n", data[i * j + i]);
        }
    }

    fclose(bin_image);
    char c;
    scanf("%c", &c);
}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
