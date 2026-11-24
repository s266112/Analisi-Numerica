% ==========================================
% ESERCIZIO: Calcolo di sqrt(2) come zero di f(x) = x^2 - 2 con il metodo di bisezione
% ==========================================

clear; clc;  % Pulisco workspace e command window

% --- Parametri di input ---
f = @(x) x.^2 - 2;    % Funzione di cui cerco lo zero
a = 1; b = 2;         % Intervallo iniziale: f(1) = -1 < 0, f(2) = 2 > 0
tolres = 1e-15;       % Tolleranza sul residuo pesato
tolintv = 1e-15;      % Tolleranza sulla semilunghezza dell'intervallo
maxit = 100;          % Numero massimo di iterazioni

% --- Punto a: metodo di bisezione ---
[c, iter, sl, wr] = bisezione(a, b, tolintv, tolres, maxit, f);

% Calcolo l'errore relativo rispetto alla soluzione esatta sqrt(2)
errrel = abs(c - sqrt(2)) / sqrt(2);

% --- Stampa dei risultati ---
fprintf('Metodo di bisezione per sqrt(2) \n\n');
fprintf('%5s %22s %12s %12s %12s \n', 'k', 'c_k', 'semilung.', 'res. pesato', 'err. rel.');
fprintf('%5d %22.15f %12.2e %12.2e %12.2e \n', [(1:iter)', c, sl, wr, errrel]');