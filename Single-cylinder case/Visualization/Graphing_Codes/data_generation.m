%%
clc
clear
close all
%% Load Data
x=0.025:0.05:29.975;
y=0.025:0.05:7.975;
y=y';
x=x(200:360);
y=y(40:120);
yy=repmat(y,1,161);
yy=reshape(yy',13041,1);
x=x';
xx=repmat(x,81,1);
u=load('u8500');
w=load('w8500');
p=load('p8500');
u2=u(40:120,200:360);
uu_all=reshape(u2',13041,1);
w2=w(40:120,200:360);
ww_all=reshape(w2',13041,1);
p2=p(40:120,200:360);
pp_all=reshape(p2',13041,1);
tt_all=zeros(13041,1);
xx_all=xx;
yy_all=yy;
%% Accumulation
for i = 8501:1:8999
    u=load(['u',num2str(i)]);
    w=load(['w',num2str(i)]);
    p=load(['p',num2str(i)]);
    u2=u(40:120,200:360);
    uu=reshape(u2',13041,1);
    w2=w(40:120,200:360);
    ww=reshape(w2',13041,1);              
    p2=p(40:120,200:360);
    pp=reshape(p2',13041,1);
    tt=0.01*(i-8500)*ones(13041,1);
    uu_all=vertcat(uu_all,uu);
    ww_all=vertcat(ww_all,ww);
    pp_all=vertcat(pp_all,pp);
    tt_all=vertcat(tt_all,tt);
    xx_all=vertcat(xx_all,xx);
    yy_all=vertcat(yy_all,yy);
    disp(['Steps£º', num2str(i)]);
end
save('data-single.mat','xx_all','yy_all','tt_all','uu_all','ww_all','pp_all');