% ==========================================
% ESERCIZIO: Zero di f(x) = exp(-x) + cos(x) - 3 con Newton e tangente fissa
% ==========================================

clear; clc;  % Pulisco workspace e command window

% --- Parametri di input ---
f  = @(x) exp(-x) + cos(x) - 3;   % Funzione di cui cerco lo zero
df = @(x) -exp(-x) - sin(x);      % Derivata prima di f
xmin = -2; xmax = 1;              % Intervallo per il grafico
x0 = -1;                          % Punto iniziale (slide 27)
tol = 1e-9;                       % Tolleranza sullo scarto (slide 27)
itmax = 100;                      % Numero massimo di iterazioni (slide 27)

% --- Punto a: grafico della funzione ---
figure(1);
% 1. Disegno la funzione f(x)
fplot(f, [xmin xmax], 'b-', 'LineWidth', 1.5);
hold on;  % Mantengo la figura per aggiungere l'asse x e x0

% 2. Disegno l'asse x e il punto iniziale
plot([xmin xmax], [0 0], 'k-', 'LineWidth', 1.5);
plot(x0, f(x0), 'ro', 'LineWidth', 1.5);
hold off;

% 3. Aggiungo titolo, etichette, legenda e griglia
title('f(x) = e^{-x} + cos(x) - 3');
xlabel('x');
ylabel('f(x)');
legend('f(x)', 'asse x', 'x_0');
grid on;

% --- Punto b: Newton e tangente fissa ---
[xN, iterN, scartiN] = newton(f, df, x0, tol, itmax);
[xT, iterT, scartiT] = tfissa(f, df, x0, tol, itmax);

% Costanti di convergenza: stima dagli scarti e valore teorico (uso xN(end) al posto di alpha)
d2f = @(x) exp(-x) - cos(x);                       % Derivata seconda di f (serve solo per la C di Newton)
CN_stima = abs(scartiN(end) / scartiN(end-1)^2);   % Newton: |s_k| / |s_(k-1)|^2 (quadratica)
CN_teor  = abs(d2f(xN(end)) / (2*df(xN(end))));    % Newton: |f''(alpha) / (2 f'(alpha))|
CT_stima = abs(scartiT(end) / scartiT(end-1));     % Tangente fissa: |s_k| / |s_(k-1)| (lineare)
CT_teor  = abs(1 - df(xN(end)) / df(x0));          % Tangente fissa: |1 - f'(alpha) / f'(x0)|

% Tabella di Newton (al passo 1 c'è solo x0, quindi nessuno scarto)
fprintf('Metodo di Newton (x0 = %g) \n', x0);
fprintf('%5s %22s %14s \n', 'k', 'x_k', 'scarto s_k');
fprintf('%5d %22.15f %14s \n', 1, xN(1), '-');
for k = 2:iterN+1
    fprintf('%5d %22.15f %14.2e \n', k, xN(k), scartiN(k-1));
end

% Tabella della tangente fissa
fprintf('\nMetodo della tangente fissa (x0 = %g) \n', x0);
fprintf('%5s %22s %14s \n', 'k', 'x_k', 'scarto s_k');
fprintf('%5d %22.15f %14s \n', 1, xT(1), '-');
for k = 2:iterT+1
    fprintf('%5d %22.15f %14.2e \n', k, xT(k), scartiT(k-1));
end

% Riepilogo a confronto
fprintf('\n%-35s %20s %20s \n', '', 'Newton', 'Tangente fissa');
fprintf('%-35s %20.15f %20.15f \n', 'Soluzione approssimata:', xN(end), xT(end));
fprintf('%-35s %20d %20d \n', 'Iterazioni eseguite:', iterN, iterT);
fprintf('%-35s %20.4f %20.4f \n', 'Costante C stimata dagli scarti:', CN_stima, CT_stima);
fprintf('%-35s %20.4f %20.4f \n', 'Costante C teorica:', CN_teor, CT_teor);

% --- Punto c: profili di convergenza (grafico unico, due curve) ---
figure(2);
% 1. Disegno gli scarti di Newton
semilogy(1:iterN, abs(scartiN), 'm-*', 'LineWidth', 1.5);
hold on;  % Mantengo la figura per aggiungere la tangente fissa

% 2. Disegno gli scarti della tangente fissa
semilogy(1:iterT, abs(scartiT), 'b-o', 'LineWidth', 1.5);
hold off;

% 3. Aggiungo titolo, etichette, legenda e griglia
title('Profili di convergenza: Newton vs tangente fissa');
xlabel('N. iterazioni');
ylabel('|scarto|');
legend('Newton', 'Tangente fissa');
grid on;


% --- Salvataggio del grafico per il README ---
cartella = fullfile(fileparts(mfilename('fullpath')), 'img');                            % Cartella img accanto allo script
if ~exist(cartella, 'dir'), mkdir(cartella); end                                          % La creo se non esiste
exportgraphics(figure(2), fullfile(cartella, 'script_tfissa.png'), 'Resolution', 150);    % Salvo il confronto dei profili