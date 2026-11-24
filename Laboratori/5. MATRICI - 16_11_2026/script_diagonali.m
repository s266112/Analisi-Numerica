% ==== ESEMPI: diagonali, parti triangolari e matrici diagonali (slide 10-13) ====
clear; clc;

%% Parametri di input
A = [1 2 3 4; 2 3 5 7; 3 3 4 8; 0 -1 2 3];   % Matrice delle slide 10, 11, 13
v = [-1 -2 5 9];                             % Vettore della slide 12 (diagonale principale)
w = [-1 -2 -3];                              % Vettore della slide 12 (sottodiagonale)
k_sotto = -1;                                % Prima sottodiagonale
k_sopra = 2;                                 % Seconda sopradiagonale

% Formato di stampa: una riga della matrice per volta, colonne allineate
fmt = @(M) [repmat('%6g ', 1, size(M, 2)), '\n'];

fprintf('--- Matrice A (slide 10) ---\n');
fprintf(fmt(A), A');

%% Slide 10: estrazione di diagonali con diag
d0 = diag(A);                        % 1. Diagonale principale
fprintf('\n--- Slide 10 ---\ndiag(A):\n');
fprintf('%6g\n', d0);

d1 = diag(A, k_sotto);               % 2. Prima sottodiagonale
fprintf('\ndiag(A,%d):\n', k_sotto);
fprintf('%6g\n', d1);

d2 = diag(A, k_sopra);               % 3. Seconda sopradiagonale
fprintf('\ndiag(A,%d):\n', k_sopra);
fprintf('%6g\n', d2);

%% Slide 11: parte triangolare inferiore (tril) e superiore (triu)
L = tril(A);                         % 1. Triangolare inferiore, diagonale compresa
fprintf('\n--- Slide 11 ---\ntril(A):\n');
fprintf(fmt(L), L');

L1 = tril(A, k_sotto);               % 2. Triangolare inferiore, senza la diagonale
fprintf('\ntril(A,%d):\n', k_sotto);
fprintf(fmt(L1), L1');

U = triu(A);                         % 3. Triangolare superiore, diagonale compresa
fprintf('\ntriu(A):\n');
fprintf(fmt(U), U');

%% Slide 12: matrice diagonale a partire da un vettore
D = diag(v);                         % 1. v sulla diagonale principale
fprintf('\n--- Slide 12 ---\ndiag(v):\n');
fprintf(fmt(D), D');

D = diag(w, k_sotto);                % 2. w sulla prima sottodiagonale (matrice 4x4)
fprintf('\ndiag(w,%d):\n', k_sotto);
fprintf(fmt(D), D');

%% Slide 13: matrice diagonale con la diagonale di A
D = diag(diag(A));                   % diag interno: vettore; diag esterno: matrice
fprintf('\n--- Slide 13 ---\ndiag(diag(A)):\n');
fprintf(fmt(D), D');