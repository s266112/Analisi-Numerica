% ==========================================
% ESERCIZIO: Newton vs Newton modificato per la radice multipla di f(x) = (x-1)^2 log(x)
% ==========================================

clear; clc;  % Pulisco workspace e command window

% --- Parametri di input ---
f  = @(x) (x - 1).^2 .* log(x);                 % Funzione: radice x = 1 di molteplicità 3
df = @(x) 2*(x - 1).*log(x) + (x - 1).^2 ./ x;  % Derivata prima (regola del prodotto)
a = 1; b = 3;                                   % Intervallo dell'esercizio
x0 = 2;                                         % Punto iniziale in [a, b]
tol = 1e-9;                                     % Tolleranza sullo scarto
itmax = 100;                                    % Numero massimo di iterazioni
r = 3;                                          % Molteplicità: (x-1)^2 * log(x) ≈ (x-1)^3 vicino a 1

% --- Grafico della funzione ---
figure(1);
% 1. Disegno la funzione f(x)
fplot(f, [a b], 'b-', 'LineWidth', 1.5);
hold on;  % Mantengo la figura per aggiungere l'asse x

% 2. Disegno l'asse x
plot([a b], [0 0], 'k-', 'LineWidth', 1.5);
hold off;

% 3. Aggiungo titolo, etichette e griglia
title('f(x) = (x-1)^2 log(x)');
xlabel('x');
ylabel('f(x)');
grid on;

% --- Punto 1: Newton (r = 1) e Newton modificato (r = 3) ---
[xN, iterN, scartiN] = newtonmod(f, df, x0, tol, itmax, 1);
[xM, iterM, scartiM] = newtonmod(f, df, x0, tol, itmax, r);

% Stampo i risultati del metodo modificato (poche iterazioni)
fprintf('Newton modificato (r = %d, x0 = %g) \n', r, x0);
fprintf('%5s %22s %14s \n', 'k', 'x_k', 'scarto s_k');
fprintf('%5d %22.15f %14s \n', 1, xM(1), '-');
for k = 2:iterM+1
    fprintf('%5d %22.15f %14.2e \n', k, xM(k), scartiM(k-1));
end

% Riepilogo a confronto
fprintf('\n%-40s %20s %20s \n', '', 'Newton (r = 1)', sprintf('Modificato (r = %d)', r));
fprintf('%-40s %20.15f %20.15f \n', 'Soluzione approssimata:', xN(end), xM(end));
fprintf('%-40s %20d %20d \n', 'Iterazioni eseguite:', iterN, iterM);
fprintf('%-40s %20.4f %20s \n', 'Rapporto ultimi scarti |s_k / s_(k-1)|:', abs(scartiN(end) / scartiN(end-1)), '-');
fprintf('%-40s %20.4f %20s \n', 'Valore teorico (r-1)/r:', (r - 1) / r, '-');

% --- Punto 2: confronto dei profili di convergenza (grafico unico, due curve) ---
figure(2);
% 1. Disegno gli scarti di Newton modificato
semilogy(1:iterM, abs(scartiM), 'b-o', 'LineWidth', 1.5);
hold on;  % Mantengo la figura per aggiungere Newton classico

% 2. Disegno gli scarti di Newton classico
semilogy(1:iterN, abs(scartiN), 'r-o', 'LineWidth', 1.5);
hold off;

% 3. Aggiungo titolo, etichette, legenda e griglia
title('Profilo di convergenza Newton Modificato versus Newton');
xlabel('iter');
ylabel('abs(scarto)');
legend('Newton Modificato', 'Newton');
grid on;


% --- Salvataggio del grafico per il README ---
cartella = fullfile(fileparts(mfilename('fullpath')), 'img');                       % Cartella img accanto allo script
if ~exist(cartella, 'dir'), mkdir(cartella); end                                     % La creo se non esiste
exportgraphics(figure(2), fullfile(cartella, 'scriptmod.png'), 'Resolution', 150);   % Salvo il confronto Newton vs modificato