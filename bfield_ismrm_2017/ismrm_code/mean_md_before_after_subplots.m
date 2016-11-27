function mean_md_before_after_subplots

    % Looping across b-values
    sp_count = 1;
    bval = 1000;
    for j = 1:4
        
        [out1,out2,out3,out4] = roi_based_md_mean(j);
        subplot(2,4,sp_count)
        hold on;
        
        a1=errorbar(out1(1,:),out1(2,:),out1(3,:),'x');
        a2=errorbar(out2(1,:),out2(2,:),out2(3,:),'o');
        a3=errorbar(out3(1,:),out3(2,:),out3(3,:),'d');
        a4=errorbar(out4(1,:),out4(2,:),out4(3,:),'*');
    
        ylabel('MD')
        xlabel('Sites')
        grid on
        title_string = sprintf('Pre-correction:b-%d',bval);
        title(title_string)
        legend([a1 a2 a3 a4],'CC','IC','Notsure','Cen Semiov');
        
        sp_count = sp_count + 1;
        
        [out1,out2,out3,out4] = roi_based_mean_md2(j);
       
        subplot(2,4,sp_count)
        hold on;
        
        errorbar(out1(1,:),out1(2,:),out1(3,:),'x');
        errorbar(out2(1,:),out2(2,:),out2(3,:),'o')
        errorbar(out3(1,:),out3(2,:),out3(3,:),'d')
        errorbar(out4(1,:),out4(2,:),out4(3,:),'*')
    
        ylabel('MD')
        xlabel('Sites')
        grid on
        title_string = sprintf('After-correction:b-%d',bval);
        title(title_string)
        legend([a1 a2 a3 a4],'CC','IC','Notsure','Cen Semiov');
        
        sp_count = sp_count + 1;
        bval = bval + 500;
    end

end