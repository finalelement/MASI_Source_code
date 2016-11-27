clear all;
close all

baseDir = '/fs4/masi/nathv/HARDI_Metrics';
vals = {'b1000','b1500','b2000','b2500','b3000'};

WMmask = load_nii('/fs4/masi/nathv/HARDI_Metrics/WMmask.nii');

SZ = [78 93 75]; % CHEATING
b_vals = 1000;

for jVal=1:length(vals)
    curDir = [baseDir filesep vals{jVal} filesep 'Qball_sh8' filesep];
    reps = dir([curDir '*rep*']);
    
    for jRep=1:length(reps)
        repDir = [curDir reps(jRep).name];
        pasfile = dir([repDir filesep '*peaks.Bdouble'])
        fp = fopen([repDir filesep pasfile(1).name],'rb','ieee-be');
        data = fread(fp,'double');
        fclose(fp);
        voldat = permute(reshape(data,[length(data)/prod(SZ) SZ]),[2 3 4 1]);
        volOI(:,:,:,jRep) = voldat(:,:,:,3);
    end
    
    goldDir = dir([curDir '*gold*']);
    
    fp = fopen([curDir goldDir(1).name filesep 'gold_peaks.Bdouble'],'rb','ieee-be');
    data = fread(fp,'double');
    fclose(fp);
    volgold = permute(reshape(data,[length(data)/prod(SZ) SZ]),[2 3 4 1]);
    volOIgold(:,:,:) = volgold(:,:,:,3);
    
    
    mask2 = double(WMmask.img).*(volOIgold>0);
    
    
    agreed = mode(volOI,4);
    consensus = volOI==repmat(agreed,[1 1 1 size(volOI,4)]);
    correct = volOI==repmat(volOIgold,[1 1 1 size(volOI,4)]);
    
    consensusP = mean(consensus,4);
    correctP = mean(correct,4);
    
    stats(jVal,:) = [mean(consensusP(find(mask2(:)))) std(consensusP(find(mask2(:)))) mean(correctP(find(mask2(:)))) std(correctP(find(mask2(:))))]
    
   
    figure(jVal);
    imagesc([mean(consensus(:,:,40,:),4) mean(correct(:,:,40,:),4)])
    title(vals(jVal));
    axis equal
    caxis([0 1])
    colorbar
    drawnow;
    
    
    % My stupid code
    
    global_mask = load_untouch_nii('global_mask_mask.nii');
    mask_img = global_mask.img;
    what_i_need = correctP.*double(mask_img);
    figure(jVal + 5);
    imagesc(mean(what_i_need(:,:,40,:),4))
    mycolormap = jet(256);
    mycolormap(1,:) = [1 1 1];
    colormap(mycolormap)
    axis equal
    caxis([0 1])
    colorbar
    drawnow;
    title(b_vals);
    fig = gcf;
    fig.PaperPositionMode = 'auto';
    file_name = sprintf('b%d_fraction_agreement_gold_qball',b_vals);
    print(file_name,'-depsc2','-r0')
     
    b_vals = b_vals + 500;
    
    
    
end

% stats =
% 
%     0.6838    0.1826    0.5306    0.3146
%     0.6908    0.1834    0.5459    0.3118
%     0.6809    0.1781    0.5296    0.3068
%     0.6689    0.1727    0.5060    0.3049
%     0.6517    0.1680    0.4746    0.3012

