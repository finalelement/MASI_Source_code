% Takes all the magnitudes and angles of the peaks present into account.

function [output,mean_output] = peak_to_peak_error_method2strength_two_fiber(fa,peaks_gold,peaks_test,mask)
    
    fileID = fopen(peaks_gold,'rb','ieee-be');
    A = fread(fileID,'double');
    fclose(fileID);
    
    fileID = fopen(peaks_test,'rb','ieee-be');
    B = fread(fileID,'double');
    fclose(fileID); 
    
    % Loading the ROI file
    mask_mask = load_untouch_nii(mask);
    
    % Obtain size from the fa which will be used for pas files
    frac_an = load_untouch_nii(fa);
    dims = size(frac_an.img);
    
    % Reshaping and permuting both gold and test PAS in order
    AA = reshape(A,[30 dims(1) dims(2) dims(3)]);
    AAA = permute(AA,[2 3 4 1]); % gold Pas peaks
    
    BB = reshape(B,[30 dims(1) dims(2) dims(3)]);
    BBB = permute(BB,[2 3 4 1]); % test Pas peaks
    
    output = [];
    
    total_count = 0;
    one_count = 0;
    two_count = 0;
    three_count = 0;
    
    for x = 1:dims(1)
        for y = 1:dims(2)
            for z = 1:dims(3)
                % Validate voxels with exit code of Gold peaks
                if (AAA(x,y,z,1) == 0)
                    % Segmentation mask
                    if(mask_mask.img(x,y,z) == 1)
                        % Validating two fiber voxels from gold set
                        if (AAA(x,y,z,3) == 2)
                            frac_val = frac_an.img(x,y,z);
                            row = [0 0];
                            total_count = total_count + 1;
                            % Defining all single fiber vector from gold and all vectors for test in
                            % order
                            m = [AAA(x,y,z,7) AAA(x,y,z,8) AAA(x,y,z,9)];
                            n = [AAA(x,y,z,15) AAA(x,y,z,16) AAA(x,y,z,17)];
                            o = [AAA(x,y,z,23) AAA(x,y,z,24) AAA(x,y,z,25)];

                            j = [BBB(x,y,z,7) BBB(x,y,z,8) BBB(x,y,z,9)];
                            k = [BBB(x,y,z,15) BBB(x,y,z,16) BBB(x,y,z,17)];
                            l = [BBB(x,y,z,23) BBB(x,y,z,24) BBB(x,y,z,25)];

                            % Calculating normalized peak strengths of the gold
                            % set.
                            f1 = AAA(x,y,z,10);
                            f2 = AAA(x,y,z,18);
                            f3 = AAA(x,y,z,26);

                            sumf = f1 + f2 + f3;

                            normf1 = f1/sumf;
                            normf2 = f2/sumf;
                            normf3 = f3/sumf;

                            % Calculating normalized peak strengths of the test
                            % set
                            t1 = BBB(x,y,z,10);
                            t2 = BBB(x,y,z,18);
                            t3 = BBB(x,y,z,26);

                            sumt = t1 + t2 + t3;

                            normt1 = t1/sumt;
                            normt2 = t2/sumt;
                            normt3 = t3/sumt;
                            % disp([x,y,z])
                            error = error_method2strength_symmetric(m,n,o,j,k,l,normf1,normf2,normf3,normt1,normt2,normt3);

                            row = [frac_val sum(error)];            
                            output = [output;row];
                        end
                    end
                end
            end
        end
    end
    
    max_fa = max(max(max(frac_an.img)));
    mean_output = [];
    temp = 0;
    
    while (temp < max_fa)
        beg_limit = temp;
        end_limit = temp + 0.1;
        fa_val = (beg_limit + end_limit)/2;
        if(~isempty(output))
            col1 = output(:,1);
            col2 = output(:,2);

            index = find((beg_limit < col1) & (col1 < end_limit));
        else
            col1 = 0;
            col2 = 0;
            index = int16.empty;
        end
        if(~isempty(index))
            col3 = col2(index);
            mean_error = mean(col3(~isnan(col3)));

            row1 = [fa_val mean_error];
        else
            row1 = [fa_val 0];
        end
        
        mean_output = [mean_output;row1];
        temp = temp + 0.1;
    end
                        
end