% ==========================================
% ESERCIZIO: x = cos(x) con Newton e con il metodo di punto fisso (confronto)
% ==========================================

clear; clc;  % Pulisco workspace e command window

% --- Parametri di input ---
f   = @(x) x - cos(x);     % Newton: riscrivo x = cos(x) come f(x) = 0
df  = @(x) 1 + sin(x);     % Derivata prima di f
d2f = @(x) cos(x);         % Derivata seconda di f (serve solo per la C teorica di Newton)
g   = @(x) cos(x);         % Punto fisso: funzione di iterazione
dg  = @(x) -sin(x);        % Derivata prima di g (serve solo per la C teorica del punto fisso)
x0 = 0.5;                  % Punto iniziale, uguale per i due metodi (come slide 37)
tol = 1e-10;               % Tolleranza sullo scarto (slide 39)
itmax = 100;               % Numero massimo di iterazioni (slide 39)

% --- Punto a: Newton e punto fisso ---
[xN, iterN, scartiN] = newton(f, df, x0, tol, itmax);
[xP, iterP, scartiP] = pfisso(g, x0, tol, itmax);

% Costanti di convergenza: stima dagli scarti e valore teorico (uso xN(end) al posto di alpha)
CN_stima = abs(scartiN(end) / scartiN(end-1)^2);   % Newton: |s_k| / |s_(k-1)|^2 (quadratica)
CN_teor  = abs(d2f(xN(end)) / (2*df(xN(end))));    % Newton: |f''(alpha) / (2 f'(alpha))|
CP_stima = abs(scartiP(end) / scartiP(end-1));     % Punto fisso: |s_k| / |s_(k-1)| (lineare)
CP_teor  = abs(dg(xN(end)));                       % Punto fisso: |g'(alpha)|

% Tabella di Newton (al passo 1 c'è solo x0, quindi nessuno scarto)
fprintf('Metodo di Newton su f(x) = x - cos(x) (x0 = %g) \n', x0);
fprintf('%5s %22s %14s \n', 'k', 'x_k', 'scarto s_k');
fprintf('%5d %22.15f %14s \n', 1, xN(1), '-');
for k = 2:iterN+1
    fprintf('%5d %22.15f %14.2e \n', k, xN(k), scartiN(k-1));
end

% Tabella del punto fisso
fprintf('\nMetodo di punto fisso con g(x) = cos(x) (x0 = %g) \n', x0);
fprintf('%5s %22s %14s \n', 'k', 'x_k', 'scarto s_k');
fprintf('%5d %22.15f %14s \n', 1, xP(1), '-');
for k = 2:iterP+1
    fprintf('%5d %22.15f %14.2e \n', k, xP(k), scartiP(k-1));
end

% Riepilogo a confronto
fprintf('\n%-35s %20s %20s \n', '', 'Newton', 'Punto fisso');
fprintf('%-35s %20.15f %20.15f \n', 'Soluzione approssimata:', xN(end), xP(end));
fprintf('%-35s %20d %20d \n', 'Iterazioni eseguite:', iterN, iterP);
fprintf('%-35s %20.4f %20.4f \n', 'Costante C stimata dagli scarti:', CN_stima, CP_stima);
fprintf('%-35s %20.4f %20.4f \n', 'Costante C teorica:', CN_teor, CP_teor);
fprintf('%-35s %20.2e \n', 'Differenza tra le due soluzioni:', abs(xP(end) - xN(end)));

% --- Punto b: profili di convergenza (grafico unico, due curve) ---
figure(1);
% 1. Disegno gli scarti di Newton
semilogy(1:iterN, abs(scartiN), 'm-*', 'LineWidth', 1.5);
hold on;  % Mantengo la figura per aggiungere il punto fisso

% 2. Disegno gli scarti del punto fisso
semilogy(1:iterP, abs(scartiP), 'b-o', 'LineWidth', 1.5);
hold off;

% 3. Aggiungo titolo, etichette, legenda e griglia
title('Profili di convergenza per x = cos(x): Newton vs punto fisso');
xlabel('N. iterazioni');
ylabel('|scarto|');
legend('Newton', 'Punto fisso');
grid on;


% --- Salvataggio del grafico per il README ---
cartella = fullfile(fileparts(mfilename('fullpath')), 'img');                               % Cartella img accanto allo script
if ~exist(cartella, 'dir'), mkdir(cartella); end                                             % La creo se non esiste
exportgraphics(figure(1), fullfile(cartella, 'script_confronto.png'), 'Resolution', 150);    % Salvo il confronto dei profili