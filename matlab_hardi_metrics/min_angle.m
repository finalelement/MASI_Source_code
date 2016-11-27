% Find out the minimum resolvable angle within a single scan from a
% session.
% Input is the peaks file with the Bdouble format from camino.
% Grab the data with exit code to omit voxels where no data is present.
% It starts with determining the number of directions present in the peaks
% file per voxel.
% Then different combination sets of the directions are created per voxel
% and the minimum angle is picked. This is done for each voxel and after
% computation on all the voxels a final minimum angle is picked from it.

function min_angle(peaks_path)
    fileID = fopen(peaks_path,'rb','ieee-be');
    Z = fread(fileID,'double');
    fclose(fileID);
    % determine the number of directions present in Z
    k = int32(size(Z,1));
    j = int32(k / (96 * 96 * 50));
    number_of_peaks = (j - 6)/ 8;
    ZZ = reshape(Z,[j 96 96 50]);
    ZZZ = permute(ZZ,[2 3 4 1]);
    
    % Creating a vector for the number of directions
    x = int16([1:number_of_peaks]);
    
    % Creating the number of possible combinations of all unique directions
    
    C = nchoosek(x,2);
    
    %Cleaning data by grabbing via exit code
    peak = grab_via_exit_code(ZZZ);
    
    l = size(peak);
    temp = 180; % Maximum value for angle set here
    
    for row = 1:l(1)
        tic
        for col = 1:l(2)
            
            for slice = 1:l(3)
                % Reaching a single voxel after three iters
                for i = 1:size(C,1)
                    % Going through combinations of all the unique directions    
                    dir1 = C(i,1);
                    dir2 = C(i,2);
                
                    % Relation formula calculated between the X,Y,Z coordinates
                    % of a specific direction
                    m = (6 + ( 8 * (dir1-1)));
                    n = (6 + ( 8 * (dir2-1)));
                
                    % Creating two vectors out of the selected directions
                    %u = [peak(row,col,slice,(m + 1)) peak(row,col,slice,(m + 2)) peak(row,col,slice,(m + 3))];
                    %v = [peak(row,col,slice,(n + 1)) peak(row,col,slice,(n + 2)) peak(row,col,slice,(n + 3))];
                    
                    u = [ZZZ(row,col,slice,(m + 1)) ZZZ(row,col,slice,(m + 2)) ZZZ(row,col,slice,(m + 3))];
                    v = [ZZZ(row,col,slice,(n + 1)) ZZZ(row,col,slice,(n + 2)) ZZZ(row,col,slice,(n + 3))];
                    
                    %u = [ZZZ(row,col,slice,7) ZZZ(row,col,slice,8) ZZZ(row,col,slice,9)];
                    %v = [ZZZ(row,col,slice,15) ZZZ(row,col,slice,16) ZZZ(row,col,slice,17)];
                
                    % Calculating angle between the two vectors
                    ref_angle = atan2d(norm(cross(u,v)),dot(u,v));
                    % ref_angle
                    
                    if ((ref_angle < temp) && (ref_angle ~= 0.00))
                        temp = ref_angle;
                    end
                
                
                   
                end
            end
            
        end
        temp
        toc
    end
    temp
    ref_angle
    
end