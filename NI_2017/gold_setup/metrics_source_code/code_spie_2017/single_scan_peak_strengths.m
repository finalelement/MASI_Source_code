function [output_nf1,output_nf2,output_nf3] = single_scan_peak_strengths(fa,peaks_gold,peaks_file,number_of_fibers)
    
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
    
    output_nf1 = [];
    output_nf2 = [];
    output_nf3 = [];
    
    % Looping over all the elements and creating vectors
    for x = 1:dims(1)
        for y = 1:dims(2)
            for z = 1:dims(3)    % z is the slice number
                % Validate voxels with exit code of gold peaks
                if (AAA(x,y,z,1) == 0)
                    
                    % Calculating all the peak strengths for test set
                    sumf = BBB(x,y,z,10) + BBB(x,y,z,18) + BBB(x,y,z,26);
                    
                    nf1 = BBB(x,y,z,10)/sumf;
                    if ( isnan(nf1) )
                        nf1 = 0;
                    end
                    
                    nf2 = BBB(x,y,z,18)/sumf;
                    if ( isnan(nf2) )
                        nf2 = 0;
                    end
                    
                    nf3 = BBB(x,y,z,26)/sumf;
                    if ( isnan(nf3) )
                        nf3 = 0;
                    end
                    
                    % Validating one fiber voxels from gold set
                    if (number_of_fibers == 1)
                        if (AAA(x,y,z,10) ~= 0 && AAA(x,y,z,18) == 0 && AAA(x,y,z,26) == 0)
                            output_nf1 = [output_nf1;nf1];
                            output_nf2 = [output_nf2;nf2];
                            output_nf3 = [output_nf3;nf3];
                        end
                    end
                    
                    % Validating two fiber voxels from gold set
                    if (number_of_fibers == 2)
                        if (AAA(x,y,z,10) ~= 0 && AAA(x,y,z,18) ~= 0 && AAA(x,y,z,26) == 0)
                            output_nf1 = [output_nf1;nf1];
                            output_nf2 = [output_nf2;nf2];
                            output_nf3 = [output_nf3;nf3];
                        end
                    end
                    
                    % Validating three fiber voxels from gold set
                    if (number_of_fibers == 3)
                        
                        if (AAA(x,y,z,10) ~= 0 && AAA(x,y,z,18) ~= 0 && AAA(x,y,z,26) ~= 0)
                            output_nf1 = [output_nf1;nf1];
                            output_nf2 = [output_nf2;nf2];
                            output_nf3 = [output_nf3;nf3];
                        end
                    end
                    
                end
            end
        end
    end
end