clear all;
close all


baseDir = '/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code';
vals = {'b1000','b1500','b2000','b2500','b3000'};

WMmask = load_nii('/fs4/masi/nathv/HARDI_Metrics/WMmask.nii');

SZ = [78 93 75]; % CHEATING

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
    
    stats(jVal,:) = [nanmean(consensusP(find(mask2(:)))) nanstd(consensusP(find(mask2(:)))) nanmean(correctP(find(mask2(:)))) nanstd(correctP(find(mask2(:))))]
    
    figure(jVal);
    imagesc([nanmean(consensus(:,:,40,:),4) nanmean(correct(:,:,40,:),4)])
    title(vals(jVal));
    axis equal
    caxis([0 1])
    colorbar
    drawnow;
end

%
%
%
% endstats =
%
%     0.1278    0.0599    0.2108    0.1201
%     0.1244    0.0598    0.2022    0.1183
%     0.1255    0.0561    0.2049    0.1141
%     0.1249    0.0524    0.2081    0.1117
%     0.1257    0.0493    0.2146    0.1096