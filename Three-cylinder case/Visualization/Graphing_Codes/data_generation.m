%%
clc
clear
close all
%% ��ͼu
x=0.025:0.05:29.975;
y=0.025:0.05:7.975;
y=y';
x=x(200:360);
y=y(40:120);
w=load('w8500');
w=w(40:120,200:360);
obs=load('obs');
% [m,n]=size(w);
%
axis_all=[0 24.0 0.0 8.0];
gcf=figure(1);
surf(x,y,w)
view([0,90])
hold on
% contour(x,y,obs(2:m+1,2:n+1), 2, 'r')%���ݸ���Ԫ�� obs ֵ���е�ֵ�߻�ͼ��ע��obs�ļ��ķ�Χ
hold on
rectangle('Position', [2-0.5,2-0.5,2*0.5,2*0.5], 'Curvature', [1 1],'EdgeColor', 'k','facecolor','k');
rectangle('Position', [2-0.5,6-0.5,2*0.5,2*0.5], 'Curvature', [1 1],'EdgeColor', 'k','facecolor','k');
rectangle('Position', [7-0.5,4-0.5,2*0.5,2*0.5], 'Curvature', [1 1],'EdgeColor', 'k','facecolor','k');
xlabel('x','Fontsize',12);
ylabel('y','Fontsize',12);
title('��������','Fontsize',12);
shading interp
colormap('jet')
%set(gca,'xtick',0:1:10) 
%set(gca,'ytick',0:0.2:2)
set(gca, 'FontSize', 12);%������������
% caxis([-0.2,1.3]) %������ɫ��
caxis([-0.5,0.5]) %������ɫ��-�����ٶ�
colorbar %��ʾ��ɫ��
set (gcf,'Position',[500,300,1000,500]);
axis equal
axis(axis_all)
%% �ļ�����
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
%%
for i = 8501:1:9099
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
    disp(['������', num2str(i)]);
end
save('data(8500-9099��delt_t=0.01s).mat','xx_all','yy_all','tt_all','uu_all','ww_all','pp_all');
%%
for i = 7510:10:9490
    fprintf('��ǰ���е��� %d ��n', i);
end