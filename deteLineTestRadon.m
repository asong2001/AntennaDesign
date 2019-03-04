% detect line by radon transform
% 处理输入的灰度图
close all;

load('I4.mat');
I = I4;
BW = I;   % 提取边界

theta = 0:179;
[R,xp] = radon(BW);