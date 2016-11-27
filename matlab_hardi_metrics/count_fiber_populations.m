% Count the number of voxels with one fiber, two fiber and three fibers and
% output the percentage over total number of voxels

function count_fiber_populations(gold_peaks)
    
    fileID = fopen(gold_peaks,'rb','ieee-be');
    A = fread(fileID,'double');
    fclose(fileID);
    
    AA = reshape(A,[30 96 96 50]);
    AAA = permute(AA,[2 3 4 1]); % Pas peaks
    
    one_fibers = 0;
    two_fibers = 0;
    three_fibers = 0;
    total_count = 0;
    
    for x = 1:96
        for y = 1:96
            for z = 1:50
                
                % Entering valid voxels only if the exit code is good
                if (AAA(x,y,z,1) == 0)
                   %increment total count of voxels
                   total_count = total_count + 1;
                   
                   if (AAA(x,y,z,3) == 1)
                       one_fibers = one_fibers + 1;
                   end
                   
                   if (AAA(x,y,z,3) == 2)
                       two_fibers = two_fibers + 1;
                   end
                   
                   if (AAA(x,y,z,3) == 3)
                       three_fibers = three_fibers + 1;
                   end
                   
                end
            end
        end
    end
    
    % Percentage of the fiber populations over the total count of voxels
    one_f_percent = one_fibers/total_count * 100;
    two_f_percent = two_fibers/total_count * 100;
    three_f_percent = three_fibers/total_count * 100;
end