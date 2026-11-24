% ==== ESEMPI: comandi predefiniti e operazioni tra matrici (slide 6, 8, 9) ====
clear; clc;

%% Parametri di input
n = 3;                               % Ordine delle matrici generate (slide 6)
m_rand = 2;                          % Righe della matrice random
n_rand = 3;                          % Colonne della matrice random
A8 = [2 -1; 3 4; -2 7];              % Matrice della slide 8
s  = 2;                              % Scalare per s*A (scelto da me, la slide non lo indica)
A  = [4 -1 0; -1 4 -1; 0 -1 4];      % Matrice A della slide 9
B  = [1 2 3; -4 -5 -6; 0 1 2];       % Matrice B della slide 9
rng(0);                              % Fisso il generatore per rand (risultati riproducibili)

% Formato di stampa: una riga della matrice per volta, colonne allineate
fmt  = @(M) [repmat('%6g ', 1, size(M, 2)), '\n'];       % Per numeri interi
fmtd = @(M) [repmat('%10.4f ', 1, size(M, 2)), '\n'];    % Per numeri decimali

%% Slide 6: comandi che generano matrici
R = rand(m_rand, n_rand);            % 1. Matrice random m x n
fprintf('--- Slide 6: rand(%d,%d) ---\n', m_rand, n_rand);
fprintf(fmtd(R), R');

I = eye(n);                          % 2. Identita' di ordine n
fprintf('\neye(%d):\n', n);
fprintf(fmt(I), I');

U = ones(n);                         % 3. Matrice di tutti 1
fprintf('\nones(%d):\n', n);
fprintf(fmt(U), U');

Z = zeros(n);                        % 4. Matrice di tutti 0
fprintf('\nzeros(%d):\n', n);
fprintf(fmt(Z), Z');

%% Slide 6: size, det, inv, eig (sulla matrice A della slide 9)
[nr, nc] = size(A);                  % 1. Numero di righe e colonne
fprintf('\n--- Slide 6: comandi su A ---\n');
fprintf('size(A): %d righe, %d colonne\n', nr, nc);

dA = det(A);                         % 2. Determinante
fprintf('det(A) = %g\n', dA);

Ainv = inv(A);                       % 3. Inversa
fprintf('\ninv(A):\n');
fprintf(fmtd(Ainv), Ainv');

autoval = eig(A);                    % 4. Autovalori
fprintf('\neig(A):\n');
fprintf('%10.4f\n', autoval);

%% Slide 8: prodotto per uno scalare e trasposta
fprintf('\n--- Slide 8: A8 (3x2) ---\n');
fprintf(fmt(A8), A8');

C = s * A8;                          % 1. Prodotto per lo scalare s
fprintf('\n%g*A8:\n', s);
fprintf(fmt(C), C');

C = A8';                             % 2. Trasposta: da 3x2 diventa 2x3
fprintf('\nA8'' (2x3):\n');
fprintf(fmt(C), C');

%% Slide 9: somma, sottrazione, prodotto e prodotto componente a componente
C = A + B;                           % 1. Somma
fprintf('\n--- Slide 9 ---\nA + B:\n');
fprintf(fmt(C), C');

C = A - B;                           % 2. Sottrazione (elencata nella slide 8)
fprintf('\nA - B:\n');
fprintf(fmt(C), C');

C = A * B;                           % 3. Prodotto riga per colonna
fprintf('\nA * B:\n');
fprintf(fmt(C), C');

C = A .* B;                          % 4. Prodotto componente a componente
fprintf('\nA .* B:\n');
fprintf(fmt(C), C');