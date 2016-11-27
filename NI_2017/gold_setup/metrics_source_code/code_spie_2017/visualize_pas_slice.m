function visualize_pas_slice(fa,peaks_file,slice_number)
    
    % Loading up the FA file to get dimensions
    frac_an = load_untouch_nii(fa);
    dims = size(frac_an.img);
    
    fileID = fopen(peaks_file,'rb','ieee-be');
    A = fread(fileID,'double');
    fclose(fileID); 
    
        
    AA = reshape(A,[30 dims(1) dims(2) dims(3)]);
    AAA = permute(AA,[2 3 4 1]); % test Pas peaks
    
    z = slice_number;
    for x=1:dims(1)
        for y=1:dims(2)
            if(AAA(x,y,z,7)~=0)         
                quiver3([x-AAA(x,y,z,7)/2 x-AAA(x,y,z,15)/2], ...
                        [y-AAA(x,y,z,8)/2 y-AAA(x,y,z,16)/2], ...
                        [z-AAA(x,y,z,9)/2 z-AAA(x,y,z,17)/2], ...
                        [AAA(x,y,z,7) AAA(x,y,z,15)], ...
                        [AAA(x,y,z,8) AAA(x,y,z,16)], ...
                        [AAA(x,y,z,9) AAA(x,y,z,17)], 'Autoscale', 'off','Color','red')
                hold on;
    
            end
        end
    end

view([0 90])
axis equal 
drawnow


end