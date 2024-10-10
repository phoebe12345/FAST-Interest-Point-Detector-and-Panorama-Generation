image = imread('S1-im1.png');
image2 = imread('S1-im2.png');
image3 = imread('S2-im1.png');
image4 = imread('S2-im2.png');
image5 = imresize(imread('S3-im1.png'),[750, 600]);
image6 = imresize(imread('S3-im2.png'),[750, 600]);
image7 = imresize(imread('S4-im1.png'),[750, 700]);
image8 = imresize(imread('S4-im2.png'),[750, 700]);

image = rgb2gray(image);
image2 = rgb2gray(image2);
image3 = rgb2gray(image3);
image4 = rgb2gray(image4);
image5 = rgb2gray(image5);
image6 = rgb2gray(image6);
image7 = rgb2gray(image7);
image8 = rgb2gray(image8);

FT = 20;
HT = 0.0001;

keypoints = my_fast_detector(image, FT);
keypoints2 = my_fast_detector(image2, FT);
keypoints3 = my_fast_detector(image3, FT);
keypoints4 = my_fast_detector(image4, FT);

harriscorner = harriscomp(image);
harriscorner2 = harriscomp(image2);
harriscorner3 = harriscomp(image3);
harriscorner4 = harriscomp(image4);

harrisCorners = harriscorner > HT;
harrisCorners2 = harriscorner2 > HT;
harrisCorners3 = harriscorner3 > HT;
harrisCorners4 = harriscorner4 > HT;

FASTRKP = enhance_fastr(keypoints, harrisCorners);
FASTRKP2 = enhance_fastr(keypoints2, harrisCorners2);
FASTRKP3 = enhance_fastr(keypoints3, harrisCorners3);
FASTRKP4 = enhance_fastr(keypoints4, harrisCorners4);
%================================================================
keypoints = my_fast_detector(image, 30); 
keypoints2 = my_fast_detector(image2, 30); 

points1 = detectFASTFeatures(image, 'MinContrast', 0.1, 'MinQuality', 0.05); 
points2 = detectFASTFeatures(image2, 'MinContrast', 0.1, 'MinQuality', 0.05); 

[features1, valid_points1] = extractFeatures(image, points1);
[features2, valid_points2] = extractFeatures(image2, points2);

indexPairs = matchFeatures(features1, features2, 'Method', 'Approximate', 'MaxRatio', 0.7); 

matchedPoints1 = valid_points1(indexPairs(:, 1));
matchedPoints2 = valid_points2(indexPairs(:, 2));
%=======================================================================

keypoints3 = my_fast_detector(image3, 30); 
keypoints4 = my_fast_detector(image4, 30); 


points3 = detectFASTFeatures(image3, 'MinContrast', 0.1, 'MinQuality', 0.05); 
points4 = detectFASTFeatures(image4, 'MinContrast', 0.1, 'MinQuality', 0.05); 

[features3, valid_points3] = extractFeatures(image3, points3);
[features4, valid_points4] = extractFeatures(image4, points4);


indexPairs2 = matchFeatures(features3, features4, 'Method', 'Approximate', 'MaxRatio', 0.7); 

matchedPoints3 = valid_points3(indexPairs2(:, 1));
matchedPoints4 = valid_points4(indexPairs2(:, 2));
%=======================================================================
keypointsr = my_fast_detector(image, 30); 
keypoints2r = my_fast_detector(image2, 30); 

harriscornerr = harriscomp(image);
harriscorner2r = harriscomp(image2);

HT = 0.0001;
harrisCornersr = harriscornerr > HT;
harrisCorners2r = harriscorner2r > HT;

FASTRKPr = enhance_fastr(keypointsr, harrisCorners);
FASTRKP2r = enhance_fastr(keypoints2r, harrisCorners2);

points1r = detectFASTFeatures(image, 'MinContrast', 0.1, 'MinQuality', 0.05); 
points2r = detectFASTFeatures(image2, 'MinContrast', 0.1, 'MinQuality', 0.05); 

[features1r, valid_points1r] = extractFeatures(image, points1r);
[features2r, valid_points2r] = extractFeatures(image2, points2r);

indexPairsr = matchFeatures(features1r, features2r, 'Method', 'Approximate', 'MaxRatio', 0.7); 

