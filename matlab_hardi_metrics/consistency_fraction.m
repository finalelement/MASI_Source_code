% First Attempt on recreating Consistency Fraction for HARDI
% This function will take two .Bdouble files as input which is the output
% file from camino for the function of 'sfpeaks'
% Consistency Fraction works on two conditions:
% - The number of directions in a single voxel should match.
% - If the above is true then the angular tolerance should not be more than
% cos(-1) (0.95) which translates to 18 degrees.
% Lets see how this works out.

function consistency_fraction(peak_reference,peak_test)
    %Load the both the peak files, AAA is the reference and BBB is the one
    %being tested.
    fileID = fopen(peak_reference,'rb','ieee-be');
    A = fread(fileID,'double');
    AA = reshape(A,[30 96 96 50]);
    AAA = permute(AA,[2 3 4 1]);
    
    fclose(fileID)
    
    fileI = fopen(peak_test,'rb','ieee-be');
    B = fread(fileI,'double');
    BB = reshape(B,[30 96 96 50]);
    BBB = permute(BB,[2 3 4 1]);
    
    fclose(fileI)
    
    peak_r = grab_via_exit_code(AAA);
    peak_t = grab_via_exit_code(BBB);
    
    %Total number of voxels present with clean data.
    k = size(AAA)
    total_voxels = k(1) * k(2) * k(3);
    
    %CF only for the first two directions
    success_count = 0;
    
    for row = 1:k(1)
        for col = 1:k(2)
            for slice = 1:k(3)
                if(AAA(row,col,slice,3) == BBB(row,col,slice,3))
                    
                    % Vectors for the reference peaks
                    u = [AAA(row,col,slice,7) AAA(row,col,slice,8) AAA(row,col,slice,9)];
                    v = [AAA(row,col,slice,15) AAA(row,col,slice,16) AAA(row,col,slice,17)];
                    % Angle between the vectors for ref_peaks
                    ref_angle = atan2d(norm(cross(u,v)),dot(u,v));
                    
                    % Vectors for the test peaks
                    w = [BBB(row,col,slice,7) BBB(row,col,slice,8) BBB(row,col,slice,9)];
                    x = [BBB(row,col,slice,15) BBB(row,col,slice,16) BBB(row,col,slice,17)];
                    % Angle between the vectors for the test_peaks
                    test_angle = atan2d(norm(cross(w,x)),dot(w,x));
                    
                    %Difference of angles
                    diff_angle = ref_angle - test_angle;
                    
                    if( -18.00 < diff_angle < 18.00)
                        success_count = success_count + 1;
                    end
                end
            end
        end
    end
    
    Consistency_frac = success_count/total_voxels;
    Consistency_frac;
    
    
end