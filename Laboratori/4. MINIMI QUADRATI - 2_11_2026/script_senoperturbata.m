% ==========================================
% ESERCIZIO: Minimi quadrati e filtraggio del rumore: ricostruzione di sin(2x) da dati perturbati
% ==========================================

clear; clc;  % Pulisco workspace e command window

% --- Parametri di input ---
N = 1000;                    % Numero di punti di campionamento
x = linspace(0, 2*pi, N);    % Nodi equispaziati in [0, 2pi]
sigma = 1e-1;                % Ampiezza del rumore
gradi = 1:2:9;               % Gradi dei polinomi ai minimi quadrati
rng(0);                      % Fisso il generatore casuale: stesso rumore a ogni esecuzione

% --- Punto a: dati esatti e dati perturbati ---
ysin = sin(2*x);                             % Valori esatti di sin(2x)
ysinpert = ysin + sigma * randn(size(x));    % Valori perturbati con rumore gaussiano

% Inizializzo le variabili
ng = length(gradi);      % Numero di gradi da provare
err2 = zeros(1, ng);     % Errori in norma 2 rispetto a sin(2x)
err2p = zeros(1, ng);    % Errori in norma 2 rispetto ai dati perturbati
errinf = zeros(1, ng);   % Errori in norma infinito rispetto a sin(2x)
errinfp = zeros(1, ng);  % Errori in norma infinito rispetto ai dati perturbati

% --- Punto b: polinomi ai minimi quadrati di grado 1, 3, 5, 7, 9 ---
figure(1);
set(gcf, 'Position', [100 100 1000 850]);   % Ingrandisco la finestra per i 6 riquadri

for k = 1:ng
    n = gradi(k);   % Grado corrente

    % 1. Calcolo il polinomio ai minimi quadrati sui dati perturbati e lo valuto nei nodi
    coeff = polyfit(x, ysinpert, n);
    z = polyval(coeff, x);

    % 2. Calcolo gli errori in norma 2 e in norma infinito
    err2(k) = norm(z - ysin, 2);
    err2p(k) = norm(z - ysinpert, 2);
    errinf(k) = norm(z - ysin, inf);
    errinfp(k) = norm(z - ysinpert, inf);

    % 3. Disegno dati perturbati, funzione esatta e polinomio nel k-esimo riquadro
    subplot(3, 2, k);
    plot(x, ysinpert, 'r.', 'MarkerSize', 4);
    hold on;
    plot(x, ysin, 'g-', 'LineWidth', 1.5);
    plot(x, z, 'k-', 'LineWidth', 1.5);
    hold off;
    title(sprintf('Grado %d', n));
    xlabel('x');
    ylabel('y');
    xlim([0 2*pi]);
    grid on;
    if k == 1
        legend('dati perturbati', 'sin(2x)', 'polinomio MQ', 'Location', 'southwest');
    end

    pause(2);   % Pausa per vedere i riquadri comparire uno alla volta
end

% --- Punto c: errori in funzione del grado (sesto riquadro) ---
subplot(3, 2, 6);
% 1. Disegno gli errori in norma 2 rispetto alla funzione esatta e ai dati perturbati
semilogy(gradi, err2, 'b-o', 'LineWidth', 1.5);
hold on;
semilogy(gradi, err2p, 'm-*', 'LineWidth', 1.5);

% 2. Disegno il livello del rumore (norma 2 della perturbazione)
semilogy(gradi, norm(ysinpert - ysin) * ones(size(gradi)), 'k--', 'LineWidth', 1.5);
hold off;

% 3. Aggiungo titolo, etichette, legenda e griglia
title('Errori in norma 2');
xlabel('grado');
ylabel('errore');
legend('rispetto a sin(2x)', 'rispetto ai dati', 'livello del rumore', 'Location', 'southwest');
grid on;

% --- Stampa dei risultati ---
fprintf('Ricostruzione di sin(2x) da %d dati perturbati (sigma = %g) \n\n', N, sigma);
fprintf('%6s %16s %16s %16s %16s \n', 'grado', 'norma2 vs sin', 'norma2 vs dati', 'normaInf vs sin', 'normaInf vs dati');
fprintf('%6d %16.2e %16.2e %16.2e %16.2e \n', [gradi; err2; err2p; errinf; errinfp]);
fprintf('\nNorma 2 del rumore ||ysinpert - ysin||: %.2e \n', norm(ysinpert - ysin));

% --- Salvataggio del grafico per il README ---
cartella = fullfile(fileparts(mfilename('fullpath')), 'img');                            % Cartella img accanto allo script
if ~exist(cartella, 'dir'), mkdir(cartella); end                                          % La creo se non esiste
exportgraphics(figure(1), fullfile(cartella, 'senoperturbata.png'), 'Resolution', 150);   % Salvo la figura con i 6 riquadri

