clear all
close all
clc


load dataii1_1_10

[row,col]=size(seq);

for ii12=6e5+1:9e5
    rr1=seq(ii12,:)';
txt1=txt10(rr1,:);
num1=num10(rr1,1);

ss1=txt1{1,1};
ss2=txt1{1,2};
ind1=find(strcmp(ss1,st));
ind2=find(strcmp(ss2,st));

km(1)=num(ind1,ind2);
num1(1)=num1(1)-1;
station{kk1+1,1}=ss1;
station{kk1+1,2}=ss2;

station{kk1+2,1}=0;
station{kk1+2,2}=km(1);

station{kk1+3,1}=0;
station{kk1+3,2}=1;


kk=1;

while sum(num1)>0
    km2=[];
%     num1
ind5=find(num1>0);
% pause
for ii=1:length(ind5)
    ss2=txt1{ind5(ii),1};
ind3=find(strcmp(ss2,st));
km2(ii)=num(ind2,ind3);
end

[km2,ind4]=sort(km2);
kk=kk+1;
km(kk)=km2(1);




ss1=txt1{ind5(ind4(1)),1};
ss2=txt1{ind5(ind4(1)),2};
ind1=find(strcmp(ss1,st));
ind2=find(strcmp(ss2,st));



kk=kk+1;
km(kk)=num(ind1,ind2);
num1(ind5(ind4(1)))=num1(ind5(ind4(1)))-1;
kk1=(ii12-1-6e5)*3;
station{kk1+1,kk}=ss1;
station{kk1+1,kk+1}=ss2;

station{kk1+2,kk}=km(kk-1);
station{kk1+2,kk+1}=km(kk);

station{kk1+3,kk}=0;
station{kk1+3,kk+1}=1;

% pause


end  %end while
% kk1=kk1+3;


station{kk1+2,kk+2}=sum(km);
station{kk1+3,kk+2}=sum(km(2:end));

disp(ii12)
end


save result_6e5_9e5

for ii=1:3

    datawrite=station((ii-1)*1e5+1:ii*1e5,:);
    name=['data_' num2str((ii-1)*1e5+1+6e5) 'to' num2str(ii*1e5+6e5) '.xlsx'];
xlswrite(name,datawrite)
end
