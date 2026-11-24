% ==========================================
% ESERCIZIO SVOLTO A LEZIONE: Zero di f(x) = exp(-2x) - x^2 con il metodo di Newton
% ==========================================

clear; clc;  % Pulisco workspace e command window

% --- Parametri di input ---
f  = @(x) exp(-2*x) - x.^2;      % Funzione di cui cerco lo zero
df = @(x) -2*exp(-2*x) - 2*x;    % Derivata prima di f
a = 0; b = 1;                    % Intervallo per il grafico
x0 = 0.6;                        % Punto iniziale (altri provati a lezione: x0 = 0, x0 = 1)
toll = 1e-7;                     % Tolleranza sullo scarto
itmax = 100;                     % Numero massimo di iterazioni

% --- Punto a: grafico della funzione ---
figure(1);
% 1. Disegno la funzione f(x) nell'intervallo [a, b]
fplot(f, [a b], 'b-', 'LineWidth', 1.5);
hold on;  % Mantengo la figura per aggiungere l'asse x

% 2. Disegno l'asse x
plot([a b], [0 0], 'k-', 'LineWidth', 1.5);
hold off;

% 3. Aggiungo titolo, etichette e griglia
title('f(x) = e^{-2x} - x^2');
xlabel('x');
ylabel('f(x)');
grid on;

% --- Punto b: metodo di Newton ---
[xN, iterN, scartiN] = newton(f, df, x0, toll, itmax);

% Stampo i risultati in colonne (al passo 1 c'è solo x0, quindi nessuno scarto)
fprintf('Metodo di Newton \n\n');
fprintf('%5s %22s %14s \n', 'k', 'x_k', 'scarto s_k');
fprintf('%5d %22.15f %14s \n', 1, xN(1), '-');
for k = 2:iterN+1
    fprintf('%5d %22.15f %14.2e \n', k, xN(k), scartiN(k-1));
end

% --- Punto c: profilo di convergenza ---
figure(2);
% 1. Disegno il valore assoluto degli scarti in scala semilogaritmica
semilogy(1:iterN, abs(scartiN), 'm-o', 'LineWidth', 1.5);

% 2. Aggiungo titolo, etichette, legenda e griglia
title('Profilo di convergenza del metodo di Newton');
xlabel('N. iterazioni');
ylabel('|scarto|');
legend('Newton');
grid on;

% --- Punto d: errore relativo dell'ultima approssimazione ---
% Inizializzo le variabili
d2f = @(x) 4*exp(-2*x) - 2;      % Derivata seconda di f
xfin = xN(end);                  % Ultima approssimazione calcolata

% 1. Stima teorica: |e_(k+1)| ≈ C * |e_k|^2, con C = |f''(alpha) / (2 f'(alpha))|
C = abs(d2f(xfin) / (2*df(xfin)));    % Costante asintotica (uso xfin al posto di alpha)
e_stima = C * scartiN(end)^2;         % Errore assoluto stimato (l'ultimo scarto approssima l'errore precedente)
errrel_stima = e_stima / abs(xfin);   % Errore relativo stimato

% 2. Verifica numerica: faccio un passo di Newton in più partendo da xfin
xsucc = xfin - f(xfin) / df(xfin);
errrel_num = abs(xsucc - xfin) / abs(xsucc);

% 3. Stampo i risultati a confronto con la precisione di macchina
fprintf('\n--- Errore relativo su x_%d ---\n', iterN+1);
fprintf('%-38s %12.4e \n', 'Costante C = |f''''/(2f'')|:', C);
fprintf('%-38s %12.4e \n', 'Stima errore assoluto C*s^2:', e_stima);
fprintf('%-38s %12.4e \n', 'Stima errore relativo:', errrel_stima);
fprintf('%-38s %12.4e \n', 'Scarto relativo al passo successivo:', errrel_num);
fprintf('%-38s %12.4e \n', 'Residuo |f(x_fin)|:', abs(f(xfin)));
fprintf('%-38s %12.4e \n', 'Precisione di macchina u = eps/2:', eps/2);



% --- Salvataggio del grafico per il README ---
cartella = fullfile(fileparts(mfilename('fullpath')), 'img');                         % Cartella img accanto allo script
if ~exist(cartella, 'dir'), mkdir(cartella); end                                       % La creo se non esiste
exportgraphics(figure(2), fullfile(cartella, 'aula_newton.png'), 'Resolution', 150);   % Salvo il profilo di convergenza