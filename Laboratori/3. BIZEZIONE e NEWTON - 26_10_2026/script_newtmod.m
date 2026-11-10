% ---- Definizione della funzione e della derivata ----

f = @(x) ((x-1).^2).*log(x);                 % Funzione
df = @(x) 2*(x-1).*log(x) + ((x-1).^2)./x;   % Derivata prima
a = 0.1;                                     % Intervalli
b = 3;


% --- Parametri di input ---
toldif = 1e-9;
maxit = 100;
x0 = 1.5;       % Punto iniziale


% --- Grafico della funzione ---
figure(1);
fplot(f, [a b], 'b-'); 
hold on;
plot([a b], [0 0], 'k-');
hold off;
title('Funzione f(x) = (x-1)^2 * log(x)');


% --- Chiamata alla function newtonmod ---
r1 = 1;   % Molteplicità per Newton classico
[xN, iterN, scartiN] = newtonmod(f, df, x0, toldif, maxit, r1);

r2 = 3;   % Molteplicità per Newton Modificato
[xmod, itermod, scartimod] = newtonmod(f, df, x0, toldif, maxit, r2);


% --- Creazione del profilo di convergenza ---
figure(2);
semilogy(1:iterN, abs(scartiN), 'm-*', 'LineWidth', 1.5);
hold on;
semilogy(1:itermod, abs(scartimod), 'b-o', 'LineWidth', 1.5);
title('Profilo di convergenza N. Modificato versus Newton');
xlabel('Iterazioni');
ylabel('Scarto');
legend('N', 'NM');
grid on; % Aggiunge la griglia, utile per leggere i grafici
hold off;


% --- Salvataggio del grafico ---
print -dpng modificato.png; % Salva la figura corrente come immagine PNG
