% detect lines by Hough transform

close all;

% load('I4.mat');

% 读取图片
src = imread('2.jpg');

% 显示原图像
imshow(src);
title('原图像');
% 用ostu方法获取二值化阈值，进行二值化并进行显示
level = graythresh(src);
bw = im2bw(src,level);

%% 起初噪点
se = strel('disk',1);
openbw = imopen(bw,se);
figure(1);
imshow(openbw),title('去噪声二值化图');

%% 获取边界
bw1 = edge(openbw,'canny',[0 , 50/256]);
dilateElement = strel('square',2);  
bw2 = imdilate(bw1, dilateElement);  
% bw2 = imopen(bw2, strel('disk',1));  
I1 = bw2;
BW = I1;   % 提取边界

[H,T,R] = hough(BW);% 计算二值图像的标准霍夫变换，H为霍夫变换矩阵
                                % T,R为计算霍夫变换的角度和半径值

figure(2);
imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');%hough变换的图像
xlabel('\theta'), ylabel('\rho');
axis on,axis square,hold on;
pointNum = 18;  % 极值点数量
P  = houghpeaks(H,pointNum);%提取3个极值点
x = T(P(:,2));
y = R(P(:,1));

%% 画出线段
plot(x,y,'s','color','white');%标出极值点
lines=houghlines(BW,T,R,P);%提取线段

figure(3);
imshow(I1), hold on;
for k = 1:length(lines)
    pause(0.5);
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');%画出线段
    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');%起点
    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');%终点
end