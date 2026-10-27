% Definizione della funzione ed eventuale intervallo
f=@(x) ((x-1).^2).*log(x); a=0.1; b=3;

% Definizione derivata prima
df=@(x) 2*(x-1).*log(x)+((x-1).^2)./x;

% grafico della funzione
figure(1)
fplot(f,[a,b],'b-');
hold on;
plot([a b],[0,0],'k-');
title('Grafico della funzione ((x-1).^2).*log(x)');
xlabel('asse x');
ylabel('asse y');
axis([a b -1 5]);
hold off;


%inizializzazione valori in input
x0=1.5;
toldif=1e-9;
maxit=100;

r=1;  %Metodo di Newton
% chiamata della function newtonmod
[xN,iterN,scartiN]=newtonmod(f,df,x0,toldif,maxit,r);

r=3;  %Metodo di Newton Modificato
% chiamata della function newtonmod
[xmod,itermod,scartimod]=newtonmod(f,df,x0,toldif,maxit,r);


% grafico semilogaritmico degli scarti
figure(2)
semilogy(1:iterN, abs(scartiN), 'm-*','LineWidth',3);
hold on;
semilogy(1:itermod, abs(scartimod), 'b-o','LineWidth',3);
title('Profilo di convergenza N. Modificato versus Newton');
xlabel('N.iterazioni');
ylabel('scarti');
legend('N','NM');
hold off
print -dpng modificato.png
