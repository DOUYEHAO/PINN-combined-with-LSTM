%%
clc
clear
close all
%% CFD-Data
v=load('CFD\w9020');
v=v(40:120,100:260);
v=reshape(v,1,13041);
p=v;
p_all=p;
%% LSTM-PINN-Data
p_p=load('LSTM-PINN\v520.txt');
p_p=reshape(p_p,161,81);
p_p=p_p';
p_p=reshape(p_p,1,13041);
pp_all=p_p;
%% PINN-Data
p_pp=load('PINN\v520.txt');
p_pp=reshape(p_pp,161,81); 
p_pp=p_pp';
p_pp=reshape(p_pp,1,13041);
ppp_all=p_pp;
%% Accumulation
for i = 540:20:600
    p=load(['CFD\w',num2str(8500+i)]);
    p=p(40:120,100:260);
    p=reshape(p,1,13041);
    p_p=load(['LSTM-PINN\v',num2str(i),'.txt']);
    p_p=reshape(p_p,161,81);
    p_p=p_p';
    p_p=reshape(p_p,1,13041);
    p_pp=load(['PINN\v',num2str(i),'.txt']);
    p_pp=reshape(p_pp,161,81); 
    p_pp=p_pp';
    p_pp=reshape(p_pp,1,13041);
    p_all=horzcat(p_all,p);
    pp_all=horzcat(pp_all,p_p);
    ppp_all=horzcat(ppp_all,p_pp);
    disp(['Steps£º', num2str(i)]);
end
save('all-v.mat','p_all','pp_all','ppp_all');
%% Calculate rmse,R^2
mean1=p_all-mean(p_all);
mean2=pp_all-mean(pp_all);
a=sum(mean1.*mean2)/(sqrt(sum(mean1.^2))*sqrt(sum(mean2.^2)))
b=sum(mean1.*mean2)/(sqrt(sum(mean1.^2)*sum(mean2.^2)))
c1=1-sum((p_all-pp_all).^2)/(sum((p_all-mean(p_all)).^2))
c2=1-sum((p_all-ppp_all).^2)/(sum((p_all-mean(p_all)).^2))
rmse1=sqrt(sum((p_all-pp_all).^2)/13041)
rmse2=sqrt(sum((p_all-ppp_all).^2)/13041)
%% Draw coefficients of determination
load('all-u')
gcf=figure(3);
scatter(ppp_all, p_all, 40,[1,0,0],'Marker','*','LineWidth',1); 
hold on;
scatter(pp_all, p_all, 40,[0,0,1],'Marker','+','LineWidth',1); 
hold on;
x=linspace(-0.4,1.6,100);
n = 1;
p = polyfit(pp_all, p_all, n);
y_fit = polyval(p, x); 
plot(x,y_fit,'g','Linewidth',3);

hold on;
y=x;
plot(x,y,'k','Linewidth',1.5);

xlabel('Predicted-${u}$(m/s)','Interpreter', 'latex','Fontsize',15);
ylabel('CFD-${u}$(m/s)','Interpreter', 'latex','Fontsize',15);
grid on
box on
axis equal
xlim([-0.4,1.6])
ylim([-0.4,1.6])
% X axes
xticks = -0.4:0.2:1.6;
set(gca, 'XTick', xticks);

% Y axes 
yticks = -0.4:0.2:1.6;
set(gca, 'YTick', yticks);
legend('Data-PINN','Data-LP','Best fit line','Identity:y=x','Interpreter', 'latex','Location','southeast')
title('Coefficient-${u}$:R${^2}$=0.9998', 'Interpreter', 'latex','Fontsize',15);
set (gcf,'Position',[500,300,550,500]);