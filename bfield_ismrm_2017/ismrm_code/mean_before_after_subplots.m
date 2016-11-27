function accum = mean_before_after_subplots

    % Looping across b-values
    sp_count = 1;
    bval = 1000;
    accum = [];
    for j = 1:4
        
        [out1,out2,out3,out4] = roi_based_mean(j);
        subplot(2,4,sp_count)
        hold on;
        
        a1=errorbar(out1(1,:),out1(2,:),out1(3,:),'x');
        a2=errorbar(out2(1,:),out2(2,:),out2(3,:),'o');
        a3=errorbar(out3(1,:),out3(2,:),out3(3,:),'d');
        a4=errorbar(out4(1,:),out4(2,:),out4(3,:),'*');
    
        ylabel('FA')
        xlabel('Sites')
        grid on
        title_string = sprintf('Pre-correction:b-%d',bval);
        title(title_string)
        legend([a1 a2 a3 a4],'CC','IC','Notsure','Cen Semiov');
        
        sp_count = sp_count + 1;
        
        [out11,out22,out33,out44] = roi_based_mean_fa2(j);
       
        subplot(2,4,sp_count)
        hold on;
        
        errorbar(out11(1,:),out11(2,:),out11(3,:),'x');
        errorbar(out22(1,:),out22(2,:),out22(3,:),'o')
        errorbar(out33(1,:),out33(2,:),out33(3,:),'d')
        errorbar(out44(1,:),out44(2,:),out44(3,:),'*')
    
        ylabel('FA')
        xlabel('Sites')
        grid on
        title_string = sprintf('After-correction:b-%d',bval);
        title(title_string)
        legend([a1 a2 a3 a4],'CC','IC','Notsure','Cen Semiov');
        
        sp_count = sp_count + 1;
        bval = bval + 500;
        
        difference1 = abs(out1(2,:) - out11(2,:))
        difference2 = abs(out2(2,:) - out22(2,:))
        difference3 = abs(out3(2,:) - out33(2,:))
        difference4 = abs(out4(2,:) - out44(2,:))
        
        display('###############')
        accum = [accum;out1(2,:) out2(2,:) out3(2,:) out4(2,:);out11(2,:) out22(2,:) out33(2,:) out44(2,:)];
    end

end