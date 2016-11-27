clear all;
close all


baseDir = '/fs4/masi/nathv/HARDI_Metrics';
vals = {'b1000','b1500','b2000','b2500','b3000'};

WMmask = load_nii('/fs4/masi/nathv/HARDI_Metrics/WMmask.nii');

SZ = [78 93 75]; % CHEATING

for jVal=1:length(vals)
    curDir = [baseDir filesep vals{jVal} filesep 'PAS16' filesep];
    reps = dir([curDir '*rep*']);
    
    for jRep=1:length(reps)
        repDir = [curDir reps(jRep).name];
        pasfile = dir([repDir filesep '*peaks.Bdouble'])
        fp = fopen([repDir filesep pasfile(1).name],'rb','ieee-be');
        data = fread(fp,'double');
        fclose(fp);
        voldat = permute(reshape(data,[length(data)/prod(SZ) SZ]),[2 3 4 1]);
        volOI(:,:,:,:,jRep) = voldat(:,:,:,[10 18 26]);
    end
    
    goldDir = dir([curDir '*gold*']);
    
    fp = fopen([curDir goldDir(1).name filesep 'gold_peaks.Bdouble'],'rb','ieee-be');
    data = fread(fp,'double');
    fclose(fp);
    volgold = permute(reshape(data,[length(data)/prod(SZ) SZ]),[2 3 4 1]);
    volOIgold(:,:,:,:) = volgold(:,:,:,[10 18 26]);
    
    
    mask2 = double(WMmask.img).*(volOIgold(:,:,:,1)>0);
        
    % Norm pks
    volOIgoldnorm = volOIgold./repmat(sum(volOIgold,4),[1 1 1 3]);
    volOInorm=volOI./repmat(sum(volOI,4),[1 1 1 3 1]);
    
    volOIgoldnorm(isnan(volOIgoldnorm(:)))=0;
    volOInorm(isnan(volOIgoldnorm(:)))=0;

    agreed = mean(volOInorm,5);
    consensusRaw = sqrt(mean((volOInorm-repmat(agreed,[1 1 1 1 size(volOInorm,5)])).^2,5));
    consensus = mean(sqrt(mean((volOInorm-repmat(agreed,[1 1 1 1 size(volOInorm,5)])).^2,5)),4);
    
    correctRaw = sqrt(mean((volOInorm-repmat(volOIgoldnorm,[1 1 1 1 size(volOInorm,5)])).^2,5));
    correct = mean(sqrt(mean((volOInorm-repmat(volOIgoldnorm,[1 1 1 1 size(volOInorm,5)])).^2,5)),4);
    
    
    consensusP = mean(consensus,4);
    correctP = mean(correct,4);
    
    stats(jVal,:) = [meannan(consensusP(find(mask2(:)))) stdnan(consensusP(find(mask2(:)))) meannan(correctP(find(mask2(:)))) stdnan(correctP(find(mask2(:))))]
    
    figure(jVal);
    imagesc([meannan(consensus(:,:,40,:),4) meannan(correct(:,:,40,:),4)])
    title(vals(jVal));
    axis equal
    caxis([0 1])
    colorbar
    drawnow;
    
    
    
    
    
end
% 
% stats =
% 
%     0.0753    0.0315    0.1026    0.0485
%     0.0702    0.0308    0.0941    0.0458
%     0.0680    0.0301    0.0901    0.0448
%     0.0658    0.0298    0.0860    0.0436
%     0.0678    0.0303    0.0869    0.0433