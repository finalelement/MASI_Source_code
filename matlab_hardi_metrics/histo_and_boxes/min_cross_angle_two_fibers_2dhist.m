% Minimum Crossing angle reported between two fiber populations for only the two
% fiber case.

function [test_output] = min_cross_angle_two_fibers_2dhist(fa,peaks_file)
    
    fileID = fopen(peaks_file,'rb','ieee-be');
    A = fread(fileID,'double');
    fclose(fileID); 
    
    % Obtain size from the fa which will be used for dt and pas files
    frac_an = load_untouch_nii(fa);    
    
    AA = reshape(A,[30 96 96 50]);
    AAA = permute(AA,[2 3 4 1]); % test Pas peaks
    
    test_output = [];
    
    for x = 1:96
        for y = 1:96
            for z = 1:50
                % Validate voxels with exit code 
                if (AAA(x,y,z,1) == 0)
                    % Validating only two fiber voxels from the set
                    if (AAA(x,y,z,3) == 2)
                        frac_val = frac_an.img(x,y,z);
                        
                        %Defining vectors for the PAS set
                        i = [AAA(x,y,z,7) AAA(x,y,z,8) AAA(x,y,z,9)];
                        j = [AAA(x,y,z,15) AAA(x,y,z,16) AAA(x,y,z,17)];
                        magi = norm(i);
                        magj = norm(j);
                        cross_angle = atan2d(norm(cross(i,j)),dot(i,j));
                        if (cross_angle > 90)
                            cross_angle = 180 - cross_angle;
                        end
                    
                        % Appending to output matrix if angle is not zero.
                        if (cross_angle ~= 0)
                            row2 = [frac_val cross_angle];
                            test_output = [test_output;row2];
                        end
                    end
                end
            end
        end
    end
    
    
end