matchedPoints1r = valid_points1(indexPairsr(:, 1));
matchedPoints2r = valid_points2(indexPairsr(:, 2));

%=======================================================================
keypoints3r = my_fast_detector(image3, 30); 
keypoints4r = my_fast_detector(image4, 30); 

harriscorner3r = harriscomp(image3);
harriscorner4r = harriscomp(image4);

HT = 0.0001;
harrisCorners3r = harriscorner3r > HT;
harrisCorners4r = harriscorner4r > HT;

FASTRKP3r = enhance_fastr(keypoints3r, harrisCorners3r);
FASTRKP4r = enhance_fastr(keypoints4r, harrisCorners4r);

points3r = detectFASTFeatures(image3, 'MinContrast', 0.1, 'MinQuality', 0.05); % Adjust parameters for more keypoints
points4r = detectFASTFeatures(image4, 'MinContrast', 0.1, 'MinQuality', 0.05); % Adjust parameters accordingly for the second image

[features3r, valid_points3r] = extractFeatures(image3, points3r);
[features4r, valid_points4r] = extractFeatures(image4, points4r);

indexPairs2r = matchFeatures(features3r, features4r, 'Method', 'Approximate', 'MaxRatio', 0.7); % Adjust parameters for more matches

matchedPoints3r = valid_points3r(indexPairs2r(:, 1));
matchedPoints4r = valid_points4r(indexPairs2r(:, 2));

%=======================================================================
keypoints1s = detectFASTFeatures(image1);
keypoints2s = detectFASTFeatures(image2);

[features1s, validPoints1s] = extractFeatures(image1, keypoints1s);
[features2s, validPoints2s] = extractFeatures(image2, keypoints2s);

indexPairss = matchFeatures(features1s, features2s);

matchedPoints1s = validPoints1s(indexPairss(:, 1));
matchedPoints2s = validPoints2s(indexPairss(:, 2));

[H1, inliersIdx1] = estimateGeometricTransform2D(matchedPoints2s, matchedPoints1s, 'projective', 'MaxNumTrials', 1000, 'Confidence', 99);

outputSizes = [size(image1, 1), size(image1, 2) + size(image2, 2)]; 
stitchedImgs = imwarp(image2, H1, 'OutputView', imref2d(outputSizes));

stitchedImgs(1:size(image1, 1), 1:size(image1, 2)) = image1;
%=======================================================================
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
%=======================================================================
keypoints5s = detectFASTFeatures(image5);
keypoints6s = detectFASTFeatures(image6);

[features5s, validPoints5s] = extractFeatures(image5, keypoints5s);
[features6s, validPoints6s] = extractFeatures(image6, keypoints6s);

indexPairs3s = matchFeatures(features5s, features6s);

matchedPoints5s = validPoints5s(indexPairs3s(:, 1));
matchedPoints6s = validPoints6s(indexPairs3s(:, 2));

[H3, inliersIdx3] = estimateGeometricTransform2D(matchedPoints6s, matchedPoints5s, 'projective', 'MaxNumTrials', 1000, 'Confidence', 99);

outputSizes3 = [size(image5, 1), size(image5, 2) + size(image6, 2)]; 
stitchedImgs3 = imwarp(image6, H3, 'OutputView', imref2d(outputSizes3));

stitchedImgs3(1:size(image5, 1), 1:size(image5, 2)) = image5;
%=======================================================================
keypoints7s = detectFASTFeatures(image7);
keypoints8s = detectFASTFeatures(image8);

[features7s, validPoints7s] = extractFeatures(image7, keypoints7s);
[features8s, validPoints8s] = extractFeatures(image8, keypoints8s);

indexPairs4s = matchFeatures(features7s, features8s);

matchedPoints7s = validPoints7s(indexPairs4s(:, 1));
matchedPoints8s = validPoints8s(indexPairs4s(:, 2));

[H4, inliersIdx4] = estimateGeometricTransform2D(matchedPoints8s, matchedPoints7s, 'projective', 'MaxNumTrials', 1000, 'Confidence', 99);

outputSizes4 = [size(image7, 1), size(image7, 2) + size(image8, 2)]; 
stitchedImgs4 = imwarp(image8, H4, 'OutputView', imref2d(outputSizes4));

stitchedImgs4(1:size(image7, 1), 1:size(image7, 2)) = image7;
%=======================================================================

