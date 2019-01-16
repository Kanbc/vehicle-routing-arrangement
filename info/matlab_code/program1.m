clear all
close all
clc


[num,txt]=xlsread('data.xlsx','long');

st=txt(2:end,1)

% for ii=1:length(st)
%     st1{ii,1}=['A' num2str(ii)];
%     st1{ii,2}=st(ii);
% end
% st1


[num1,txt1]=xlsread('data.xlsx','work');
txt1
num1

name0=st;
name1=txt1;
No0=num1;

ss1=txt1{1,1}
ss2=txt1{1,2}
ind1=find(strcmp(ss1,st))
ind2=find(strcmp(ss2,st))

km(1)=num(ind1,ind2)
num1(1)=num1(1)-1
station{1,1}=ss1;
station{1,2}=ss2;
station{2,1}=0;
station{2,2}=km(1);
pause

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

[km2,ind4]=sort(km2)
kk=kk+1;
km(kk)=km2(1)
pause



ss1=txt1{ind5(ind4(1)),1}
ss2=txt1{ind5(ind4(1)),2}
ind1=find(strcmp(ss1,st))
ind2=find(strcmp(ss2,st))



kk=kk+1;
km(kk)=num(ind1,ind2)
num1(ind5(ind4(1)))=num1(ind5(ind4(1)))-1
pause

station{1,kk}=ss1;
station{1,kk+1}=ss2;

station{2,kk}=km(kk-1);
station{2,kk+1}=km(kk);

% pause

end

station
xlswrite('dataout.xlsx',station)
All=sum(km)
% 
% ss3=txt1{ind4(1),1};
% ss4=txt1{ind4(1),2};
% ind1=find(strcmp(ss3,st));
% ind2=find(strcmp(ss4,st));
% km(3)=num(ind1,ind2);
% 
% num1(ind4(1))=num1(ind4(1))-1;
% 
% 
% for ii=1:size(txt1,1)
%     ss2=txt1{ii,1};
% ind3=find(strcmp(ss2,st));
% km2(ii)=num(ind2,ind3);
% end
% 
% km2
% [km2,ind4]=sort(km2);
% km(4)=km2(1)





















% 
% 
% ss3=txt1{ind4(1),1}
% ss4=txt1{ind4(1),2}
% ind1=find(strcmp(ss3,st))
% ind2=find(strcmp(ss4,st))
% km(3)=num(ind1,ind2)
% 
% num1(ind4(1))=num1(ind4(1))-1
% 
% 
% for ii=1:size(txt1,1)
%     ss2=txt1{ii,1};
% ind3=find(strcmp(ss2,st));
% km2(ii)=num(ind2,ind3);
% end
% 
% km2
% [km2,ind4]=sort(km2);
% km(4)=km2(1)
% 
% 
% ss3=txt1{ind4(1),1}
% ss4=txt1{ind4(1),2}
% ind1=find(strcmp(ss3,st))
% ind2=find(strcmp(ss4,st))
% km(5)=num(ind1,ind2)
% 
% num1(ind4(1))=num1(ind4(1))-1
% 
% 
% for ii=1:size(txt1,1)
%     ss2=txt1{ii,1};
% ind3=find(strcmp(ss2,st));
% km2(ii)=num(ind2,ind3);
% end
% 
