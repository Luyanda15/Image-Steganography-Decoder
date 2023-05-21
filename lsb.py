from PIL import Image
import numpy as np
#def hide_data(seed, input_data, output_file, carrier):
#    byte_written = 0
#    img = Image.open(carrier, "r")
#    width, height = img.size
#    matrix = np.array(list(img.getdata()))
#    generator = random.seed(seed)
#    used_pixels = set()

def convert_message_to_binary(message):

    # The message is divided into segments of 7

    b_message = ""
    for i in message:
        #print(ord(i))
        #print(bin(ord(i)))
        character = bin(ord(i))[2:]

        #b_message += str(bin(ord(i)))[2:]
        b_message += ("0" * (8 - len(character))) + character
        print("Binary message = {}, size = {}".format(b_message, len(b_message)))
        print(bin(ord(i)))

    return b_message

def encode():
    message = "Hello world!"
    delimiter = "%%"
    
    print(convert_message_to_binary(message + delimiter))
    print(len(convert_message_to_binary(message + delimiter)))
    b_message = convert_message_to_binary(message + delimiter)
    counter = 0
    
    image_src = "cat_pic.png"
    img = Image.open(image_src)
    width, height = img.size
    
    if img.mode != "RGB" and img.mode != "RGBA":
        print(img.mode)
        quit()
    
    image_pixels = img.load()
    encoded_image_list = list()
    
    array = np.array(list(img.getdata()))

    print(len(array))
    
    #print(img.getdata())
    
    #for i in range(width):
    #    for j in range(height):
    #        #print(image_pixels[i,j])
    #        for k in range(len(img.mode)):
    #            if counter == len(b_message):
    #                print("Done encoding the message")
    #                quit()
    #
    #            channel_value_binary = bin(image_pixels[i,j][k])[2:]
    #            print(image_pixels[i,j][k])
    #            image_pixels[i,j][k] = int(channel_value_binary[:len(channel_value_binary) - 1] + str(int(channel_value_binary[-1], 2) & int(b_message[counter], 2)), 10)
    #            count += 1
    #            #print(bin(image_pixels[i,j][k]))
    #            #encoded_image_list.append(image_pixels[i,j][k])
    #
    #enc_img = Image.fromarray(image_pixels, img.mode)
    #enc_img.save("Test.png")
    
    ########## for p in range(total_pixels):
    ##########     for q in range(0, 3):
    ##########         if index < req_pixels:
    ##########             array[p][q] = int(bin(array[p][q])[2:9] + b_message[index], 2)
    ##########             index += 1
    ########## 
    ########## array=array.reshape(height, width, n)
    ########## enc_img = Image.fromarray(array.astype('uint8'), img.mode)
    ########## enc_img.save("Test.png")
    
    print("Width = {}, Height = {}, Image mode = {}".format(width, height, img.mode))
    
    ############################################################################################
    # The following is for encoding with the code, it also uses lines from abovee
    if img.mode == 'RGB':
        n = 3
    elif img.mode == 'RGBA':
        n = 4
    
    total_pixels = array.size//n
    #print(total_pixels)
    #print(array.size)
    #quit()
    
    req_pixels = len(b_message)
    print(req_pixels)

    if req_pixels > total_pixels:
        print("ERROR: Need larger file size")
    else:
        index = 0
        for i in range(len(array)):
            for j in range(len(img.mode)):
                if index < req_pixels:
                #if index < 10:
                    channel_value_binary = bin(array[i][j])[2:]
                    #print("Before = ", array[i][j])
                    array[i][j] = int(channel_value_binary[:len(channel_value_binary) - 1] + str((int(channel_value_binary[-1], 2) & ~1) | int(b_message[index], 2)), 2)
                    #print("After = ", array[i][j])
                    index += 1
                #break
            #break
            #quit()
    
    array=array.reshape(height, width, n)
    enc_img = Image.fromarray(array.astype('uint8'), img.mode)
    #enc_img = Image.fromarray(array, img.mode)

    enc_img.save("Testing_main_encode.png")
    print("Image Encoded Successfully")
    ############################################################################################

def decode():
    image_src = "Testing_main_encode.png"
    img = Image.open(image_src)
    width, height = img.size

    array = np.array(list(img.getdata()))

    lsb = ""
    counter = 0
    for i in range(len(array)):
        #print(array)
        for j in range(len(img.mode)):
            #print(array[i][j])
            #print(bin(array[i][j])[-1])
            lsb += bin(array[i][j])[-1]
            #print("Binary pixel = ", bin(array[i][j]))
            #print(bin(array[i][j])[-1])
            #break
        #break

    print("Size =", len(lsb), "Binary =", lsb)
    #quit()
    #print("{} = lsb bits, size = {}".format(lsb, len(lsb)))
    message = ""
    for z in range(0, len(lsb), 8):
        if "%%" in message:
            break
        else:
            print("{} = is the message".format(message))
            message += chr(int(lsb[z:z+8], 2))
            print(int(lsb[z:z+8], 2))

    print(message)

encode()
decode()
