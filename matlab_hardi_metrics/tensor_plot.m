figure(1)
clf

z = 16;
%back_slice = nii.img(:,:,z);
%back_slice = imrotate(back_slice,270);
%back_slice = fliplr(back_slice);
%imshow(back_slice,[]);
%set(gca,'YDir','normal');
hold on;
for x = 1:112
    tic
    for y = 1:112
        
        quiver3([x - AAA(x,y,z,2)/2], ...
                [y - AAA(x,y,z,3)/2], ...
                [z - AAA(x,y,z,4)/2], ...
                [AAA(x,y,z,2)], ...
                [AAA(x,y,z,3)], ...
                [AAA(x,y,z,4)],'Autoscale','off','color','red')
        hold on;
    end
    toc
end

view([0 90])
axis equal
drawnow