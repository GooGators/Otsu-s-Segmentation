function [ ostuImage ] = otsuSeg( inputImage )

[m,n] = size(inputImage);
numberofpixels = m*n;

% Here, Use only [1,255] as our intensity levels. for the otsu algorithm
% loop to find the best segmention. it will be no effection to find the max
% class variance. 
intensityLevels = 255;

% Create probalility array.
probability = zeros(1,intensityLevels);
levelVector = 1:(intensityLevels);
% Create filter0 and filter1, which will help me to calculte mean.
filter0 = zeros(1,intensityLevels);
filter1 = ones(1,intensityLevels);
% Create class variance function.
classVar = zeros(1,intensityLevels);

% Calculate the probalility at every intensity level.
% After trying many time, use intensity level [1,255], which gives a better
% result. This is one improvement.
for i = 1:(intensityLevels)
    intensityPixels = (inputImage == i);
    numberofintensity =  sum(sum(intensityPixels(:)));
    probability(i) = numberofintensity / numberofpixels;
end

% Calculate the class variance.
for k = 1:(intensityLevels)
    % filters help to choose the elements, [1,k] or [k+1,255].
    filter0(k) = 1;
    filter1(k) = 0;
    % First calculate the probability of [1,k] and calculate the mean. 
    prob_1 = sum(filter0.*probability);
    prob_2 = sum(filter1.*probability);
    mean_1 = sum(filter0.*levelVector.*probability)/prob_1;
    mean_2 = sum(filter1.*levelVector.*probability)/prob_2;
    % Calculate the class variance.
    classVar(k) = prob_1*prob_2*(mean_1-mean_2)^2;
end

% Find the index of element with max variance.
optK = find(classVar == max(classVar),1);
ostuImage = (inputImage>(optK));
    
end

