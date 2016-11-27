function mean_magnitude(peaks_file)
    
    fileID = fopen(peaks_file,'rb','ieee-be');
    A = fread(fileID,'double');
    fclose(fileID);
    
    % Reshaping and permuting both gold and test PAS in order
    AA = reshape(A,[30 96 96 50]);
    AAA = permute(AA,[2 3 4 1]); % gold Pas peaks
    total = [];
    for x = 1:96
        for y = 1:96
            for z = 1:50    % z is the slice number
                if (AAA(x,y,z,1) == 0)
                    if (AAA(x,y,z,3) == 1)
                        u = [AAA(x,y,z,7) AAA(x,y,z,8) AAA(x,y,z,9)];
                        magu = norm(u);
                        total = [total,magu];
                    end
                end
            end
        end
    end
    
    mean(total)
    
end