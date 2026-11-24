% ==== ESERCIZIO 2: determinante e inversa della matrice ones(4) (slide 6, soluzione slide 7) ====
clear; clc;

%% Parametri di input
n = 4;                               % Ordine della matrice

% Formato di stampa: una riga della matrice per volta, colonne allineate
fmt = @(M) [repmat('%6g ', 1, size(M, 2)), '\n'];

%% Punto a: costruisco A = ones(n) e calcolo il determinante
A = ones(n);                         % 1. Matrice n x n con tutti gli elementi uguali a 1
fprintf('--- Punto a: A = ones(%d) ---\n', n);
fprintf(fmt(A), A');

dA = det(A);                         % 2. Calcolo il determinante
fprintf('\ndet(A) = %g\n', dA);

%% Perche' A e' singolare (non nel PDF): rango, rcond, autovalori
fprintf('\n--- Perche'' A e'' singolare ---\n');
fprintf('rank(A)  = %d   (su %d righe)\n', rank(A), n);
fprintf('rcond(A) = %g\n', rcond(A));
autoval = eig(A);                    % Autovalori di A
fprintf('eig(A):\n');
fprintf('%22.15e\n', autoval);

%% Punto b: provo a calcolare l'inversa
fprintf('\n--- Punto b: inv(A) ---\n');
Ainv = inv(A);                       % MATLAB stampa un warning: A e' singolare
fprintf(fmt(Ainv), Ainv');