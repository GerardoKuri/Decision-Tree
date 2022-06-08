clear all;
close all;
clc;
%%
%
filename = 'contact-lenses.xls';
%%
%filename = 'Clima.xls';
%db(:,1)=[];
%%
[num,db,raw] = xlsread(filename);


DB=db(2:end,:);

arbol = fourLevelDecTree(DB);  


