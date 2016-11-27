function[test_max_output,test_min_output] = min_reported_angle_f(fa,pas_test)

    
    fileID = fopen(pas_test,'rb','ieee-be');
    B = fread(fileID,'double');
    fclose(fileID); 
    
    % Obtain size from the fa which will be used for dt and pas files
    frac_an = load_untouch_nii(fa);    
    
    BB = reshape(B,[30 96 96 50]);
    BBB = permute(BB,[2 3 4 1]); % test Pas peaks
    
    test_output = [];
    
    for x = 1:96
        for y = 1:96
            for z = 1:50    % z is the slice number
                if frac_an.img(x,y,z) >= 0.1
                    frac_val = frac_an.img(x,y,z);
                    
                    %Defining vectors for test pas
                    i = [BBB(x,y,z,7) BBB(x,y,z,8) BBB(x,y,z,9)];
                    j = [BBB(x,y,z,15) BBB(x,y,z,16) BBB(x,y,z,17)];
                    cross_angle_test = atan2d(norm(cross(i,j)),dot(i,j));
                    if (cross_angle_test > 90)
                        cross_angle_test = 180 - cross_angle_test;
                    end
                    
                    % Appending to output matrix if angle is not zero.
                    if (cross_angle_test ~= 0)
                        row2 = [frac_val cross_angle_test];
                        test_output = [test_output;row2];
                    end
                end
            end
        end
    end
    
    temp = 0.0001;
    
    test_min_output = [];
    test_max_output = [];
    
    final_output = [];

    max_fa = max(max(max(frac_an.img)));
    while (temp < max_fa)
        beg_limit = temp;
        end_limit = temp + 0.1;
        fa_val = (beg_limit + end_limit)/2;
        
        %Test Calculations
        test_col1 = test_output(:,1);
        test_col2 = test_output(:,2);
        test_index = find((beg_limit < test_col1) & (test_col1 < end_limit));
        
        test_max1 = max(test_col2(test_index));
        test_min1 = min(test_col2(test_index));
        
        test_row1 = [fa_val test_max1];
        test_row2 = [fa_val test_min1];
        
        test_max_output = [test_max_output;test_row1];
        test_min_output = [test_min_output;test_row2];
                        
        temp = temp + 0.1;
    end
end