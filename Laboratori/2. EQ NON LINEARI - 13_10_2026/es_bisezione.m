% ==========================================
% ESERCIZIO: Risolvere 5x = exp(-x) con il metodo di bisezione
% ==========================================

clear; clc;  % Pulisco workspace e command window

% --- Parametri di input ---
f = @(x) 5*x - exp(-x);   % Riscrivo l'equazione nella forma f(x) = 0
xmin = -1; xmax = 1;      % Intervallo per il grafico
a = 0; b = 0.5;           % Intervallo iniziale scelto dal grafico: f(0) < 0, f(0.5) > 0
tolintv = 1e-8;           % Tolleranza sulla semilunghezza dell'intervallo
tolres = 1e-8;            % Tolleranza sul residuo pesato
maxit = 100;              % Numero massimo di iterazioni

% --- Punto a: grafico della funzione per localizzare la radice ---
figure(1);
% 1. Disegno la funzione f(x)
fplot(f, [xmin xmax], 'b-', 'LineWidth', 1.5);
hold on;  % Mantengo la figura per aggiungere l'asse x

% 2. Disegno l'asse x
plot([xmin xmax], [0 0], 'k-', 'LineWidth', 1.5);
hold off;

% 3. Aggiungo titolo, etichette e griglia
title('f(x) = 5x - e^{-x}');
xlabel('x');
ylabel('f(x)');
grid on;

% --- Punto b: metodo di bisezione ---
[c, iter, sl, wr] = bisezione(a, b, tolintv, tolres, maxit, f);

% Stampo i risultati in colonne
fprintf('Metodo di bisezione per 5x = exp(-x) in [%g, %g] \n\n', a, b);
fprintf('%5s %22s %12s %12s \n', 'k', 'c_k', 'semilung.', 'res. pesato');
fprintf('%5d %22.15f %12.2e %12.2e \n', [(1:iter)', c, sl, wr]');

% --- Punto c: confronto con il numero di iterazioni stimato ---
nstima = ceil(log2((b - a) / tolintv)) - 1;   % Stima della slide 12, con eps = tolintv

fprintf('\n%-45s %18.15f \n', 'Soluzione approssimata:', c(end));
fprintf('%-45s %18d \n', 'Iterazioni eseguite:', iter);
fprintf('%-45s %18d \n', 'Iterazioni stimate ceil(log2((b-a)/eps))-1:', nstima);

% --- Punto d: profilo di convergenza ---
figure(2);

% 1. Disegno i residui pesati in scala semilogaritmica
semilogy(1:iter, abs(wr), 'm-*', 'LineWidth', 1.5);

% 2. Aggiungo titolo, etichette, legenda e griglia
title('Profilo di convergenza Bisezione (caso f(x) = 5x - e^{-x})');
xlabel('N. iterazioni');
ylabel('residuo pesato');
legend('bisezione');
grid on;


% --- Salvataggio del grafico per il README ---
cartella = fullfile(fileparts(mfilename('fullpath')), 'img');                          % Cartella img accanto allo script
if ~exist(cartella, 'dir'), mkdir(cartella); end                                        % La creo se non esiste
exportgraphics(figure(2), fullfile(cartella, 'es_bisezione.png'), 'Resolution', 150);   % Salvo il profilo di convergenza
