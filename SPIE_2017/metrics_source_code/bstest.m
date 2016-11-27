function bstest
    
    fa = '501_gold_fa.nii';
    peaks_gold = '501_gold_peaks.Bdouble';
    
    peaks_test = 'test_1_peaks.Bdouble';
    
    fileID = fopen(peaks_gold,'rb','ieee-be');
    A = fread(fileID,'double');
    fclose(fileID);
    
    
    fileID = fopen(peaks_test,'rb','ieee-be');
    B = fread(fileID,'double');
    fclose(fileID); 
    
    % Reshaping and permuting both gold and test PAS in order
    AA = reshape(A,[30 96 96 50]);
    AAA = permute(AA,[2 3 4 1]); % gold Pas peaks
    
    BB = reshape(B,[30 96 96 50]);
    BBB = permute(BB,[2 3 4 1]); % test Pas peaks
    
    frac_an = load_untouch_nii(fa);
    
    count = 1;
    flag = 0;
   
    for x = 1:96
        flag = 1;
        for y = 1:96
            flag = 1;
            for z = 1:50
                
                % Validate voxels with exit code of Gold peaks
                if (AAA(x,y,z,1) == 0)
                    % Validating two fiber voxels from gold set
                    if (AAA(x,y,z,3) == 3)
                        frac_val = frac_an.img(x,y,z);
                        if count == 20 && flag == 1
                            break;
                        end
                        figure(count);
                        hold on;
                        if (frac_val > 0.4 && frac_val < 0.5)
                            quiver3([x-AAA(x,y,z,7)/2 x-AAA(x,y,z,15)/2 x-AAA(x,y,z,23)/2], ...
                                    [y-AAA(x,y,z,8)/2 y-AAA(x,y,z,16)/2 y-AAA(x,y,z,24)/2], ...
                                    [z-AAA(x,y,z,9)/2 z-AAA(x,y,z,17)/2 z-AAA(x,y,z,25)/2], ...
                                    [AAA(x,y,z,7) AAA(x,y,z,15) AAA(x,y,z,23)], ...
                                    [AAA(x,y,z,8) AAA(x,y,z,16) AAA(x,y,z,24)], ...
                                    [AAA(x,y,z,9) AAA(x,y,z,17) AAA(x,y,z,25)], 'Autoscale', 'off')
                                
                             quiver3([x-BBB(x,y,z,7)/2 x-BBB(x,y,z,15)/2 x-BBB(x,y,z,23)/2], ...
                                     [y-BBB(x,y,z,8)/2 y-BBB(x,y,z,16)/2 y-BBB(x,y,z,24)/2], ...
                                     [z-BBB(x,y,z,9)/2 z-BBB(x,y,z,17)/2 z-BBB(x,y,z,25)/2], ...
                                     [BBB(x,y,z,7) BBB(x,y,z,15) BBB(x,y,z,23)], ...
                                     [BBB(x,y,z,8) BBB(x,y,z,16) BBB(x,y,z,24)], ...
                                     [BBB(x,y,z,9) BBB(x,y,z,17) BBB(x,y,z,25)], 'Autoscale', 'off')   
                            
                            count = count + 1;
                            
                            m = [AAA(x,y,z,7) AAA(x,y,z,8) AAA(x,y,z,9)];
                            n = [AAA(x,y,z,15) AAA(x,y,z,16) AAA(x,y,z,17)];
                            o = [AAA(x,y,z,23) AAA(x,y,z,24) AAA(x,y,z,25)];
                        
                            j = [BBB(x,y,z,7) BBB(x,y,z,8) BBB(x,y,z,9)];
                            k = [BBB(x,y,z,15) BBB(x,y,z,16) BBB(x,y,z,17)];
                            l = [BBB(x,y,z,23) BBB(x,y,z,24) BBB(x,y,z,25)];
                            
                            total_error = error_normal(m,n,o,j,k,l);
                            xlabel(total_error);
                        end
                    end
                end
            end
        end
    end


end