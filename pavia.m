clc;clear;close all;

load Pavia_gt.mat;
load Pavia.mat;

data = pavia;
gt = pavia_gt;
clear paviaU paviaU_gt

gap = size(gt,1)-size(gt,2);
gap_pos = 223;

m = size(data,3);
n = max(gt,[],'all');

M = zeros(m,n);
freq = zeros(1,n);
R = zeros(m);
for i = 1:size(data,1)
    for j = 1:size(data,2)
        k = gt(i,j);
        if k>0
            M(:,k) = M(:,k) + reshape(data(i,j,:),[],1);
            freq(k) = freq(k) + 1;
            
            r = reshape(data(i,j,:),[],1);
            R = R + r*r';
        end
    end
end
M = M ./ freq;
R = R./(i*j);

%%
for k = 1:n
    alphas = zeros(size(gt));
    d = M(:,k);
    w = R\d/(d'/R*d);

    X = [];
    Y = [];
    
    error = 0;

    for i = 1:size(alphas,1)
        for j = 1:size(alphas,2)
            r = reshape(data(i,j,:),[],1);
            alphas(i,j) = max(0,min(1,w'*r));
            if gt(i,j) == k
                if (j>gap_pos)
                    X = [X,j+gap];
                else
                    X = [X,j];
                end
                Y = [Y,size(gt,1)-i];
                error = error + 1 - alphas(i,j);
            end
        end
    end
%     alphas = max(0,min(1,alphas));
    
    error = error / length(X);
    disp("error = " + string(error))

    figure
    alphas = [alphas(:,1:gap_pos),zeros(size(alphas,1),gap),alphas(:,gap_pos+1:end)];
    image(alphas,'CDataMapping','scaled')
    colorbar
    axis equal
    axis([0 size(alphas,2) 0 size(alphas,1)])
    axis off
    pause(1e-2)
    saveas(gcf,'images/Pavia/k='+string(k)+'_unknown_U.png')
    
    figure
    hold on
    image(flipud(alphas),'CDataMapping','scaled')
    plot(X,Y,'r.')
    axis equal
    axis([0 size(alphas,2) 0 size(alphas,1)])
    axis off
    pause(1e-2)
    saveas(gcf,'images/Pavia/k='+string(k)+'_unknown_U(red).png')

%     alphas = zeros(size(gt,1),size(gt,2),n);

%     Minv = (M'*M)\M';
%     threshold = .3;

%     for i = 1:size(alphas,1)
%         for j = 1:size(alphas,2)
%             r = reshape(data(i,j,:),[],1);
%             A = Minv*r;

%             A = max(0,min(1,A));
%     %         A = A/sum(A);
%             idx = A > threshold;
%     %         [~ ,idx] = max(A);

%     %         A = zeros(size(A));
%     %         A(idx) = 1;

%             alphas(i,j,:) = A;
%         end
%     end

%     figure
%     alphas = alphas(:,:,k);
%     alphas = [alphas(:,1:gap_pos),zeros(size(alphas,1),gap),alphas(:,gap_pos+1:end)];
%     image(alphas,'CDataMapping','scaled')
%     colorbar
%     axis equal
%     axis([0 size(alphas,2) 0 size(alphas,1)])
%     axis off
%     pause(1e-2)
%     saveas(gcf,'images/Pavia/k='+string(k)+'_pseudo_inverse.png')

%     figure
%     hold on
%     image(flipud(alphas),'CDataMapping','scaled')
%     plot(X,Y,'r.')
%     axis equal
%     axis([0 size(alphas,2) 0 size(alphas,1)])
%     axis off
%     pause(1e-2)
%     saveas(gcf,'images/Pavia/k='+string(k)+'_pseudo_inverse(red).png')


%     alphas = zeros(size(gt));
%     d = M(:,k);
%     U = M;
%     U(:,k) = [];

%     Pu = ones(m) - U/(U'*U)*U';

%     for i = 1:size(alphas,1)
%         for j = 1:size(alphas,2)
%             r = reshape(data(i,j,:),[],1);
%             A = d'*Pu*r/(d'*Pu*d);
%             alphas(i,j) = max(0,min(1,A));
%         end
%     end

%     figure
%     alphas = [alphas(:,1:gap_pos),zeros(size(alphas,1),gap),alphas(:,gap_pos+1:end)];
%     image(alphas,'CDataMapping','scaled')
%     colorbar
%     axis equal
%     axis([0 size(alphas,2) 0 size(alphas,1)])
%     axis off
%     pause(1e-2)
%     saveas(gcf,'images/Pavia/k='+string(k)+'_optimum_detection.png')

%     figure 
%     hold on
%     image(flipud(alphas),'CDataMapping','scaled')
%     plot(X,Y,'r.')
%     axis equal
%     axis([0 size(alphas,2) 0 size(alphas,1)])
%     axis off
%     pause(1e-2)
%     saveas(gcf,'images/Pavia/k='+string(k)+'_optimum_detection(red).png')
    
% end

% pause(1)
% close all