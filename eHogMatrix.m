function [new] = eHogMatrix (mat, new9, height, width)

new=new9;
for i = 1:height
    for j = 1:width
        if i == 1 && j == 1
            maxE = [new9(i, j+1), new9(i+1, j), new9(i+1, j+1)];
        elseif i == 1 && j == width
            maxE = [new9(i, j-1), new9(i+1, j-1), new9(i+1, j)];
        elseif i == height && j == 1
            maxE = [new9(i-1, j), new9(i-1, j+1), new9(i, j+1)];
        elseif i == height && j == width
            maxE = [new9(i-1, j-1), new9(i-1, j), new9(i, j-1)];
        elseif i == 1
            maxE = [new9(i, j-1), new9(i, j+1), new9(i+1, j-1), new9(i+1, j), new9(i+1, j+1)];
        elseif j == 1
            maxE = [new9(i-1, j), new9(i+1, j), new9(i-1, j+1), new9(i, j+1), new9(i+1, j+1)];
        elseif i == height
            maxE = [new9(i, j-1), new9(i, j+1), new9(i-1, j-1), new9(i-1, j), new9(i-1, j+1)];
        elseif j == width
            maxE = [new9(i-1, j), new9(i+1, j), new9(i-1, j-1), new9(i, j-1), new9(i+1, j-1)];
        else
            maxE = [new9(i-1, j-1), new9(i-1, j), new9(i-1, j+1), new9(i, j-1), new9(i+1, j-1), new9(i+1, j), new9(i+1, j+1), new9(i, j+1)];
        end
        eHog = max(maxE);
        new(i,j)=new(i,j)/eHog;
    end
end

