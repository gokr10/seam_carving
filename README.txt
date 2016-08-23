README

Project description:
kgoedicke.com/Seam-Carving-1

main.m
Performs seam carving on the image that can be changed on line 4.  The number of seams can be adjusted at line 13.  horizSeams at line 17 is set to true if the seams are desired to be made horizontally across an image.  eHogFunc at line 13 can be set to true to use the Histogram of Gradients energy function.
Upon completion, opens three figures — figure 1 is the original image, figure 2 shows the seams that were picked to remove, figure 3 is the cropped image.

findSeams.m
Calls computeEnergy to get the energy of each pixel.  Backtracks through the stored energies to find the seams.

computeEnergy.m
Finds the pixels energy and stores it in the energyMatrix.  Adds the lowest energy from the 3 pixels above it (diagonal left, center, diagonal right).

eHogMatrix.m
Uses a 9x9 window around a pixel and finds the max energy out of those 8 surrounding pixels.