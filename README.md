# FAST Interest Point Detector and Panorama Generation

This project implements the FAST interest point detector and uses it to generate image panoramas. The assignment involves detecting feature points, matching points between images, and stitching the images together to create a seamless panorama.

## Project Overview:
1. **Image Collection**: We work with a provided image pair and additional sets of photos taken for stitching.
2. **FAST Feature Detection**: Implemented from scratch, this method identifies key interest points in the images.
3. **Robust FAST with Harris Cornerness**: Eliminate weak points using the Harris cornerness metric, retaining stronger features for better panorama generation.
4. **Feature Description and Matching**: ORB, SURF, or FREAK descriptors are used to match features between image pairs.
5. **RANSAC and Homography**: Estimate homographies between images using RANSAC and stitch them to form panoramas.
6. **Four-Image Stitching**: Stitch panoramas from 4 images instead of 2 in selected sets.
   
## Submission:
- **Source Code**: All code is implemented in MATLAB. For non-MATLAB users, please refer to the instructions on how to run the code.
- **Report**: The result images and comments are saved in the provided HTML template.

I have not cheated in any way when doing this assignment. All work is my own.
