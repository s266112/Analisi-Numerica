n=35;
a=-1;
b=1;
clf;
xgc = chebgauss(a,b,n); % calcolo dei nodi di Gauss-Chebyshev
xgcl = chebgausslob(a,b,n); %di Gauss-Chebyshev-Lobatto
plot(xgc,zeros(length(xgc),1),'rs');hold on;
plot(xgcl,zeros(length(xgcl),1),'b*');
title('Confronto tra nodi di CG (rosso) e di CGL (blue)');
legend('Nodi CG',' Nodi CGL')
hold off
