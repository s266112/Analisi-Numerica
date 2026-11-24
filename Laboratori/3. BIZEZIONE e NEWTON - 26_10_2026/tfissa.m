function [x, iter, scarti] = tfissa(f, df, x0, tol, itmax)
% TFISSA: Calcolo uno zero di f(x) con il metodo della tangente fissa.
%
% Input:
%   f      funzione di cui cerco lo zero (function handle)
%   df     derivata prima di f (function handle), usata solo in x0
%   x0     punto iniziale
%   tol    tolleranza sullo scarto |x_(k+1) - x_k|
%   itmax  numero massimo di iterazioni
%
% Output:
%   x       vettore delle approssimazioni (x(1) = x0, x(k+1) = x_k)
%   iter    numero di iterazioni eseguite
%   scarti  vettore degli scarti x_(k+1) - x_k (con segno)

% Inizializzo le variabili
dif = tol + 1;          % Trucco per far partire il while
iter = 0;               % Contatore delle iterazioni
xold = x0;              % Approssimazione corrente
x = x0;                 % Vettore delle approssimazioni: il primo elemento è x0
scarti = [];            % Vettore degli scarti (vuoto all'inizio)
df0 = feval(df, x0);    % Pendenza della tangente fissa: calcolata UNA volta sola in x0

% Controllo che la tangente fissa non sia orizzontale (divisione per zero)
if df0 == 0
    disp('Errore: derivata nulla in x0, il metodo della tangente fissa non può partire');
    return;
end

while (abs(dif) > tol) && (iter < itmax)
    % 1. Calcolo f nel punto corrente
    fx = feval(f, xold);

    % 2. Se f(xold) = 0 ho trovato lo zero esatto: mi fermo
    if fx == 0
        return;
    end

    % 3. Calcolo lo scarto (sempre con la pendenza df0) e la nuova approssimazione
    dif = -fx / df0;
    xnew = xold + dif;

    % 4. Aggiorno il contatore e salvo i risultati
    iter = iter + 1;
    x = [x; xnew];
    scarti = [scarti; dif];
    xold = xnew;
end

% Avviso se mi sono fermato per il numero massimo di iterazioni
if (iter == itmax) && (abs(dif) > tol)
    disp('Attenzione: raggiunto il numero massimo di iterazioni senza convergenza');
end
end