% detect line by radon transform
% ��������ĻҶ�ͼ
close all;

load('I4.mat');
I = I4;
BW = I;   % ��ȡ�߽�

theta = 0:179;
[R,xp] = radon(BW);