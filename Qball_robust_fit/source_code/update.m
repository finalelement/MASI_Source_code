function sig_adjusted = update(dwmri_4d,basis,lambda,L,mask,return_flag,counter)
    
    sh_dwi_reg = zeros(size(dwmri_4d));
    threshold = 3;
    display(counter)
    counter = counter + 1;
    for i = 1:size(dwmri_4d,1)
        for j = 1:size(dwmri_4d,2)
            for k = 1:size(dwmri_4d,3)
                if mask(i,j,k)
                    % Reconstruct signal with spherical harmonic coefficients using regularized fit                   
                    C = (basis'*basis + lambda*L)\basis'*squeeze(dwmri_4d(i,j,k,:));                  
                    
                    % Reconstruct signal
                    sh_signal = basis*C;
                    
                    % Store it
                    sh_dwi_reg(i,j,k,:) = sh_signal;
                end
            end
        end
    end
    
    return_flag = 1;
    
    % Calculate residuals
    residuals = dwmri_4d - sh_dwi_reg;
    
    % Take regular standard deviation or median absolute deviation
    %maddy = std(residuals,0,4);
    maddy = mad(residuals,0,4);
    
    sig_adjusted = zeros(size(dwmri_4d));
    for i = 1:size(dwmri_4d,1)
        for j = 1:size(dwmri_4d,2)
            for k = 1:size(dwmri_4d,3)
                if mask(i,j,k)
                    for ng = 1:size(dwmri_4d,4)
                        if (residuals(i,j,k,ng) > threshold*maddy(i,j,k))
                            sig_adjusted(i,j,k,ng) = threshold*maddy(i,j,k);
                            return_flag = 0;
                        end
                    end
                end
            end
        end
    end
    
    if (return_flag == 0)
        sig_adjusted = update(sig_adjusted,basis,lambda,L,mask,return_flag,counter);
    end
end