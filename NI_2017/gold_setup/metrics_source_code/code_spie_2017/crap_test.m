function crap_test(fa,peaks_gold,peaks_test)

    fileID = fopen(peaks_gold,'rb','ieee-be');
    A = fread(fileID,'double');
    fclose(fileID);
    
    fileID = fopen(peaks_test,'rb','ieee-be');
    B = fread(fileID,'double');
    fclose(fileID); 
    
    % Obtain size from the fa which will be used for pas files
    frac_an = load_untouch_nii(fa);
    dims = size(frac_an.img);
    
    % Reshaping and permuting both gold and test PAS in order
    AA = reshape(A,[30 dims(1) dims(2) dims(3)]);
    AAA = permute(AA,[2 3 4 1]); % gold Pas peaks
    
    BB = reshape(B,[30 dims(1) dims(2) dims(3)]);
    BBB = permute(BB,[2 3 4 1]); % test Pas peaks
    
    z = 39;
    new_image = zeros(dims(1),dims(2));
    for x = 1:dims(1)
        for y = 1:dims(2)
            va = frac_an.img(x,y,z);
            % Validate voxels with exit code of Gold peaks
            if (AAA(x,y,z,1) == 0)
                % Validating only two fiber voxels from gold set
                if (AAA(x,y,z,3) >= 3)
                    va = 2;
                    if(BBB(x,y,z,3) >= 3)
                        va = 4;
                    end
                end
            end
            new_image(x,y) = va;
        end
    end
    figure(1);
    I1 = new_image(:,:);
    %I2 = frac_an.img(:,:,z);
    imagesc(squeeze(I1));
    hold on;
    %imagesc(squeeze(I2));
   
    colorbar;
   
end