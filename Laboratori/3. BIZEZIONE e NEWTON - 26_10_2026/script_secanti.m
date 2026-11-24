% ==========================================
% ESERCIZIO: Zero di f(x) = exp(-x) + cos(x) - 3 con il metodo delle secanti
% ==========================================

clear; clc;  % Pulisco workspace e command window

% --- Parametri di input ---
f   = @(x) exp(-x) + cos(x) - 3;   % Funzione di cui cerco lo zero
df  = @(x) -exp(-x) - sin(x);      % Derivata prima (serve SOLO per la C teorica, non al metodo)
d2f = @(x) exp(-x) - cos(x);       % Derivata seconda (serve SOLO per la C teorica)
xmin = -2; xmax = 1;               % Intervallo per il grafico
x0 = -1.5;                         % Primo punto iniziale (slide 30)
x1 = -1;                           % Secondo punto iniziale (slide 30)
tol = 1e-10;                       % Tolleranza sullo scarto (slide 30)
itmax = 100;                       % Numero massimo di iterazioni (slide 30)

% --- Punto a: grafico della funzione con i due punti iniziali ---
figure(1);
% 1. Disegno la funzione f(x)
fplot(f, [xmin xmax], 'b-', 'LineWidth', 1.5);
hold on;  % Mantengo la figura per aggiungere l'asse x e i punti iniziali

% 2. Disegno l'asse x e i due punti iniziali
plot([xmin xmax], [0 0], 'k-', 'LineWidth', 1.5);
plot([x0 x1], f([x0 x1]), 'ro', 'LineWidth', 1.5);
hold off;

% 3. Aggiungo titolo, etichette, legenda e griglia
title('f(x) = e^{-x} + cos(x) - 3');
xlabel('x');
ylabel('f(x)');
legend('f(x)', 'asse x', 'x_0, x_1');
grid on;

% --- Punto b: metodo delle secanti ---
[xS, iterS, scartiS] = secvariabile(f, x0, x1, tol, itmax);

% Ordine e costante di convergenza: stima dagli ultimi tre scarti e valori teorici (slide 28)
p_teor  = (1 + sqrt(5)) / 2;                                                          % Ordine teorico (rapporto aureo)
p_stima = log(abs(scartiS(end) / scartiS(end-1))) / log(abs(scartiS(end-1) / scartiS(end-2)));   % Ordine stimato
C_teor  = abs(d2f(xS(end)) / (2*df(xS(end))))^(p_teor - 1);                            % |f''/(2f')|^0.618
C_stima = abs(scartiS(end)) / abs(scartiS(end-1))^p_teor;                             % |s_k| / |s_(k-1)|^p

% Tabella (riga 1: x0 senza scarto; riga 2: x1 con lo scarto x1 - x0)
fprintf('Metodo delle secanti (x0 = %g, x1 = %g) \n', x0, x1);
fprintf('%5s %22s %14s \n', 'k', 'x_k', 'scarto s_k');
fprintf('%5d %22.15f %14s \n', 1, xS(1), '-');
for k = 2:iterS+2
    fprintf('%5d %22.15f %14.2e \n', k, xS(k), scartiS(k-1));
end

% Riepilogo
fprintf('\n%-35s %20.15f \n', 'Soluzione approssimata:', xS(end));
fprintf('%-35s %20d \n', 'Iterazioni eseguite:', iterS);
fprintf('\n%-35s %12s %12s \n', '', 'Stimato', 'Teorico');
fprintf('%-35s %12.4f %12.4f \n', 'Ordine di convergenza p:', p_stima, p_teor);
fprintf('%-35s %12.4f %12.4f \n', 'Costante C:', C_stima, C_teor);

% --- Punto c: profilo di convergenza ---
figure(2);
% 1. Disegno il valore assoluto degli scarti (il primo è x1 - x0)
semilogy(1:iterS+1, abs(scartiS), 'b-o', 'LineWidth', 1.5);

% 2. Aggiungo titolo, etichette, legenda e griglia
title('Profilo di convergenza del metodo delle secanti');
xlabel('N. iterazioni');
ylabel('|scarto|');
legend('Secanti');
grid on;


% --- Salvataggio del grafico per il README ---
cartella = fullfile(fileparts(mfilename('fullpath')), 'img');                             % Cartella img accanto allo script
if ~exist(cartella, 'dir'), mkdir(cartella); end                                           % La creo se non esiste
exportgraphics(figure(2), fullfile(cartella, 'script_secanti.png'), 'Resolution', 150);    % Salvo il profilo di convergenza