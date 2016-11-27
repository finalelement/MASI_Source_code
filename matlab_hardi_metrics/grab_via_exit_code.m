% Only grab the data where clean exit code exists for the peak matrices
function ZZZ = grab_via_exit_code(ZZZ)
    k = size(ZZZ)
    % Grabbing the image data by the exit code
    
    % k(1) is X, k(2) is Y, k(3) is Z
    for row = 1:k(1)
        for col = 1:k(2)
            for slice = 1:k(3)
                if(ZZZ(row,col,slice,1) ~= 0)
                    ZZZ(row,col,slice,2:30) = 0;
                end
            end
        end
    end
    
end