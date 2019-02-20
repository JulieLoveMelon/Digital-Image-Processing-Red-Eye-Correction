function rgb=hsi2rgb(hsi)
%% 提取HSI各通道分量
H=hsi(:,:,1)*2*pi;
S=hsi(:,:,2);
I=hsi(:,:,3); 

%% 构造RGB空间对应大小的矩阵
R=zeros(size(hsi,1),size(hsi,2));
G=zeros(size(hsi,1),size(hsi,2));
B=zeros(size(hsi,1),size(hsi,2)); 

%% 处理0<=H<2*pi/3的情况
idx=find((0<=H)&(H<2*pi/3));
B(idx)=I(idx).*(1-S(idx));
R(idx)=I(idx).*(1+S(idx).*cos(H(idx))./cos(pi/3-H(idx)));
G(idx)=3*I(idx)-(R(idx)+B(idx));

%% 处理2*pi/3<=H<4*pi/3的情况
idx=find((2*pi/3<=H)&(H<4*pi/3));
R(idx)=I(idx).*(1-S(idx));
G(idx)=I(idx).*(1+S(idx).*cos(H(idx)-2*pi/3)./cos(pi-H(idx)));
B(idx)=3*I(idx)-(R(idx)+G(idx));

%% 处理4*pi/3<=H<=2*pi的情况
idx=find((4*pi/3<=H)&(H<=2*pi));
G(idx)=I(idx).*(1-S(idx));
B(idx)=I(idx).*(1+S(idx).*cos(H(idx)-4*pi/3)./cos(5*pi/3-H(idx)));
R(idx)=3*I(idx)-(G(idx)+B(idx));

%% 合成RGB图并使其各分量在0~1之间
rgb=cat(3,R,G,B);
rgb=max(min(rgb,1),0); 
