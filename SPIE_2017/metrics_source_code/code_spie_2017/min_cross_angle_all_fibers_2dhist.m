% Minimum Crossing angle reported between two fiber populations for only the two
% fiber case.

function [test_output] = min_cross_angle_all_fibers_2dhist(fa,peaks_file)

    fileID = fopen(peaks_file,'rb','ieee-be');
    A = fread(fileID,'double');
    fclose(fileID);

    % Obtain size from the fa which will be used for dt and pas files
    frac_an = load_untouch_nii(fa);
    dims = size(frac_an.img);

    % Loading the WM mask
    wm_mask = load_untouch_nii('WMmask.nii');

    AA = reshape(A,[30 dims(1) dims(2) dims(3)]);
    AAA = permute(AA,[2 3 4 1]); % test Pas peaks

    test_output = [];
    anglevol = zeros([dims(1) dims(2) dims(3)]);
    for x = 1:dims(1)
        for y = 1:dims(2)
            for z = 1:dims(3)
                % Validate voxels with exit code
                if (AAA(x,y,z,1) == 0)
                    % Validate with WM mask
                    % if(frac_an.img(x,y,z) >= 0.2)
                    if (wm_mask.img(x,y,z) == 1)
                        % Validating only two fiber voxels from the set
                        if (AAA(x,y,z,3) >= 2)
                            frac_val = frac_an.img(x,y,z);

                            %Defining vectors for the PAS set
                            i = [AAA(x,y,z,7) AAA(x,y,z,8) AAA(x,y,z,9)];
                            j = [AAA(x,y,z,15) AAA(x,y,z,16) AAA(x,y,z,17)];
                            k = [AAA(x,y,z,23) AAA(x,y,z,24) AAA(x,y,z,25)];

                            min_cross_angle = minimum_crossing_angle_per_voxel(i,j,k);
                            anglevol(x,y,z) = min_cross_angle ;

                            row2 = [frac_val min_cross_angle];
                            test_output = [test_output;row2];


                        end
                    end
                end
            end
        end
    end

end

% keyboard