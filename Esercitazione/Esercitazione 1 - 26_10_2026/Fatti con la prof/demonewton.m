% Definizione della funzione e dell'intervallo
f=@(x) x.^2-2; a=-2; b=2;
%Definizione dell aderivata prima
df=@(x) 2*x; 

% Inizializzazione dei parametri di ingresso
tol=1e-8;
itmax=50;


%Disegna la funzione f(x) e l'asse x nella stessa figura
figure(1)
ezplot(f,[a b]);hold on; plot([a b],[0 0],'k-');hold off;

% -----------------%
% PUNTO INIZIALE   %
% -----------------%
x0=1.5;

% Chiamata alla function newton perche' venga eseguita
[xN,iterN,scartiN]=newton(f,df,x0,tol,itmax);

%Stampa a video dei risultati mediante un ciclo for
fprintf('\n [k]: %2.0f \t [xk]: %10.15f \t [dif]: ',1,xN(1));
for k=2:iterN+1
fprintf('\n [k]: %2.0f \t [xk]: %10.15f \t [dif]: %10.2e',k,xN(k),scartiN(k-1));
end
fprintf('\n');


%% Creazione del profilo di convergenza
figure(2)
semilogy(1:iterN,abs(scartiN),'m-*')
title('Profilo di convergenza del  metodo di Newton(f(x)= x^2 - 2)');
xlabel('iterazioni');
ylabel('scarto');
legend('Newton');

