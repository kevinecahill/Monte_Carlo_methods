clear all
close all
clc
fs = 14; sf = 16; ts = 12;
maxEvents; totEvents;
h=bar(mox(:,1),log10(mox(:,2)));%,'k-','linewidth',2)
set(h,'facecolor',[0 0 0]+.5)
hold on
plot(tot(:,1),log10(tot(:,2)),'k-','linewidth',2)
axis([-1  30  1  6])
set(gca,'xtick',0:2:30)
%grid 'on'
textt='$\!\!\!\!\!\!\!\!\!\!\!\!\!\!\!\!$A Million Runs of 100 Days Each'
%title('A million 100-day runs','fontsize',ts)
textx='Number $n$ of muons detected'
xlabel(textx,'Interpreter','latex','fontsize',sf)
texty=('log$_{10}$(Histories)')
ylabel(texty,'Interpreter','latex','fontsize',sf)
text('Interpreter','latex','String','in 100 days','Position',[16,4.55],'FontSize',sf)
text('Interpreter','latex','String','in 1 day','Position',[4.9,2.8],'FontSize',sf)
print -dpdf muonsbw
print -deps muonsbw
print -deps /Users/kevin/papers/math/muonsbw