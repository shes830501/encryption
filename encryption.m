%Henon
%Xn+1 = 1 - αXn^2 + Yn
%Yn+1 = βXn
%其中α = 1.4；β = 0.3，使用密鑰key = -0.4
%α =：（0,1.4） ；0.2 < β <= 0.3.14
%使用密鑰作為初始值，得到兩組混沌序列，然後將照片A的序列打亂。

clc,clear;
a = imread('beauty.jpg'); secret_image = size(a);  %讀入保密圖像
a1 = imread('shelly.jpg'); carrier_image1 = size(a1); %讀入載體1
a2 = imread('dog.jpg'); carrier_image2 = size(a2); %讀入載體2
a3 = imread('me.jpg'); carrier_image3 = size(a3); %讀入載體3
a4 = imread('me2.jpg'); carrier_image4 = size(a4); %讀入載體4
a5 = imread('ohba.jpg'); carrier_image5 = size(a5); %讀入載體5
a6 = imread('th.jpg'); carrier_image6 = size(a6); %讀入載體6
a7 = imread('leonardo_dicaprio.jpg'); carrier_image7 = size(a7); %讀入載體7
a8 = imread('kobe_18.jpg'); carrier_image8 = size(a8); %讀入載體8
ca_im{1} = imresize(a1,secret_image(1:2)); %把載體圖像1變為與保密圖像相同大小
ca_im{2} = imresize(a2,secret_image(1:2)); %把載體圖像2變為與保密圖像相同大小
ca_im{3} = imresize(a3,secret_image(1:2)); %把載體圖像3變為與保密圖像相同大小
ca_im{4} = imresize(a4,secret_image(1:2)); %把載體圖像4變為與保密圖像相同大小
ca_im{5} = imresize(a5,secret_image(1:2)); %把載體圖像5變為與保密圖像相同大小
ca_im{6} = imresize(a6,secret_image(1:2)); %把載體圖像6變為與保密圖像相同大小
ca_im{7} = imresize(a7,secret_image(1:2)); %把載體圖像7變為與保密圖像相同大小
ca_im{8} = imresize(a8,secret_image(1:2)); %把載體圖像8變為與保密圖像相同大小

key = -0.40001; %給出秘鑰
L = max(secret_image); x(1) = key; y(1) = key; alpha = 1.4; beta = 0.3;
for i = 1:L-1 %生成兩組混沌序列
    x(i+1) = 1 - alpha * x(i) ^ 2 + y(i); 
    y(i+1) = beta * x(i);
end

x(secret_image(1,1)+1:end)=[]; %刪掉x後面一部分元素
[sx,ind1] = sort(x); [sy,ind2] = sort(y); %對混沌序列從小到大排序
encrypted_array(ind1,ind2,:) = a; %打亂保密圖像的行和列，生產加密提箱矩陣encrypted_array :代表RGB
imshow(encrypted_array); %顯示保密圖像加密所得到的圖像

for i = 1:8;
    ca_im_{i} = bitand(ca_im{i}, 255-2^(i-1));
    encrypted_array_{i} = bitand(encrypted_array,2^(i-1)); 
    compound_image{i} = bitor(ca_im_{i},encrypted_array_{i});
    imshow(compound_image{i}); %把加密圖像嵌入載體圖像，構成合成圖像
end
    
