function four_meshes_peak_str_single_fiber_f1_pas_qball

    mask = 'WM_nuero_mask.nii';
    figure(1);
    hold on;
    
    set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
    
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1000/PAS16'))
    
    subplot(1,4,1)
    
    [out1] = plot_2dhist_single_fiber_f1_peak_strength_alldata_nuero(mask);
    %view([-40 90]);
    grid on
    ylabel('No. of Voxels');
    xlabel('Fractional Anisotropy');
    title('PAS-b1000');
    set(gca,'Ylim',[0 40000]);
    set(gca,'XTick',(0:0.1:1));
    set(gca,'YTick',(0:4000:40000));
    
    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1000/PAS16'))
    
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1000/Qball_sh8')) 
    
    subplot(1,4,2)
    
    [out2] = plot_2dhist_single_fiber_f1_peak_strength_alldata_nuero(mask);
    %view([-40 90]);
    grid on
    ylabel('No. of Voxels');
    xlabel('Fractional Anisotropy');
    title('Qball-b1000');
    set(gca,'Ylim',[0 40000]);
    set(gca,'XTick',(0:0.1:1));
    set(gca,'YTick',(0:4000:40000));
    
    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1000/Qball_sh8'))
    
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b3000/PAS16')) 
    
    subplot(1,4,3)
    
    [out3] = plot_2dhist_single_fiber_f1_peak_strength_alldata_nuero(mask);
    %view([-40 90]);
    grid on
    ylabel('No. of Voxels');
    xlabel('Fractional Anisotropy');
    title('PAS-b3000');
    set(gca,'Ylim',[0 40000]);
    set(gca,'XTick',(0:0.1:1));
    set(gca,'YTick',(0:4000:40000));
    
    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b3000/PAS16'))
    
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b3000/Qball_sh8')) 
    
    subplot(1,4,4)
    
    [out4] = plot_2dhist_single_fiber_f1_peak_strength_alldata_nuero(mask);
    %view([-40 90]);
    grid on
    ylabel('No. of Voxels');
    xlabel('Fractional Anisotropy');
    title('Qball-b3000');
    set(gca,'Ylim',[0 40000]);
    set(gca,'XTick',(0:0.1:1));
    set(gca,'YTick',(0:4000:40000));

    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b3000/Qball_sh8'))
    
    %colormap(jet); 
    
    %{
    subplot(5,1,1)
    v1 = get(gca,'Clim');

    subplot(5,1,2)
    v2 = get(gca,'Clim');
 
    subplot(5,1,3)
    v3 = get(gca,'Clim');
 
    subplot(5,1,4)
    v4 = get(gca,'Clim');
    
    v_total = [v1 v2 v3 v4];
    max_v = max(v_total);
        
    subplot(5,1,1)
    set(gca,'Clim',[0 max_v])
    
    subplot(5,1,2)
    set(gca,'Clim',[0 max_v])
    
    subplot(5,1,3)
    set(gca,'Clim',[0 max_v])
    
    subplot(5,1,4)
    set(gca,'Clim',[0 max_v])
    %}
    %h=colorbar('SouthOutside');
    %set(h, 'Position', [.1 .020 .8150 .05]);
    %colormap(parula); 
    fig = gcf;
    %title('PAS & Qball Single fiber Peak strength: 11 Samples');
    fig.PaperPositionMode = 'auto';
    file_name = sprintf('single_fiber_peak_strength');
    print(file_name,'-depsc2','-r0')
    
end
    