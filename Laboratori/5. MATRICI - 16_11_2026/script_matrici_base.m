% ==== ESEMPI: definizione, accesso ed estrazione di parti di una matrice (slide 2, 4, 5) ====
clear; clc;

%% Parametri di input
A1 = [1 2 3; 4 5 6; 7 8 9];          % Matrice della slide 2
A  = [1 1 1; -2 3 1; 4 -6 7];        % Matrice delle slide 4 e 5
riga = 2;                            % Riga da estrarre (slide 4)
colonna = 3;                         % Colonna da estrarre (slide 4)

% Formato di stampa: una riga della matrice per volta, colonne allineate
fmt = @(M) [repmat('%6g ', 1, size(M, 2)), '\n'];

%% Slide 2: definizione di una matrice e accesso a un elemento
fprintf('--- Slide 2: A1 = [1 2 3; 4 5 6; 7 8 9] ---\n');
fprintf(fmt(A1), A1');
fprintf('A1(2,3) = %d\n\n', A1(2, 3));

%% Slide 4: estrarre righe, colonne e sottomatrici con i due punti
fprintf('--- Slide 4: A ---\n');
fprintf(fmt(A), A');

fprintf('\nA(%d,:)  (riga %d):\n', riga, riga);
fprintf(fmt(A(riga, :)), A(riga, :)');

fprintf('\nA(:,%d)  (colonna %d):\n', colonna, colonna);
fprintf('%6g\n', A(:, colonna));

M = A(2:3, :);                       % Sottomatrice: righe 2 e 3, tutte le colonne
fprintf('\nM = A(2:3,:):\n');
fprintf(fmt(M), M');

%% Slide 5: MATLAB allarga la matrice quanto basta
B = A;                               % Lavoro su una copia per non perdere A
B(5, 5) = 2;                         % 1. Assegno un elemento fuori dalle dimensioni
fprintf('\n--- Slide 5: B(5,5) = 2  ->  B e'' %dx%d ---\n', size(B, 1), size(B, 2));
fprintf(fmt(B), B');

B = B(1:3, 1:3);                     % 2. Torno alla matrice 3x3 originale
fprintf('\nB = B(1:3,1:3):\n');
fprintf(fmt(B), B');

B(3, 6) = 9;                         % 3. Allargo solo le colonne
fprintf('\nB(3,6) = 9  ->  B e'' %dx%d:\n', size(B, 1), size(B, 2));
fprintf(fmt(B), B');