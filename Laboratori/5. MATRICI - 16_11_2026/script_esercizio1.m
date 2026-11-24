% ==== ESERCIZIO 1: matrice 2x3 con i primi sei interi, azzero A(1,1) e A(2,2) (slide 3) ====
clear; clc;

%% Parametri di input
nr = 2;                              % Numero di righe
nc = 3;                              % Numero di colonne
pos_zero = [1 1; 2 2];               % Posizioni (riga, colonna) da azzerare

% Formato di stampa: una riga della matrice per volta, colonne allineate
fmt = @(M) [repmat('%6g ', 1, size(M, 2)), '\n'];

%% Punto a: costruisco la matrice 2x3 con i numeri da 1 a 6
A = [1 2 3; 4 5 6];                  % 1. Scrivo la matrice riga per riga
fprintf('--- Punto a: A ---\n');
fprintf(fmt(A), A');

A_alt = reshape(1:nr*nc, nc, nr)';   % 2. Alternativa: reshape riempie per colonne, quindi traspongo
fprintf('\nCon reshape(1:%d, %d, %d)'':\n', nr*nc, nc, nr);
fprintf(fmt(A_alt), A_alt');
fprintf('Le due matrici sono uguali? %d  (1 = si, 0 = no)\n', isequal(A, A_alt));

%% Punto b: azzero gli elementi A(1,1) e A(2,2)
for k = 1:size(pos_zero, 1)
    A(pos_zero(k, 1), pos_zero(k, 2)) = 0;   % Azzero l'elemento in posizione (riga, colonna)
end
fprintf('\n--- Punto b: A dopo aver azzerato A(1,1) e A(2,2) ---\n');
fprintf(fmt(A), A');