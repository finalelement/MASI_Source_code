% Trivial way of finding mean Signal present or SNR

ab = sum(sum(nii.img))./sum(sum(nii.img ~= 0));

b = sum(ab)/50;

c = sum(b)/129;
