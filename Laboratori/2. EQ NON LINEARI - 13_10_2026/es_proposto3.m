% ==========================================
% ESERCIZIO PROPOSTO 3: Zero di f(x) = x*log(x) - 1 (x > 0) con bisezione e Newton
% ==========================================

clear; clc;  % Pulisco workspace e command window

% --- Parametri di input ---
f  = @(x) x.*log(x) - 1;         % Funzione di cui cerco lo zero (definita per x > 0)
df = @(x) log(x) + 1;            % Derivata prima di f (si annulla in x = 1/e)
xmin = 0.1; xmax = 3;            % Intervallo per il grafico (solo x > 0)
a = 1; b = 2;                    % Intervallo per la bisezione: f(1) < 0, f(2) > 0
x0 = 2;                          % Punto iniziale per Newton: f(x0)*f''(x0) > 0
tol = 1e-8;                      % Tolleranza (per entrambi i metodi)
maxit = 100;                     % Numero massimo di iterazioni
nomefile = 'risultati_esproposto3.txt';   % File in cui salvo i risultati

% --- Punto 1: grafico della funzione per scegliere [a, b] e x0 ---
figure(1);
    % 1. Disegno la funzione f(x)
    fplot(f, [xmin xmax], 'b-', 'LineWidth', 1.5);
    hold on;  % Mantengo la figura per aggiungere l'asse x

    % 2. Disegno l'asse x
    plot([xmin xmax], [0 0], 'k-', 'LineWidth', 1.5);
    hold off;

    % 3. Aggiungo titolo, etichette e griglia
    title('f(x) = x log(x) - 1');
    xlabel('x');
    ylabel('f(x)');
    grid on;

% --- Punto 2: bisezione e Newton ---
[cB, iterB, slB, wrB] = bisezione(a, b, tol, tol, maxit, f);
[xN, iterN, scartiN] = newton(f, df, x0, tol, maxit);
nstima = ceil(log2((b - a) / tol)) - 1;   % Iterazioni stimate per la bisezione

% --- N.B.: verifica numerica della convergenza di Newton per ogni x0 in [a, b] ---
% Inizializzo le variabili
x0test = linspace(a, b, 11);          % 11 punti iniziali equispaziati in [a, b]
itertest = zeros(size(x0test));       % Iterazioni impiegate per ogni x0
soltest = zeros(size(x0test));        % Soluzione trovata per ogni x0

for i = 1:length(x0test)
    % 1. Eseguo Newton partendo dall'i-esimo punto iniziale
    [xT, iterT] = newton(f, df, x0test(i), tol, maxit);

    % 2. Salvo il numero di iterazioni e la soluzione trovata
    itertest(i) = iterT;
    soltest(i) = xT(end);
end

% Controesempio: un x0 < 1/e manda la prima iterata fuori dal dominio x > 0
x0bad = 0.3;
x1bad = x0bad - f(x0bad) / df(x0bad);

% --- Punti 3 e 4: stampa ordinata a video e su file ---
fid = fopen(nomefile, 'wt');   % Apro il file in scrittura (modalità testo)
if fid == -1
    disp('Errore: impossibile aprire il file dei risultati');
    return;
end

for dest = [1, fid]   % 1 = Command Window, fid = file: scrivo lo stesso testo in entrambi
    % 1. Intestazione
    fprintf(dest, '=== Equazione 3: x*log(x) - 1 = 0, x > 0 ===\n\n');

    % 2. Tabella della bisezione
    fprintf(dest, 'Metodo di bisezione in [%g, %g] \n', a, b);
    fprintf(dest, '%5s %22s %12s %12s \n', 'k', 'c_k', 'semilung.', 'res. pesato');
    fprintf(dest, '%5d %22.15f %12.2e %12.2e \n', [(1:iterB)', cB, slB, wrB]');

    % 3. Tabella di Newton (al passo 1 c'è solo x0, quindi nessuno scarto)
    fprintf(dest, '\nMetodo di Newton (x0 = %g) \n', x0);
    fprintf(dest, '%5s %22s %14s \n', 'k', 'x_k', 'scarto s_k');
    fprintf(dest, '%5d %22.15f %14s \n', 1, xN(1), '-');
    for k = 2:iterN+1
        fprintf(dest, '%5d %22.15f %14.2e \n', k, xN(k), scartiN(k-1));
    end

    % 4. Riepilogo a confronto
    fprintf(dest, '\n%-35s %20s %20s \n', '', 'Bisezione', 'Newton');
    fprintf(dest, '%-35s %20.15f %20.15f \n', 'Soluzione approssimata:', cB(end), xN(end));
    fprintf(dest, '%-35s %20d %20d \n', 'Iterazioni eseguite:', iterB, iterN);
    fprintf(dest, '%-35s %20d %20s \n', 'Iterazioni stimate (bisezione):', nstima, '-');

    % 5. Verifica della convergenza di Newton per ogni x0 in [a, b]
    fprintf(dest, '\nNewton con x0 in [%g, %g]: \n', a, b);
    fprintf(dest, '%10s %12s %22s \n', 'x0', 'iterazioni', 'soluzione');
    fprintf(dest, '%10.2f %12d %22.15f \n', [x0test; itertest; soltest]);
    fprintf(dest, '\nControesempio: x0 = %g < 1/e  ->  x1 = %.4f (fuori dal dominio x > 0)\n\n', x0bad, x1bad);
end

fclose(fid);   % Chiudo il file
fprintf('Risultati salvati nel file %s\n', nomefile);

% --- Punto 3: profili di convergenza dei due metodi ---
figure(2);
    % 1. Disegno i residui pesati della bisezione
    semilogy(1:iterB, wrB, 'b-o', 'LineWidth', 1.5);
    hold on;  % Mantengo la figura per aggiungere Newton

    % 2. Disegno gli scarti di Newton
    semilogy(1:iterN, abs(scartiN), 'm-*', 'LineWidth', 1.5);
    hold off;

    % 3. Aggiungo titolo, etichette, legenda e griglia
    title('Profili di convergenza: f(x) = x log(x) - 1');
    xlabel('N. iterazioni');
    ylabel('residuo pesato / |scarto|');
    legend('Bisezione (residuo pesato)', 'Newton (scarto)');
    grid on;



    % --- Salvataggio dei grafici per il README ---
    cartella = fullfile(fileparts(mfilename('fullpath')), 'img');                           % Cartella img accanto allo script
    if ~exist(cartella, 'dir'), mkdir(cartella); end                                         % La creo se non esiste
    exportgraphics(figure(2), fullfile(cartella, 'esproposto3.png'), 'Resolution', 150);     % Salvo i profili di convergenza
    exportgraphics(figure(1), fullfile(cartella, 'esproposto3_f.png'), 'Resolution', 150);   % Salvo il grafico di f (minimo in 1/e)