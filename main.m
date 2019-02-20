clear all;
image=imread('hw5.jpg');
hsi_image=rgb2hsi(image);
hsv_image=rgb2hsv(image);
[m n]=size(hsi_image);
n=n/3;
for i=1:m
    for j=1:n
        if hsv_image(i,j,3)>0.32
            if -2*pi/4<hsi_image(i,j,1)<2*pi/4 & hsi_image(i,j,2)>0.2
                hsi_image(i,j,2)=0;
            end
        end
    end
end
new_image=hsi2rgb(hsi_image);
figure, imshow(new_image);