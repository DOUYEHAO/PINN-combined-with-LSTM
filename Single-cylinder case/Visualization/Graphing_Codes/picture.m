%%
clc
clear
close all
%% CFD(Global)
x=-3.975:0.05:25.975;
y=-3.975:0.05:3.975;
y=y';
w=load('CFD\w8500');
obs=load('CFD\obs');
[m,n]=size(w);
axis_all=[-4 16.0 -4.0 4.0];
gcf=figure(1);
surf(x,y,w)
view([0,90])
hold on
contour(x,y,obs(2:m+1,2:n+1), 2, 'r')
hold on
ylabel('y','FontWeight','bold','FontAngle','italic','FontSize',16,...
    'FontName','Times New Roman');
xlabel('x','FontWeight','bold','FontAngle','italic','FontSize',16,...
    'FontName','Times New Roman');
title('Velocity-${v}$(m/s)', 'Interpreter', 'latex','FontWeight','bold','FontAngle','italic','FontSize',18,...
    'FontName','Times New Roman')
shading interp
colormap('jet')
colorbar 
set (gcf,'Position',[200,200,1000,500]);
axis equal
axis(axis_all)
%% CFD(Part)
x=-3.95:0.05:26.0;
y=-3.95:0.05:4.0;
y=y';
x=x(100:260);
y=y(40:120);
w=load('CFD\w9100');
w2=w(40:120,100:260);
ww=reshape(w2',13041,1);
[m,n]=size(w);
axis_all=[1 9 -2 2];
gcf=figure(2);
surf(x,y,w2)
view([0,90])
hold on
ylabel('y','FontWeight','bold','FontAngle','italic','FontSize',16,...
    'FontName','Times New Roman');
xlabel('x','FontWeight','bold','FontAngle','italic','FontSize',16,...
    'FontName','Times New Roman');
title('CFD-${v}$', 'Interpreter', 'latex','FontWeight','bold','FontAngle','italic','FontSize',18,...
    'FontName','Times New Roman');
shading interp
colormap('jet')
colorbar
% caxis([-0.2,1.2]) % u-velocity
caxis([-0.6,0.61]) % w-velocity
set (gcf,'Position',[500,300,600,300]);
axis equal
set(gca,'xtick',1:1:9) 
set(gca,'ytick',-2:1:2)
axis(axis_all)
%% Predicted
p_p=load('PINN\v600.txt');
axis_all=[1 9 -2 2];
x=linspace(1, 9, 161);
y=linspace(-2, 2, 81);
y=y';
p_p=reshape(p_p, 161, 81); 
p_p=p_p';
gcf=figure(3);
surf(x,y,p_p)
colormap('jet')
view([0,90])
hold on
ylabel('y','FontWeight','bold','FontAngle','italic','FontSize',16,...
    'FontName','Times New Roman');
xlabel('x','FontWeight','bold','FontAngle','italic','FontSize',16,...
    'FontName','Times New Roman');
title('PINN-${v}$', 'Interpreter', 'latex','FontWeight','bold','FontAngle','italic','FontSize',18,...
    'FontName','Times New Roman');
shading interp
colorbar
set (gcf,'Position',[500,300,600,300]);
% caxis([-0.2,1.2]) % u-velocity
caxis([-0.6,0.61]) % w-velocity
axis equal
axis(axis_all)
%% Error=CFD-Predicted
axis_all=[1 9 -2 2];
e_p=w2-p_p;
x=linspace(1, 9, 161);
y=linspace(-2, 2, 81);
y=y';
gcf=figure(4);
surf(x,y,e_p);
colormap('jet')
view([0,90])
xlabel('x','Fontsize',12);
ylabel('y','Fontsize',12);
title('Error','Fontsize',30);
ylabel('y','FontWeight','bold','FontAngle','italic','FontSize',16,...
    'FontName','Times New Roman');
xlabel('x','FontWeight','bold','FontAngle','italic','FontSize',16,...
    'FontName','Times New Roman');
title('Error','Fontsize',18);
shading interp
colorbar
set(gcf,'Position',[500,300,600,300]);
axis equal
axis(axis_all)
%% Relative error
percent_p=abs(e_p)./w2;
x=linspace(1, 9, 161);
y=linspace(-2, 2, 81);
y=y';
gcf=figure(5);
surf(x,y,percent_p);
colormap('jet')
view([0,90])
ylabel('y','FontWeight','bold','FontAngle','italic','FontSize',16,...
    'FontName','Times New Roman');
xlabel('x','FontWeight','bold','FontAngle','italic','FontSize',16,...
    'FontName','Times New Roman');
title('Relative error','Interpreter', 'latex','Fontsize',18);
set(gcf,'Position',[500,300,600,300]);
shading interp
caxis([-1,1])
colorbar
axis equal
axis(axis_all)