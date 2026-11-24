% ==========================================
% ESERCIZIO: Calcolo di sqrt(2) come zero positivo di f(x) = x^2 - 2 con il metodo di Newton
% ==========================================

clear; clc;  % Pulisco workspace e command window

% --- Parametri di input ---
f  = @(x) x.^2 - 2;    % Funzione di cui cerco lo zero
df = @(x) 2*x;         % Derivata prima di f
a = -2; b = 2;         % Intervallo per il grafico
x0 = 1;                % Punto iniziale (slide 19)
tol = 1e-8;            % Tolleranza sullo scarto
maxit = 100;           % Numero massimo di iterazioni

% --- Punto a: grafico della funzione ---
figure(1);
% 1. Disegno la funzione f(x) nell'intervallo [a, b]
fplot(f, [a b], 'b-', 'LineWidth', 1.5);
hold on;  % Mantengo la figura per aggiungere l'asse x

% 2. Disegno l'asse x
plot([a b], [0 0], 'k-', 'LineWidth', 1.5);
hold off;

% 3. Aggiungo titolo, etichette e griglia
title('f(x) = x^2 - 2');
xlabel('x');
ylabel('f(x)');
grid on;

% --- Punto b: metodo di Newton ---
[xN, iterN, scartiN] = newton(f, df, x0, tol, maxit);

% Calcolo l'errore relativo rispetto alla soluzione esatta sqrt(2)
errrel = abs(xN - sqrt(2)) / sqrt(2);

% Stampo i risultati in colonne (al passo 1 c'è solo x0, quindi nessuno scarto)
fprintf('Metodo di Newton per sqrt(2) \n\n');
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
title('Profilo di convergenza del metodo di Newton (f(x) = x^2 - 2)');
xlabel('N. iterazioni');
ylabel('|scarto|');
legend('Newton');
grid on;