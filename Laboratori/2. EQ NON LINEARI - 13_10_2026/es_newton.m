% ==========================================
% ESERCIZIO: Radice maggiore di f(x) = x^2 - 5x + 6 con il metodo di Newton
% ==========================================

clear; clc;  % Pulisco workspace e command window

% --- Parametri di input ---
f  = @(x) x.^2 - 5*x + 6;   % Funzione di cui cerco lo zero
df = @(x) 2*x - 5;          % Derivata prima di f
xmin = 0; xmax = 5;         % Intervallo per il grafico
x0 = 4;                     % Punto iniziale: a destra del vertice (x = 2.5), quindi converge alla radice maggiore
tol = 1e-8;                 % Tolleranza sullo scarto
itmax = 100;                % Numero massimo di iterazioni

% --- Punto a: grafico della funzione per scegliere il punto iniziale ---
figure(1);
% 1. Disegno la funzione f(x)
fplot(f, [xmin xmax], 'b-', 'LineWidth', 1.5);
hold on;  % Mantengo la figura per aggiungere l'asse x

% 2. Disegno l'asse x
plot([xmin xmax], [0 0], 'k-', 'LineWidth', 1.5);
hold off;

% 3. Aggiungo titolo, etichette e griglia
title('f(x) = x^2 - 5x + 6');
xlabel('x');
ylabel('f(x)');
grid on;

% --- Punto b: metodo di Newton ---
[xN, iterN, scartiN] = newton(f, df, x0, tol, itmax);

% Calcolo l'errore relativo rispetto alla radice esatta 3 (x^2 - 5x + 6 = (x-2)(x-3))
errrel = abs(xN - 3) / 3;

% Stampo i risultati in colonne (al passo 1 c'è solo x0, quindi nessuno scarto)
fprintf('Metodo di Newton per la radice maggiore di x^2 - 5x + 6 (x0 = %g) \n\n', x0);
fprintf('%5s %22s %14s %14s \n', 'k', 'x_k', 'scarto s_k', 'err. rel.');
fprintf('%5d %22.15f %14s %14.2e \n', 1, xN(1), '-', errrel(1));
for k = 2:iterN+1
    fprintf('%5d %22.15f %14.2e %14.2e \n', k, xN(k), scartiN(k-1), errrel(k));
end

% --- Punto c: profilo di convergenza ---
figure(2);
% 1. Disegno il valore assoluto degli scarti in scala semilogaritmica
semilogy(1:iterN, abs(scartiN), 'm-*', 'LineWidth', 1.5);

% 2. Aggiungo titolo, etichette, legenda e griglia
title('Profilo di convergenza del metodo di Newton (f(x) = x^2 - 5x + 6)');
xlabel('N. iterazioni');
ylabel('|scarto|');
legend('Newton');
grid on;