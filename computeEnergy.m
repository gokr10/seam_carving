function [energyMatrix] = computeEnergy(height, width, matrix)

energyMatrix = zeros(height, width);
for i = 1:height
    for j = 1:width
        
        energyMatrix(i, j) = matrix(i, j);
        if i ~= 1
            if j == 1
                if energyMatrix(i-1, j) < energyMatrix(i-1, j+1)
                    energyMatrix(i, j) = energyMatrix(i, j) + energyMatrix(i-1, j);
                else
                    energyMatrix(i, j) = energyMatrix(i, j) + energyMatrix(i-1, j+1);
                end
            elseif j == width
                if energyMatrix(i-1, j-1) < energyMatrix(i-1, j)
                    energyMatrix(i, j) = energyMatrix(i, j) + energyMatrix(i-1, j-1);
                else
                    energyMatrix(i, j) = energyMatrix(i, j) + energyMatrix(i-1, j);
                end
            else
                if energyMatrix(i-1, j-1) < energyMatrix(i-1, j)
                    if energyMatrix(i-1, j-1) < energyMatrix(i-1, j+1)
                        energyMatrix(i, j) = energyMatrix(i, j) + energyMatrix(i-1, j-1);
                    else
                        energyMatrix(i, j) = energyMatrix(i, j) + energyMatrix(i-1, j+1);
                    end
                else
                    if energyMatrix(i-1, j) < energyMatrix(i-1, j+1)
                        energyMatrix(i, j) = energyMatrix(i, j) + energyMatrix(i-1, j);
                    else
                        energyMatrix(i, j) = energyMatrix(i, j) + energyMatrix(i-1, j+1);
                    end
                end
            end
        end
    end
end
