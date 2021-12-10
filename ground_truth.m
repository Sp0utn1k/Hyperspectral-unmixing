clc;clear;close all;


load PaviaU_gt.mat 
load Pavia_gt.mat

gap = size(pavia_gt,1)-size(pavia_gt,2);
gap_pos = 223;



mycolors = [255,255,255; 0 0 128; 0,100,0; 134,154,172;214,41,41;80,80,80;...
            100,0,0;0,0,0;50,205,50;128,128,0]/255;
colormap(mycolors);
contourf(flipud([pavia_gt(:,1:gap_pos),zeros(size(pavia_gt,1),gap),...
    pavia_gt(:,gap_pos+1:end)]))
colorbar('Ticks',1:9,...
         'TickLabels',{'Water','Trees','Asphalt','Bricks',...
         'Bitumen','Tiles','Shadows','Meadows','Bare soil'})
axis equal
axis off
saveas(gcf,"images/Pavia/ground_truth.png")


swap = [3,4,5,8,7,6,1,2,9];
data = paviaU_gt;
for i = 1:9
    data(paviaU_gt==swap(i)) = i;
end

names = {'Asphalt','Meadows','Gravel','Trees',...
         'Painted metal sheets','Bare soil','Bitumen','Self-blocking bricks',...
         'Shadows'};
     
     
figure
mycolors = [255,255,255;0 0 128; 0,100,0; 134,154,172;214,41,41;80,80,80;...
            100,0,0;0,0,0;50,205,50;128,128,0]/255;
% mycolors = mycolors(swap,:);
colormap(mycolors);
contourf(flipud(data))
colorbar('Ticks',1:9,...
         'TickLabels',names(swap))
axis equal
axis off
saveas(gcf,"images/PaviaU/ground_truth.png")
