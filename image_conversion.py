from PIL import Image

image_name = 'final_image.png'

img = Image.open(image_name)

#img.show()
img_format = img.format
img_mode = img.mode
img_size = img.size

channels = 0

if img_mode == "RGBA":
    channels = 4
else:
    channels = 3

img_pixels = img.load()

print("Image format =", img_format)
print("Image mode =", img_mode)
print("Image size =", img_size)

with open("image_values_final.txt", "w") as f:
    for i in range(img_size[0]):
        for j in range(img_size[1]):
            for k in range(channels):
                f.write(str(img_pixels[i,j][k]) + "\n")

print(img_pixels)
