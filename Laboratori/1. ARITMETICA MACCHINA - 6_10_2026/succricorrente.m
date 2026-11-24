% ==========================================
% ESERCIZIO: Successione ricorrente I_n = e^(-1) * int_0^1 x^n e^x dx
% ==========================================

clear; clc;  % Pulisco workspace e command window

% --- Parametri di input ---
N = 100;  % Numero di termini da calcolare (I_1, ..., I_100)
M = 200;  % Indice di partenza della successione all'indietro (I_200 = 0)

% --- Punto a: successione in avanti ---
% Inizializzo le variabili
s = zeros(1, N);   % Preallocazione del vettore della successione in avanti
s(1) = exp(-1);    % I_1 = 1 - 1*I_0 = 1 - (1 - e^-1) = e^-1

for n = 1:N-1
    % 1. Calcolo il termine successivo con I_(n+1) = 1 - (n+1) * I_n
    s(n+1) = 1 - (n+1) * s(n);
end

% --- Punto b: successione all'indietro ---
% Inizializzo le variabili
t = zeros(1, M);  % Preallocazione: così t(M) = I_200 = 0 è già impostato

for n = M:-1:2
    % 1. Calcolo il termine precedente con I_(n-1) = (1 - I_n) / n
    t(n-1) = (1 - t(n)) / n;
end

% --- Stampa dei risultati ---
% Confronto le due successioni sui primi 25 termini
fprintf('%5s %22s %22s %12s \n', 'n', 's(n) in avanti', 't(n) all''indietro', '|s - t|');
fprintf('%5d %22.10e %22.10e %12.2e \n', [1:25; s(1:25); t(1:25); abs(s(1:25) - t(1:25))]);

% Controllo: t(1) deve essere esattamente I_1 = e^(-1)
fprintf('\nErrore su I_1 all''indietro: |t(1) - exp(-1)| = %.2e \n', abs(t(1) - exp(-1)));

% --- Grafico semilogaritmico ---
figure;
% 1. Disegno i valori della successione in avanti (in valore assoluto: può essere negativa)
semilogy(1:N, abs(s), 'm-', 'LineWidth', 1.5);
hold on;  % Mantengo la figura per aggiungere la seconda curva

% 2. Disegno i valori della successione all'indietro (solo i primi N termini)
semilogy(1:N, abs(t(1:N)), 'k-', 'LineWidth', 1.5);
hold off;

% 3. Aggiungo titolo, etichette, legenda e griglia
title('Valori di I_n calcolati in avanti e all''indietro');
xlabel('n');
ylabel('|I_n|');
legend('in avanti', 'all''indietro', 'Location', 'northwest');
grid on;