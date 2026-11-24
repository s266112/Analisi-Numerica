% ==========================================
% ESERCIZIO PROPOSTO: Biomeccanica - legame sforzo/deformazione di un disco intervertebrale
% ==========================================

clear; clc;  % Pulisco workspace e command window

% --- Parametri di input ---
sigma = [0 0.06 0.14 0.25 0.31 0.47 0.60];   % Sforzo (MPa)
defo  = [0 0.08 0.14 0.20 0.23 0.25 0.28];   % Deformazione corrispondente
sstima = 0.7;                                % Sforzo in cui voglio stimare la deformazione (MPa)
dvero = 0.29;                                % Deformazione osservata per sigma = 0.7
xx = linspace(0, sstima, 200);               % Punti fitti per disegnare i polinomi fino a 0.7

% --- Punto 1: retta ai minimi quadrati (grado 1) ---
a1 = polyfit(sigma, defo, 1);                % Coefficienti della retta
yy1 = polyval(a1, xx);                       % Valori della retta sui punti del grafico
err1 = norm(polyval(a1, sigma) - defo);      % Radice della somma dei quadrati degli scarti nei dati
stima1 = polyval(a1, sstima);                % Stima di eps(0.7) con la retta

% --- Punto 2: parabola ai minimi quadrati (grado 2) ---
a2 = polyfit(sigma, defo, 2);                % Coefficienti della parabola
yy2 = polyval(a2, xx);                       % Valori della parabola sui punti del grafico
err2 = norm(polyval(a2, sigma) - defo);      % Radice della somma dei quadrati degli scarti nei dati
stima2 = polyval(a2, sstima);                % Stima di eps(0.7) con la parabola

% --- Punto 3: confronto e stampa dei risultati ---
fprintf('Biomeccanica: stima della deformazione per sigma = %g MPa (valore osservato: %g) \n\n', sstima, dvero);
fprintf('Retta:    eps(sigma) = %.4f*sigma + %.4f \n', a1);
fprintf('Parabola: eps(sigma) = %.4f*sigma^2 + %.4f*sigma + %.4f \n\n', a2);

fprintf('%-20s %20s %14s %18s \n', 'Polinomio MQ', 'Errore nei dati', 'eps(0.7)', 'Scarto da 0.29');
fprintf('%-20s %20.4f %14.4f %18.4f \n', 'Retta (grado 1)', err1, stima1, abs(stima1 - dvero));
fprintf('%-20s %20.4f %14.4f %18.4f \n', 'Parabola (grado 2)', err2, stima2, abs(stima2 - dvero));

% --- Grafico ---
figure(1);
% 1. Disegno i punti sperimentali
plot(sigma, defo, 'bo', 'MarkerSize', 6, 'LineWidth', 1.5);
hold on;  % Mantengo la figura per aggiungere le altre curve

% 2. Disegno la retta e la parabola ai minimi quadrati
plot(xx, yy1, 'b-', 'LineWidth', 1.5);
plot(xx, yy2, 'r-', 'LineWidth', 1.5);

% 3. Disegno il valore osservato (0.7, 0.29)
plot(sstima, dvero, 'g*', 'MarkerSize', 10, 'LineWidth', 1.5);
hold off;

% 4. Aggiungo titolo, etichette, legenda e griglia
title('Biomeccanica: approssimazione ai minimi quadrati');
xlabel('\sigma (MPa)');
ylabel('\epsilon');
legend('punti', 'retta', 'parabola', 'valore vero', 'Location', 'northwest');
grid on;

% --- Salvataggio del grafico per il README ---
cartella = fullfile(fileparts(mfilename('fullpath')), 'img');                         % Cartella img accanto allo script
if ~exist(cartella, 'dir'), mkdir(cartella); end                                       % La creo se non esiste
exportgraphics(figure(1), fullfile(cartella, 'biomeccanica.png'), 'Resolution', 150);  % Salvo il grafico