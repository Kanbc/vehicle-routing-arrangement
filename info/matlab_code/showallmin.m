clear all
close all
clc

load data_check

strn=str(ind1-1,:)
numn=num(ind1-1:ind1,:)

xlswrite('data_allmin.xlsx',strn,1,'A1')
xlswrite('data_allmin.xlsx',numn,1,'A2')