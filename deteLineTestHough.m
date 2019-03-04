% detect lines by Hough transform

close all;

% load('I4.mat');

% ��ȡͼƬ
src = imread('2.jpg');

% ��ʾԭͼ��
imshow(src);
title('ԭͼ��');
% ��ostu������ȡ��ֵ����ֵ�����ж�ֵ����������ʾ
level = graythresh(src);
bw = im2bw(src,level);

%% ������
se = strel('disk',1);
openbw = imopen(bw,se);
figure(1);
imshow(openbw),title('ȥ������ֵ��ͼ');

%% ��ȡ�߽�
bw1 = edge(openbw,'canny',[0 , 50/256]);
dilateElement = strel('square',2);  
bw2 = imdilate(bw1, dilateElement);  
% bw2 = imopen(bw2, strel('disk',1));  
I1 = bw2;
BW = I1;   % ��ȡ�߽�

[H,T,R] = hough(BW);% �����ֵͼ��ı�׼����任��HΪ����任����
                                % T,RΪ�������任�ĽǶȺͰ뾶ֵ

figure(2);
imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');%hough�任��ͼ��
xlabel('\theta'), ylabel('\rho');
axis on,axis square,hold on;
pointNum = 18;  % ��ֵ������
P  = houghpeaks(H,pointNum);%��ȡ3����ֵ��
x = T(P(:,2));
y = R(P(:,1));

%% �����߶�
plot(x,y,'s','color','white');%�����ֵ��
lines=houghlines(BW,T,R,P);%��ȡ�߶�

figure(3);
imshow(I1), hold on;
for k = 1:length(lines)
    pause(0.5);
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');%�����߶�
    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');%���
    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');%�յ�
end