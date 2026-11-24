% ==========================================
% ESERCIZIO: Punto fisso di g(x) = cos(x), cioè soluzione di x = cos(x)
% ==========================================

clear; clc;  % Pulisco workspace e command window

% --- Parametri di input ---
g   = @(x) cos(x);                         % Funzione di iterazione
dg  = @(x) -sin(x);                        % Derivata prima di g (per la stima di C, slide 35)
bis = @(x) x;                              % Bisettrice y = x
xmin = 0.5; xmax = 1;                      % Intervallo per il grafico (slide 36)
x0 = 0.5;                                  % Punto iniziale (slide 37)
tol = 1e-12;                               % Tolleranza sullo scarto (slide 37)
itmax = 100;                               % Numero massimo di iterazioni (slide 37)
nomefile = 'risultati_script_pfisso.txt';  % File in cui salvo i risultati (slide 38)

% --- Punto a: grafico di g e della bisettrice (slide 36) ---
figure(1);
% 1. Disegno la funzione di iterazione g(x) = cos(x)
fplot(g, [xmin xmax], 'm-', 'LineWidth', 1.5);
hold on;  % Mantengo la figura per aggiungere la bisettrice

% 2. Disegno la bisettrice y = x: il punto fisso è l'intersezione
fplot(bis, [xmin xmax], 'k-', 'LineWidth', 1.5);
hold off;

% 3. Aggiungo titolo, etichette, legenda e griglia
title('cos(x) versus x');
xlabel('x');
ylabel('y');
legend('g(x) = cos(x)', 'y = x');
grid on;

% --- Punto b: metodo di punto fisso (slide 37) ---
[xvec, iter, scarti] = pfisso(g, x0, tol, itmax);

% Stima della costante asintotica C nei due modi (slide 35)
asint1 = abs(scarti(2:iter) ./ scarti(1:iter-1));   % Rapporto tra scarti consecutivi
asint2 = abs(dg(xvec));                              % |g'(x_k)|, che tende a |g'(alpha)|

% Iterazioni stimate con C (extra): |s_k| ≈ |s_1| * C^(k-1) < tol
nstima = ceil(log(tol / abs(scarti(1))) / log(asint2(end))) + 1;

% --- Punto c: stampa ordinata a video e su file (slide 38) ---
fid = fopen(nomefile, 'wt');   % Apro il file in scrittura (modalità testo)
if fid == -1
    disp('Errore: impossibile aprire il file dei risultati');
    return;
end

for dest = [1, fid]   % 1 = Command Window, fid = file: scrivo lo stesso testo in entrambi
    % 1. Intestazione
    fprintf(dest, '=== Punto fisso: x = cos(x), x0 = %g, tol = %g ===\n\n', x0, tol);

    % 2. Tabella (al passo 1 c'è solo x0, quindi nessuno scarto)
    fprintf(dest, '%5s %22s %14s \n', 'k', 'x_k', 'scarto s_k');
    fprintf(dest, '%5d %22.15f %14s \n', 1, xvec(1), '-');
    for k = 2:iter+1
        fprintf(dest, '%5d %22.15f %14.2e \n', k, xvec(k), scarti(k-1));
    end

    % 3. Riepilogo (confronto con i valori della slide 37)
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

% --- Punto d: profilo di convergenza ---
figure(2);
% 1. Disegno il valore assoluto degli scarti in scala semilogaritmica
semilogy(1:iter, abs(scarti), 'm-*', 'LineWidth', 1.5);

% 2. Aggiungo titolo, etichette, legenda e griglia
title('Profilo di convergenza del punto fisso (g(x) = cos(x))');
xlabel('N. iterazioni');
ylabel('|scarto|');
legend('Punto fisso');
grid on;


% --- Salvataggio dei grafici per il README ---
cartella = fullfile(fileparts(mfilename('fullpath')), 'img');                              % Cartella img accanto allo script
if ~exist(cartella, 'dir'), mkdir(cartella); end                                            % La creo se non esiste
exportgraphics(figure(2), fullfile(cartella, 'script_pfisso.png'), 'Resolution', 150);      % Salvo il profilo di convergenza
