function [cropped] = findSeams(image, numSeams, origimage, horiz, eHogSet)

origimageCopy = origimage;

if horiz
    image = transpose(image);
    origimage = permute(origimage, [2,1,3]);
    origimageCopy = origimage;
    width = (size(image,2));
    height = (size(image,1));
else
    width = (size(image,2));
    height = (size(image,1));
end

dx=[-1, 0, 1];
dy=[-1; 0; 1];

cropped = origimage;

for m = 1:numSeams
    croppedGray = rgb2gray(cropped);
    gx2 = conv2(croppedGray, dx, 'same');
    gy2 = conv2(croppedGray, dy, 'same');
    newMat = abs(gx2)+abs(gy2);
    energyMatrix = computeEnergy(height, width, newMat);

    
    if eHogSet == true
        newMat2 = eHogMatrix(energyMatrix, newMat, height, width);
        energyMatrix = computeEnergy(height, width, newMat2);
    end
    
    
    [mat,indexJMat] = min(energyMatrix, [], 2);
    
    indexJ = indexJMat(height);
    image(height, indexJ, 1) = 1;
    image(height, indexJ, 2) = 0;
    image(height, indexJ, 3) = 0;
    seam = [height; indexJ];
    
    for k = indexJ:width-1
        cropped(height, k, :) = cropped(height, k+1, :);
        energyMatrix(height, k) = energyMatrix(height, k+1);
    end
    
    for sub = 0:(height-2)
        i = height-sub;
        if indexJ == 1
            if energyMatrix(i-1, indexJ) < energyMatrix(i-1, indexJ+1)
                newIndex = [i-1, indexJ];
            else
                newIndex = [i-1, indexJ+1];
            end
            
        elseif indexJ == width
            if energyMatrix(i-1, indexJ-1) < energyMatrix(i-1, indexJ)
                newIndex = [i-1, indexJ-1];
            else
                newIndex = [i-1, indexJ];
            end
        else
            if energyMatrix(i-1, indexJ-1) < energyMatrix(i-1, indexJ)
                if energyMatrix(i-1, indexJ-1) < energyMatrix(i-1, indexJ+1)
                    newIndex = [i-1, indexJ-1];
                else
                    newIndex = [i-1, indexJ+1];
                end
            else
                if energyMatrix(i-1, indexJ) < energyMatrix(i-1, indexJ+1)
                    newIndex = [i-1, indexJ];
                else
                    newIndex = [i-1, indexJ+1];
                end
            end
            
        end
        
        for k = newIndex(2):width-1
            energyMatrix(newIndex(1), k) = energyMatrix(newIndex(1), k+1);
            cropped(newIndex(1), k, :) = cropped(newIndex(1), k+1, :);
        end
        
        newPix = [newIndex(1); newIndex(2)];
        indexJ = newIndex(2);
        seam = [seam newPix];
        origimageCopy(newIndex(1), newIndex(2), 1) = 1;
        origimageCopy(newIndex(1), newIndex(2), 2) = 0;
        origimageCopy(newIndex(1), newIndex(2), 3) = 0;
        
    end
    
    cropped = cropped(:,1:width-1,:);
    %energyMatrix = energyMatrix(:,1:width-1);
    width = width-1;
end

if horiz
    origimageCopy = permute(origimageCopy, [2,1,3]);
    cropped = permute(cropped, [2,1,3]);
end

figure(4);
imshow(origimageCopy);
figure(5);
imshow(cropped);
