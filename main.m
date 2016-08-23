clear;

%input desired image file here
image = imread('tree.jpg'); 

image = im2double(image);
figure(1);
imshow(image);
origimage=image;
image = rgb2gray(image);

%input desired seams to be cropped here
numSeams = 100;

%default seam direction is vertical
%change this to true if desired seam direction is horizontal
horizSeams = false;

%different energy function
eHogFunc = false;

newImage = findSeams(image, numSeams, origimage, horizSeams, eHogFunc);



