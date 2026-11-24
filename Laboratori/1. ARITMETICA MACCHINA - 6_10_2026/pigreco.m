% ==========================================
% ESERCIZIO: Calcolo di Pi Greco
% ==========================================


% METODO 1:

clear; clc  % Pulisce la memoria e la schermata (ottima abitudine)

% Iniziallizzo i primi valori dei vettori s e u
s(1) = 1;
u(1) = 1;

s(2) = 1.25;
u(2) = s(2);

% Faccio partire il ciclo da n=2 fino a 40
for n = 2:40
    % Calcolo il termine successivo per s e u
    s(n+1) = s(n) + (n+1)^(-2);
    u(n+1) = sqrt(6 * s(n+1));

    % Stampo a schermo l'indice e l'errore relativo a ogni iterazione
    fprintf('\n \t [SEQ.1][INDEX]: %3.0f', n+1);
    fprintf(' [REL.ERR]: %2.2e', abs(u(n+1)-pi)/pi);
end

% Calcolo l'errore relativo finale su tutto il vettore per il grafico
rel_err_u = abs(u-pi)/pi;

% Vado a capo per staccare i risultati dal metodo successivo
fprintf('\n');


% METODO 2:
format long % Mostra i numeri con la massima precisione

% Inizializzo i primi due valori di z
z(1) = 1; 
z(2) = 2;

% Ciclo da 2 a 40
for n = 2:40
    % Spezzo la formula in parti per renderla più leggibile
    c = (4^(1-n)) * (z(n))^2; 
    inner_sqrt = sqrt(1-c);

    % Calcolo il termine successivo z(n+1)
    z(n+1) = (2^(n-0.5)) * sqrt(1 - inner_sqrt);

    % Stampo a schermo l'avanzamento
    fprintf('\n \t [SEQ.2][N]: %3.0f', n+1);
    fprintf(' [REL.ERR]: %2.2e', abs(z(n+1)-pi)/pi);
end

% Calcolo l'errore relativo finale su tutto il vettore z
rel_err_z = abs(z-pi)/pi;

% Vado a capo
fprintf('\n');


% METODO 3.
% Inizializzo i primi due valori di y
y(1) = 1; 
y(2) = 2;

% Ciclo da 2 a 40
for n = 2:40
    % Formula razionalizzata: 1 + sqrt(1-c) al denominatore evita la cancellazione di 1 - sqrt(1-c)
    num = (2^(1/2)) * abs(y(n)); 
    c = (4^(1-n)) * (y(n))^2;
    inner_sqrt = sqrt(1-c);
    den = sqrt(1 + inner_sqrt);

    % Calcolo il termine successivo y(n+1)
    y(n+1) = num / den;

    % Stampo a schermo l'avanzamento
    fprintf('\n \t [SEQ.3][N]: %3.0f', n+1);
    fprintf(' [REL.ERR]: %2.2e', abs(y(n+1)-pi)/pi);
end

% Vado a capo
fprintf('\n');

% Calcolo l'errore relativo finale su tutto il vettore y
rel_err_y = abs(y-pi)/pi;


% --- Grafico semilogaritmico degli errori relativi ---
figure;
% 1. Disegno l'errore relativo della prima successione (punti neri)
semilogy(1:length(u), rel_err_u, 'k.', 'LineWidth', 1.5);
hold on;  % Mantengo la figura per aggiungere le altre curve

% 2. Disegno la seconda (croci magenta) e la terza successione (cerchi rossi)
semilogy(1:length(z), rel_err_z, 'm+', 'LineWidth', 1.5);
semilogy(1:length(y), rel_err_y, 'ro', 'LineWidth', 1.5);
hold off;

% 3. Aggiungo titolo, etichette, legenda e griglia
title('Errore relativo delle tre successioni rispetto a \pi');
xlabel('n');
ylabel('Errore relativo');
legend('u_n (metodo 1)', 'z_n (metodo 2)', 'y_n (metodo 3)', 'Location', 'southwest');
grid on;

