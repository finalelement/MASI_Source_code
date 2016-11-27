% Minimum Crossing angle reported between two fiber populations for only the two
% fiber case from diffusion tensor

function [test_output] = dt_cross_angle_two_fibers_2dhist(fa,dt_file)
    
    fileID = fopen(dt_file,'rb','ieee-be');
    A = fread(fileID,'double');
    fclose(fileID); 
    
    % Obtain size from the fa which will be used for dt and pas files
    frac_an = load_untouch_nii(fa);    
    
    AA = reshape(A,[12 96 96 50]);
    AAA = permute(AA,[2 3 4 1]); % Diffusion Tensor Eigen System
    
    test_output = [];
    
    for x = 1:96
        for y = 1:96
            for z = 1:50
               
                frac_val = frac_an.img(x,y,z);
                        
                %Defining vectors for the PAS set
                i = [AAA(x,y,z,2) AAA(x,y,z,3) AAA(x,y,z,4)];
                j = [AAA(x,y,z,6) AAA(x,y,z,7) AAA(x,y,z,8)];
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
    hist3(test_output,[20 20]);
    hold on;
    
    title('Two Fiber Case:Angle of Separation Diffussion Tensor');
 
    xlabel('Fractional Anisotropy','fontweight','demi','fontsize',12);
    ylabel('Angle of Separation','fontweight','demi','fontsize',12);
    zlabel('Number of Voxels','fontweight','demi','fontsize',12);
end