mex  prepare_data_from_annotation_omp.cpp -I'C:\opencv\build\include' -L'C:\opencv\build\x64\vc12\lib' -lopencv_core2411.lib -lopencv_highgui2411.lib -lopencv_imgproc2411.lib
% list = {'C:\Users\scien\Pictures\showPhoto.jpg'; 'C:\Users\scien\Pictures\test.jpg'};
% img = imread_mex(list, [1,1,200,200;1,1,150,150]', 100);
tic;
data = imread_mex(list(1:1000),rect(1:1000,:)',64);
toc;
data = permute(data,[2 3 1 4]);
for i = 1 : 50:1000
    imshow(data(:,:,:,i));
    waitforbuttonpress;
end