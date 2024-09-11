%%
clc
clear
close all
%% Load RMSE
p=load('CFD\u9000');
p=p(40:120,100:260);
p=reshape(p,1,13041);
p_p=load('LSTM-PINN\u500.txt');
p_p=reshape(p_p,161,81);
p_p=p_p';
p_p=reshape(p_p,1,13041);
p_pp=load('PINN\u500.txt');
p_pp=reshape(p_pp,161,81);
p_pp=p_pp';
p_pp=reshape(p_pp,1,13041);
rmse1=sqrt(sum((p-p_p).^2)/13041);
rmse2=sqrt(sum((p-p_pp).^2)/13041);
rmse1_all=rmse1;
rmse2_all=rmse2;
%% Accumulation
for i = 505:5:600
    p=load(['CFD\u',num2str(8500+i)]);
    p=p(40:120,100:260);
    p=reshape(p,1,13041);
    p_p=load(['LSTM-PINN\u',num2str(i),'.txt']);
    p_p=reshape(p_p,161,81); 
    p_p=p_p';
    p_p=reshape(p_p,1,13041);
    p_pp=load(['PINN\u',num2str(i),'.txt']);
    p_pp=reshape(p_pp,161,81);
    p_pp=p_pp';
    p_pp=reshape(p_pp,1,13041);
    rmse1=sqrt(sum((p-p_p).^2)/13041);
    rmse2=sqrt(sum((p-p_pp).^2)/13041);
    rmse1_all=vertcat(rmse1_all,rmse1);
    rmse2_all=vertcat(rmse2_all,rmse2);
    disp(['Steps£º', num2str(i)]);
end
save('u-rmse.mat','rmse1_all','rmse2_all');
%% Draw RMSE
load('u-rmse.mat');
rmse1=rmse1_all;
rmse2=rmse2_all;
t=linspace(10, 11, 21);
gcf=figure(7);
plot(t,rmse1,'r-*','LineWidth',2)
hold on 
plot(t,rmse2,'m-+','LineWidth',2)
hold on
grid on
ylabel('RMSE','FontWeight','bold','FontAngle','italic','FontSize',15,...
    'FontName','Times New Roman');
xlabel('t','FontWeight','bold','FontAngle','italic','FontSize',15,...
    'FontName','Times New Roman');
title('Predicted-${u}$', 'Interpreter', 'latex','FontWeight','bold','FontAngle','italic','FontSize',17,...
    'FontName','Times New Roman');
legend('LSTM-PINN','PINN','Interpreter', 'latex','Location','southeast','Location','northwest')