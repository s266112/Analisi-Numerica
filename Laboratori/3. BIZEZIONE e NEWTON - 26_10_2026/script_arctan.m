% ==========================================
% ESERCIZIO: Soluzione di x = 1 + arctan(x) con il metodo di punto fisso
% ==========================================

clear; clc;  % Pulisco workspace e command window

% --- Parametri di input ---
g   = @(x) 1 + atan(x);                    % Funzione di iterazione
dg  = @(x) 1 ./ (1 + x.^2);                % Derivata prima di g (per la stima di C e la verifica)
bis = @(x) x;                              % Bisettrice y = x
xmin = -1; xmax = 4;                       % Intervallo per il grafico
a = 1; b = 3;                              % Intervallo scelto dal grafico: g([a, b]) dentro [a, b] e abs(g') <= 1/2
x0 = 2;                                    % Punto iniziale in [a, b], vicino all'intersezione
tol = 1e-12;                               % Tolleranza sullo scarto (slide 40)
itmax = 100;                               % Numero massimo di iterazioni
nomefile = 'risultati_script_arctan.txt';  % File in cui salvo i risultati

% --- Punto 1: grafico di g e della bisettrice per localizzare alpha ---
figure(1);
% 1. Disegno la funzione di iterazione g(x) = 1 + arctan(x)
fplot(g, [xmin xmax], 'm-', 'LineWidth', 1.5);
hold on;  % Mantengo la figura per aggiungere la bisettrice

% 2. Disegno la bisettrice y = x: il punto fisso è l'intersezione
fplot(bis, [xmin xmax], 'k-', 'LineWidth', 1.5);
hold off;

% 3. Aggiungo titolo, etichette, legenda e griglia
title('1 + arctan(x) versus x');
xlabel('x');
ylabel('y');
legend('g(x) = 1 + arctan(x)', 'y = x');
grid on;

% --- Verifica delle ipotesi del teorema del punto fisso su [a, b] ---
% g è crescente, quindi g([a, b]) = [g(a), g(b)]; g' è massima in a (decresce per x > 0)
ga = g(a); gb = g(b);    % Estremi dell'immagine di [a, b]
Lmax = dg(a);            % Massimo di abs(g') su [a, b]

% --- Punto 2: metodo di punto fisso ---
[xvec, iter, scarti] = pfisso(g, x0, tol, itmax);

% Stima della costante asintotica C nei due modi (slide 35)
asint1 = abs(scarti(2:iter) ./ scarti(1:iter-1));   % Rapporto tra scarti consecutivi
asint2 = abs(dg(xvec));                              % abs(g'(x_k)), che tende a abs(g'(alpha))

% Iterazioni stimate con C (come in script_pfisso.m): abs(s_k) ≈ abs(s_1) * C^(k-1) < tol
nstima = ceil(log(tol / abs(scarti(1))) / log(asint2(end))) + 1;

% --- Punto 3: stampa ordinata a video e su file ---
fid = fopen(nomefile, 'wt');   % Apro il file in scrittura (modalità testo)
if fid == -1
    disp('Errore: impossibile aprire il file dei risultati');
    return;
end

for dest = [1, fid]   % 1 = Command Window, fid = file: scrivo lo stesso testo in entrambi
    % 1. Intestazione e verifica delle ipotesi
    fprintf(dest, '=== Punto fisso: x = 1 + arctan(x), x0 = %g, tol = %g ===\n\n', x0, tol);
    fprintf(dest, 'Verifica su [a, b] = [%g, %g]: \n', a, b);
    fprintf(dest, '   g(a) = %.4f, g(b) = %.4f  ->  g([a, b]) dentro [a, b] \n', ga, gb);
    fprintf(dest, '   max abs(g''(x)) = g''(a) = %.4f < 1  ->  contrazione \n\n', Lmax);

    % 2. Tabella (al passo 1 c'è solo x0, quindi nessuno scarto)
    fprintf(dest, '%5s %22s %14s \n', 'k', 'x_k', 'scarto s_k');
    fprintf(dest, '%5d %22.15f %14s \n', 1, xvec(1), '-');
    for k = 2:iter+1
        fprintf(dest, '%5d %22.15f %14.2e \n', k, xvec(k), scarti(k-1));
    end

    % 3. Riepilogo
    fprintf(dest, '\n%-40s %20.15f \n', 'Soluzione approssimata xvec(end):', xvec(end));
    fprintf(dest, '%-40s %20d \n', 'Iterazioni eseguite:', iter);
    fprintf(dest, '%-40s %20d \n', 'Iterazioni stimate con C:', nstima);
    fprintf(dest, '%-40s %20.4e \n', 'Ultimo scarto abs(scarti(end)):', abs(scarti(end)));
    fprintf(dest, '%-40s %20.4f \n', 'C da rapporto scarti asint1(end):', asint1(end));
    fprintf(dest, '%-40s %20.4f \n', 'C da abs(g''(x)) asint2(end):', asint2(end));
    fprintf(dest, '\n');
end

fclose(fid);   % Chiudo il file
fprintf('Risultati salvati nel file %s\n', nomefile);

% --- Punto 3: profilo di convergenza ---
figure(2);
% 1. Disegno il valore assoluto degli scarti in scala semilogaritmica
semilogy(1:iter, abs(scarti), 'm-*', 'LineWidth', 1.5);

% 2. Aggiungo titolo, etichette, legenda e griglia
title('Profilo di convergenza del punto fisso (g(x) = 1 + arctan(x))');
xlabel('N. iterazioni');
ylabel('|scarto|');
legend('Punto fisso');
grid on;


% --- Salvataggio dei grafici per il README ---
cartella = fullfile(fileparts(mfilename('fullpath')), 'img');                              % Cartella img accanto allo script
if ~exist(cartella, 'dir'), mkdir(cartella); end                                            % La creo se non esiste
exportgraphics(figure(2), fullfile(cartella, 'script_arctan.png'), 'Resolution', 150);      % Salvo il profilo di convergenza
exportgraphics(figure(1), fullfile(cartella, 'script_arctan_g.png'), 'Resolution', 150);    % Salvo g vs bisettrice (scelta di [a, b])