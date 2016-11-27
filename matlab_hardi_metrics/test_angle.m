function test_angle(peaks_path)
    fileID = fopen(peaks_path,'rb','ieee-be');
    Z = fread(fileID,'double');
    ZZ = reshape(Z,[86 96 96 50]);
    ZZZ = permute(ZZ,[2 3 4 1]);
    
    l = size(ZZZ);
    
    for row = 1:l(1)
        
        for col = 1:l(2)
            
            for slice = 1:l(3)
                
                u = [ZZZ(row,col,slice,7) ZZZ(row,col,slice,8) ZZZ(row,col,slice,9)];
                v = [ZZZ(row,col,slice,15) ZZZ(row,col,slice,16) ZZZ(row,col,slice,17)];
                
                ref_angle = atan2d(norm(cross(u,v)),dot(u,v));
                ref_angle
            
            end
        end
    end
end