% ca_im_1 = bitand(ca_im{1},127); %載體圖像與01111111 = 127逐位運算 
% encrypted_array_1 = bitand(encrypted_array,128); %加密圖像與10000000 = 128逐位運算 保留加密圖像高1位
% compound_image1 = bitor(ca_im_1,encrypted_array_1); %把加密圖像嵌入載體圖像的高1位，構成合成圖像1
% imshow(compound_image1);
% 
% ca_im_2 = bitand(ca_im{2},191); %載體圖像與10111111 = 191逐位運算
% encrypted_array_2 = bitand(encrypted_array,64);  %加密圖像與01000000 = 64逐位運算 保留加密圖像高2位
% compound_image2 = bitor(ca_im_2,encrypted_array_2); %把加密圖像嵌入載體圖像的高2位，構成合成圖像2
% imshow(compound_image2);
% 
% ca_im_3 = bitand(ca_im{3},223); %載體圖像與11011111 = 223逐位運算
% encrypted_array_3 = bitand(encrypted_array,32); %加密圖像與00100000 = 32逐位運算 保留加密圖像高3位
% compound_image3 = bitor(ca_im_3,encrypted_array_3); %把加密圖像嵌入載體圖像的高3位，構成合成圖像3
% imshow(compound_image3);
% 
% ca_im_4 = bitand(ca_im{4},239); %載體圖像與11101111 = 239逐位運算
% encrypted_array_4 = bitand(encrypted_array,16); %加密圖像與00010000 = 16逐位運算 保留加密圖像高4位
% compound_image4 = bitor(ca_im_4,encrypted_array_4); %把加密圖像嵌入載體圖像的高4位，構成合成圖像4
% imshow(compound_image4);
% 
% ca_im_5 = bitand(ca_im{5},247); %載體圖像與11110111 = 247逐位運算
% encrypted_array_5 = bitand(encrypted_array,8); %加密圖像與00001000 = 8逐位運算 保留加密圖像低4位
% compound_image5 = bitor(ca_im_5,encrypted_array_5); %把加密圖像嵌入載體圖像的低4位，構成合成圖像5
% imshow(compound_image5);
% 
% ca_im_6 = bitand(ca_im{6},251); %載體圖像與11111011 = 251逐位運算
% encrypted_array_6 = bitand(encrypted_array,4); %加密圖像與00000100 = 4逐位運算 保留加密圖像低3位
% compound_image6 = bitor(ca_im_6,encrypted_array_6); %把加密圖像嵌入載體圖像的低3位，構成合成圖像6
% imshow(compound_image6);
% 
% ca_im_7 = bitand(ca_im{7},253); %載體圖像與11111101 = 253逐位運算
% encrypted_array_7 = bitand(encrypted_array,2); %加密圖像與00000010 = 2逐位運算 保留加密圖像低2位
% compound_image7 = bitor(ca_im_1,encrypted_array_7); %把加密圖像嵌入載體圖像的低2位，構成合成圖像7
% imshow(compound_image7);
% 
% ca_im_8 = bitand(ca_im{8},254); %載體圖像與11111110 = 254逐位運算
% encrypted_array_8 = bitand(encrypted_array,1); %加密圖像與00000001 = 1逐位運算 保留加密圖像低1位
% compound_image8 = bitor(ca_im_8,encrypted_array_8); %把加密圖像嵌入載體圖像的低1位，構成合成圖像8
% imshow(compound_image8);

for i = 1:8;
    cpd_im{i} = bitand(compound_image{i}, 2^(i-1)); %對合成圖像進行解密
    cpd_im_{i} = cpd_im{i}(ind1,ind2,:);
    imshow(cpd_im_{i}); %提取並解密還原後的圖像
end

% cpd_im1 = bitand(compound_image1, 128); %對合成圖像1進行解密
% cpd_im_1 = cpd_im1(ind1,ind2,:);
% imshow(cpd_im_1); %提取並解密還原後的圖像
% 
% cpd_im2 = bitand(compound_image2, 64); %對合成圖像2進行解密
% cpd_im_2 = cpd_im2(ind1,ind2,:);
% imshow(cpd_im_2); %提取並解密還原後的圖像
% 
% cpd_im3 = bitand(compound_image3, 32); %對合成圖像3進行解密
% cpd_im_3 = cpd_im3(ind1,ind2,:);
% imshow(cpd_im_3); %提取並解密還原後的圖像
% 
% cpd_im4 = bitand(compound_image4, 16); %對合成圖像4進行解密
% cpd_im_4 = cpd_im4(ind1,ind2,:);
% imshow(cpd_im_4); %提取並解密還原後的圖像
% 
% cpd_im5 = bitand(compound_image5, 8); %對合成圖像5進行解密
% cpd_im_5 = cpd_im5(ind1,ind2,:);
% imshow(cpd_im_5); %提取並解密還原後的圖像
% 
% cpd_im6 = bitand(compound_image6, 4); %對合成圖像6進行解密
% cpd_im_6 = cpd_im6(ind1,ind2,:);
% imshow(cpd_im_6); %提取並解密還原後的圖像
% 
% cpd_im7 = bitand(compound_image7, 2); %對合成圖像7進行解密
% cpd_im_7 = cpd_im7(ind1,ind2,:);
% imshow(cpd_im_7); %提取並解密還原後的圖像
% 
% cpd_im8 = bitand(compound_image8, 1); %對合成圖像8進行解密
% cpd_im_8 = cpd_im8(ind1,ind2,:);
% imshow(cpd_im_8); %提取並解密還原後的圖像

result = cpd_im_{1};
for i = 2:8
     result = bitor(result, cpd_im_{i});
end
imshow(result);

if (result == a)
    disp('Success')
else
    disp('Fail')
end