figure, imshow(image); hold on;
plot(keypoints(:, 2), keypoints(:, 1), '.', 'MarkerSize', 1, 'Color', [0.8 0.8 0.8]);  
title('S1 FAST Feature Points');
saveas(gcf, 'S1-fast.png');

figure, imshow(image3); hold on;
plot(keypoints3(:, 2), keypoints3(:, 1), '.', 'MarkerSize', 1, 'Color', [0.8 0.8 0.8]);  
title('S2 FAST Feature Points');
saveas(gcf, 'S2-fast.png');


figure, imshow(image); hold on;
plot(FASTRKP(:, 2), FASTRKP(:, 1), '.', 'MarkerSize', 1, 'Color', [0.8 0.8 0.8]);  
title('FASTR Feature Points');
saveas(gcf, 'S1-fastR.png');

figure, imshow(image3); hold on;
plot(FASTRKP3(:, 2), FASTRKP3(:, 1), '.', 'MarkerSize', 1, 'Color', [0.8 0.8 0.8]);  
title('S2 FASTR Feature Points');
saveas(gcf, 'S2-fastR.png');

figure;
showMatchedFeatures(image, image2, matchedPoints1, matchedPoints2, 'montage');
title('Matched FAST Features Between S1 Images');
saveas(gcf, 'S1-fastMatch.png');

figure;
showMatchedFeatures(image3, image4, matchedPoints3, matchedPoints4, 'montage');
title('Matched FAST Features Between S2 Images');
saveas(gcf, 'S2-fastMatch.png');

figure;
showMatchedFeatures(image, image2, matchedPoints1r, matchedPoints2r, 'montage');
title('Matched FASTR Features Between S1 Images');
saveas(gcf, 'S1-fastRMatch.png');

figure;
showMatchedFeatures(image3, image4, matchedPoints3r, matchedPoints4r, 'montage');
title('Matched FASTR Features Between S2 Images');
saveas(gcf, 'S2-fastRMatch.png');

figure, 
imshow(stitchedImgr);
title('Stitched Image 1');
saveas(gcf, 'S1-panorama.png');

figure, 
imshow(stitchedImgs2);
title('Stitched Image 2');
saveas(gcf, 'S2-panorama.png');

figure, 
imshow(stitchedImgs3);
title('Stitched Image 3');
saveas(gcf, 'S3-panorama.png');

figure, 
imshow(stitchedImgs4);
title('Stitched Image 4');
saveas(gcf, 'S4-panorama.png');
%=======================================================================

function harriscorner = harriscomp(image)
    image = double(image);
    sobel = [-1 0 1; -2 0 2; -1 0 1];
    gaus = fspecial('gaussian', 5, 1);
    dog = conv2(gaus, sobel);
    ix = imfilter(image, dog);
    iy = imfilter(image, dog');
    ix2g = imfilter(ix .* ix, gaus);
    iy2g = imfilter(iy .* iy, gaus);
    ixiyg = imfilter(ix .* iy, gaus);
    harriscorner = ix2g .* iy2g - ixiyg .* ixiyg - 0.05 .* (ix2g + iy2g) .^2;
end


function FASTRKP = enhance_fastr(keypoints, harrisCorners)
    [rows, cols] = size(harrisCorners);
    idx = sub2ind([rows, cols], keypoints(:,1), keypoints(:,2));
    FASTRKP = keypoints(harrisCorners(idx), :);
end

function keypoints = my_fast_detector(image, threshold)
    if ~isa(image, 'double')
        image = double(image);
    end

    circel = [0 -3; 1 -3; 2 -2; 3 -1; 3 0; 3 1; 2 2; 1 3; 0 3; -1 3; -2 2; -3 1; -3 0; -3 -1; -2 -2; -1 -3];

    keypoints = [];

    for y = 4:size(image, 1)-3
        for x = 4:size(image, 2)-3
            midpx = image(y, x);
            darkpx = 0;
            lightpx = 0;

            for i = 1:length(circel)
                circlePixel = image(y + circel(i, 2), x + circel(i, 1));


                if midpx - circlePixel > threshold
                    darkpx = darkpx + 1;
                elseif circlePixel - midpx > threshold
                    lightpx = lightpx + 1;
                end


                if darkpx >= 12 || lightpx >= 12
                    keypoints = [keypoints; y, x];
                    break; 
                end
            end
        end
    end
end