% ---- Definizione della funzione e dell'intervallo ----

f = @(x) x .* exp(x) - 1;   % Funzione da risolvere
a = 0;                      % Estremo inferiore per il grafico
b = 1;                      % Estremo superiore per il grafico

% --- Parametri di input ---
toll = 1e-10;   % Tolleranza
nmax = 50;      % Numero massimo di iterazioni
x0 = 0.5;       % Punto iniziale


% --- Grafico della funzione ---
figure(1);
fplot(f, [a b], 'b-', 'LineWidth', 1.5);
hold on;
plot([a b], [0 0], 'k-');   % Disegno l'asse x
hold off;
title('Funzione f(x) = x \cdot e^x - 1');
xlabel('asse x');
ylabel('asse y');
grid on;                   % Aggiungo la griglia 


% --- Chiamata alla function steffensen ---
[xv, scartiv, iter] = steffensen(f, x0, toll, nmax);


% --- Stampa a video dei risultati ---
fprintf('\n--- METODO DI STEFFENSEN ---\n');
fprintf('Radice trovata: %10.15f\n', xv(end));
fprintf('Numero di iterazioni: %d\n\n', iter);


% --- Grafico del profilo di convergenza ---
figure(2);
semilogy(1:iter, abs(scartiv), 'm-*', 'LineWidth', 1.5);
title('Profilo di convergenza del metodo di Steffensen');
xlabel('Iterazioni');
ylabel('Scarto assoluto');
grid on;


% --- Stima dell'ordine di convergenza e costante asintotica ---

% 1. Calcolo la radice "esatta" con fzero per avere l'errore vero
alpha = fzero(f, x0); 

% 2. Calcolo gli errori e_k = |x_k - alpha|
e = abs(xv - alpha);

% 3. Stima di p e C (usiamo gli ultimi 3 errori)
if iter >= 3
    % Formula per l'ordine di convergenza p basata sugli ERRORI
    p_stimato = log(e(end) / e(end-1)) / log(e(end-1) / e(end-2));

    % Formula per la costante asintotica C
    C_stimato = e(end) / (e(end-1) ^ p_stimato);

    % Stampo tutto
    fprintf('--- STIMA SPERIMENTALE ---\n');
    fprintf('Ordine di convergenza (p): %.4f\n', p_stimato);
    fprintf('Costante asintotica (C):  %.4f\n', C_stimato);
else
    fprintf('Iterazioni insufficienti per stimare p e C.\n');
end
fprintf('\n');







