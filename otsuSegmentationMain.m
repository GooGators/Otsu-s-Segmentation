clear all;
clc;

%% Read the image
imageArray = imread('white.jpg');
figure(1)
imshow(imageArray)

%Get red, green, blue channel from image.
grayImageR = double(imageArray(:,:,1));
grayImageG = double(imageArray(:,:,2));
grayImageB = double(imageArray(:,:,3));
[m,n] = size(grayImageR);

%% Use otsu's algorithm to different channel.
% Apply ostu's algorithm to red channel. here the iteration is 4 times to
% get a better result.
for i = 1:3
    segR = otsuSeg(grayImageR);
    grayImageR = grayImageR.*segR;
end
figure(2)
imshow(segR)
imwrite(segR, 'segR.bmp', 'bmp')
% Apply otsu's algorithm to green channel. here the iteration is 4 times to
% get a better result.
for i = 1:3
    segG = otsuSeg(grayImageG);
    grayImageG = grayImageG.*segG;
end
figure(3)
imshow(segG)
imwrite(segG, 'segG.bmp', 'bmp')
% Apply otsu's algorithm to blue channel. here the iteration is 1 times to
% get a better result.
for i = 1:1
    segB = otsuSeg(grayImageB);
    grayImageB = grayImageB.*segB;
end
figure(4)
imshow(segB)
imwrite(segB, 'segB.bmp', 'bmp')
%% Get the overrall mask.
% (not(redchannelmask))&&(not(redchannelmask)&&(bluechannelmask)
segImage = (not(segR)).*(not(segG)).*segB;
figure(5)
imshow(not(segImage))
imwrite(not(segImage), 'mask.bmp', 'bmp')
