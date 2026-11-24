% ==== ESEMPIO: soluzione di un sistema lineare con A\b (slide 14) ====
clear; clc;

%% Parametri di input
A = [10 -7 0; -3 2 6; 5 -1 5];       % Matrice dei coefficienti (slide 14)
b = [7; 4; 6];                       % Termine noto, vettore colonna (slide 14)

% Formato di stampa: una riga della matrice per volta, colonne allineate
fmt = @(M) [repmat('%6g ', 1, size(M, 2)), '\n'];

fprintf('--- Slide 14: sistema Ax = b ---\nA:\n');
fprintf(fmt(A), A');
fprintf('\nb:\n');
fprintf('%6g\n', b);

%% Slide 14: soluzione con backslash (Gauss con pivoting)
x = A \ b;                           % 1. Risolvo il sistema
r = b - A * x;                       % 2. Calcolo il residuo
fprintf('\nx = A\\b:\n');
fprintf('%22.15e\n', x);
fprintf('Norma del residuo ||b - A*x|| = %e\n', norm(r));

%% Confronto (non nel PDF): soluzione con l'inversa
x_inv = inv(A) * b;                  % 1. Risolvo con l'inversa
r_inv = b - A * x_inv;               % 2. Calcolo il residuo
fprintf('\nx = inv(A)*b:\n');
fprintf('%22.15e\n', x_inv);
fprintf('Norma del residuo ||b - A*x|| = %e\n', norm(r_inv));

%% Riepilogo finale
fprintf('\n%5s %22s %22s\n', 'k', 'x (A\b)', 'x (inv(A)*b)');
fprintf('%5d %22.15e %22.15e\n', [(1:length(x))', x, x_inv]');