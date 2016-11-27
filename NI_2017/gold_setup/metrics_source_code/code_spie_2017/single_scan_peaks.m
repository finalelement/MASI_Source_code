function output = single_scan_peaks(fa,peaks_gold,peaks_file,number_of_fibers)
    
    fileID = fopen(peaks_gold,'rb','ieee-be');
    A = fread(fileID,'double');
    fclose(fileID);
    
    fileID = fopen(peaks_file,'rb','ieee-be');
    B = fread(fileID,'double');
    fclose(fileID); 
    
    % Obtain size from the fa which will be used for pas files
    frac_an = load_untouch_nii(fa);
    dims = size(frac_an.img);
    
    % Reshaping and permuting both gold and test peaks of PAS in order
    AA = reshape(A,[30 dims(1) dims(2) dims(3)]);
    AAA = permute(AA,[2 3 4 1]);   % Gold Pas peaks
    
    BB = reshape(B,[30 dims(1) dims(2) dims(3)]);
    BBB = permute(BB,[2 3 4 1]); % Test Pas peaks
    
    output = [];
    
    % Looping over all the elements and creating vectors
    for x = 1:dims(1)
        for y = 1:dims(2)
            for z = 1:dims(3)    % z is the slice number
                % Validate voxels with exit code of gold peaks
                if (AAA(x,y,z,1) == 0)

                    if (number_of_fibers == 1)
                        if (AAA(x,y,z,10) ~= 0 && AAA(x,y,z,18) == 0 && AAA(x,y,z,26) == 0)
                            if(BBB(x,y,z,3) >= 3)
                                output = [output;3];
                            else
                                output = [output;BBB(x,y,z,3)];
                            end
                        end
                    end

                    if (number_of_fibers == 2)
                        if (AAA(x,y,z,10) ~= 0 && AAA(x,y,z,18) ~= 0 && AAA(x,y,z,26) == 0)
                            if(BBB(x,y,z,3) >= 3)
                                output = [output;3];
                            else
                                output = [output;BBB(x,y,z,3)];
                            end
                        end
                    end

                    if (number_of_fibers == 3)

                        if (AAA(x,y,z,10) ~= 0 && AAA(x,y,z,18) ~= 0 && AAA(x,y,z,26) ~= 0)
                            if(BBB(x,y,z,3) >= 3)
                                output = [output;3];
                            else
                                output = [output;BBB(x,y,z,3)];
                            end
                        end
                    end
                    
                end
            end
        end
    end
end