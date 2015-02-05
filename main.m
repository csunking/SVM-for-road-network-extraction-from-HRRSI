
% multicalss classfication example from data to end.
% Rrviewed by WENG, 2015-1-2 1750
% Serial No 150102-Matlab-01(LS-SVM classification for multiclass type.)
% Copyright (c) 2015,  

clc;clear all;

% data parameters
filename='0.png';
IMG=double(imread(filename))./255;
classNames={'road';'buildings';'tress';'others'};
calssNum=size(classNames,1);
BolockSize=5;
EveryClassSampleNum=5;

% data formatting
if ~exist('TrainDataSet.mat','file'),
    TrainDataSet = getDataSet(IMG,classNames,BolockSize,EveryClassSampleNum );
    save TrainDataSet TrainDataSet;
else
    load TrainDataSet;
end
[M,N,P]=size(IMG);
everyImageSize=BolockSize^2;
trainData_PearCN=EveryClassSampleNum*everyImageSize;
trainData_Num=calssNum*trainData_PearCN;
Y_label=zeros(trainData_Num,1);     % label(tarin data label)
X_Data=zeros(trainData_Num,P);      % Data
for i=1:calssNum,
    Y_label((trainData_PearCN*(i-1)+1):(trainData_PearCN*i))=i;
    temp_clas=TrainDataSet(i,:);
    Cache_PerClassImage=zeros(trainData_PearCN,P);
    for subimg_j=1:EveryClassSampleNum,
        subimg=temp_clas{subimg_j}; % cell to matrix
        subimg=reshape(subimg,everyImageSize,P);
        Cache_PerClassImage((everyImageSize*(subimg_j-1)+1):(everyImageSize*subimg_j),:)=subimg;
    end
    X_Data((trainData_PearCN*(i-1)+1):(trainData_PearCN*i),:)=Cache_PerClassImage; % train data(feature)
end
clear temp_clas Cache_PerClassImage everyImageSize subimg;
Xt_f=reshape(IMG,M*N,P);    % test data


% process
% ----------------------------------------------------------------------------------------
t1=cputime;
model = initlssvm(X_Data,Y_label,'c',[],[],'RBF_kernel');
model = tunelssvm(model,'simplex','crossvalidatelssvm',{10,'misclass'},'code_OneVsAll');
model = trainlssvm(model);
yt = simlssvm(model,Xt_f);
% ----------------------------------------------------------------------------------------

% result of classficated display
IMG_classficated=reshape(yt,M,N);
add=IMG_classficated<0;
IMG_classficated(add)=0; % unclassfied class is define to 0;
figure,imshow(IMG_classficated,'colormap',prism,'InitialMagnification','fit');
title('The final classficated images');
% Verify the accuracy
% t=yt-Xt_label;
% Accurancy=size(find(t==0),1)/Xt_NumPoints;
% fprintf(1,'Accuracy: %2.2f\n',Accurancy);
t2=cputime;
time=t2-t1;
fprintf(1,'Tuning time %i \n',time);

