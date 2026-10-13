% --------------------------%
% ESERCIZIO SVOLTO A LEZIONE
% --------------------------%

%Definizione della funzione e della sua derivata prima
f=@(x)  exp(-2*x) - x.^2; 
df=@(x) -2*exp(-2*x) - 2*x; 

% inizializza i parametri
toll=1e-7;
itmax=100;
a=0;b=1;


%Disegna la funzione f(x) e l'asse x nella stessa figura
figure(1)
h=ezplot(f,[a b]);
set(h, 'Color','b','Linestyle','-','LineWidth',2);
hold on; plot([a b],[0 0],'k-');hold off;

% chiamata alla function newton
%%x0=0;
%x0=1.0; 
x0=0.6; 
[xN,iterN,scartiN]=newton(f,df,x0,toll,10);

%Stampa a video dei risultati mediante un ciclo for
fprintf('Metodo di Newton \n');
fprintf('\n [k]: %2.0f \t [xk]: %10.15f \t [sk]: ',1,xN(1));
for k=2:iterN+1
fprintf('\n [k]: %2.0f \t [xk]: %10.15f \t [sk]: %10.2e',k,xN(k),scartiN(k-1));
end
fprintf('\n');

% crea grafico  con il profilo di convergenza
figure(2)
semilogy(1:iterN,abs(scartiN),'m-o', 'LineWidth',2);
title('Profilo di convergenza Metodo di Newton');
xlabel('N. iterazioni');
ylabel('scarto/residuo pesato');

