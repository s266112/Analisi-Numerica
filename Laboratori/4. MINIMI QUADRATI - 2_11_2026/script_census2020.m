% ==========================================
% ESERCIZIO: Crescita della popolazione USA con i minimi quadrati (previsione per il 2020)
% ==========================================

clear; clc;  % Pulisco workspace e command window

% --- Parametri di input ---
x = 1900:10:2010;                     % Anni in cui sono state eseguite le misurazioni
y = [75.995 91.972 105.711 123.203 131.669 150.697 ...
    179.323 203.212 226.505 249.633 281.422 308.745];   % Abitanti (milioni)
xestrap = 2020;                       % Anno in cui voglio la previsione
yvero = 331.449;                      % Valore del censimento 2020 (milioni)
xx = linspace(x(1), xestrap, 200);    % Punti fitti per disegnare i polinomi fino al 2020

% --- Punto a: retta ai minimi quadrati (grado 1) ---
a1 = polyfit(x, y, 1);                % Coefficienti della retta
yy1 = polyval(a1, xx);                % Valori della retta sui punti del grafico
err1 = norm(polyval(a1, x) - y);      % Radice della somma degli scarti quadratici nei nodi
prev1 = polyval(a1, xestrap);         % Previsione per il 2020

% --- Punto b: parabola ai minimi quadrati (grado 2) ---
a2 = polyfit(x, y, 2);                % Coefficienti della parabola
yy2 = polyval(a2, xx);                % Valori della parabola sui punti del grafico
err2 = norm(polyval(a2, x) - y);      % Radice della somma degli scarti quadratici nei nodi
prev2 = polyval(a2, xestrap);         % Previsione per il 2020

% --- Punto c: confronto con il valore vero ---
errrel1 = abs(prev1 - yvero) / yvero;   % Errore relativo della previsione con la retta
errrel2 = abs(prev2 - yvero) / yvero;   % Errore relativo della previsione con la parabola

% Stampo i risultati in colonne
fprintf('Popolazione USA: previsione per il %d (valori in milioni) \n\n', xestrap);
fprintf('%-20s %18s %18s %18s \n', 'Polinomio MQ', 'Errore nei nodi', 'Previsione', 'Err. rel. prev.');
fprintf('%-20s %18.4f %18.4f %18.2e \n', 'Retta (grado 1)', err1, prev1, errrel1);
fprintf('%-20s %18.4f %18.4f %18.2e \n', 'Parabola (grado 2)', err2, prev2, errrel2);
fprintf('%-20s %18s %18.4f %18s \n', 'Censimento', '-', yvero, '-');

% --- Grafico ---
figure(1);
% 1. Disegno i dati del censimento
plot(x, y, 'mo', 'MarkerSize', 6, 'LineWidth', 1.5);
hold on;  % Mantengo la figura per aggiungere le altre curve

% 2. Disegno la retta e la parabola ai minimi quadrati
plot(xx, yy1, 'b-', 'LineWidth', 1.5);
plot(xx, yy2, 'r-', 'LineWidth', 1.5);

% 3. Disegno il valore vero del 2020
plot(xestrap, yvero, 'g*', 'MarkerSize', 10, 'LineWidth', 1.5);
hold off;

% 4. Aggiungo titolo, etichette, legenda e griglia
title('Popolazione USA: approssimazione ai minimi quadrati');
xlabel('Anno');
ylabel('Abitanti (milioni)');
legend('dati censimento', 'retta MQ', 'parabola MQ', 'valore vero 2020', 'Location', 'northwest');
grid on;

% --- Salvataggio del grafico per il README ---
cartella = fullfile(fileparts(mfilename('fullpath')), 'img');                       % Cartella img accanto allo script
if ~exist(cartella, 'dir'), mkdir(cartella); end                                     % La creo se non esiste
exportgraphics(figure(1), fullfile(cartella, 'census2020.png'), 'Resolution', 150);  % Salvo il grafico