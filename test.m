% Load images
image3 = imread('S3-im1.png');
image4 = imread('S3-im2.png');
%image3
% Convert images to grayscale if necessary
if size(image3, 3) == 3
    image3 = rgb2gray(image3);
end

if size(image4, 3) == 3
    image4 = rgb2gray(image4);
end

keypoints3s = detectFASTFeatures(image3);
keypoints4s = detectFASTFeatures(image4);

[features3s, validPoints3s] = extractFeatures(image3, keypoints3s);
[features4s, validPoints4s] = extractFeatures(image4, keypoints4s);

indexPairs2s = matchFeatures(features3s, features4s);

matchedPoints3s = validPoints3s(indexPairs2s(:, 1));
matchedPoints4s = validPoints4s(indexPairs2s(:, 2));

[H2, inliersIdx2] = estimateGeometricTransform2D(matchedPoints4s, matchedPoints3s, 'projective', 'MaxNumTrials', 1000, 'Confidence', 99);

outputSizes2 = [size(image3, 1), size(image3, 2) + size(image4, 2)]; 
stitchedImgs2 = imwarp(image4, H2, 'OutputView', imref2d(outputSizes2));

stitchedImgs2(1:size(image3, 1), 1:size(image3, 2)) = image3;

imshow(stitchedImgs2);
title('Stitched Image');

imwrite(stitchedImgs2, 'S1-panorama.png');
