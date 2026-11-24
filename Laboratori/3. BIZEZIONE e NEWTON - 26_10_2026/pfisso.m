function [xvec, iter, scarti] = pfisso(g, x0, tol, itmax)
% PFISSO: Calcolo un punto fisso di g(x), cioè alpha = g(alpha), con il metodo di punto fisso.
%
% Input:
%   g      funzione di iterazione (function handle)
%   x0     punto iniziale
%   tol    tolleranza sullo scarto |x_(k+1) - x_k|
%   itmax  numero massimo di iterazioni
%
% Output:
%   xvec    vettore delle approssimazioni (xvec(1) = x0, xvec(k+1) = x_k)
%   iter    numero di iterazioni eseguite
%   scarti  vettore degli scarti x_(k+1) - x_k (con segno)

% Inizializzo le variabili
dif = tol + 1;   % Trucco per far partire il while
iter = 0;        % Contatore delle iterazioni
xold = x0;       % Approssimazione corrente
xvec = x0;       % Vettore delle approssimazioni: il primo elemento è x0
scarti = [];     % Vettore degli scarti (vuoto all'inizio)

while (abs(dif) > tol) && (iter < itmax)
    % 1. Calcolo la nuova approssimazione applicando g
    xnew = feval(g, xold);

    % 2. Calcolo lo scarto
    dif = xnew - xold;

    % 3. Aggiorno il contatore e salvo i risultati
    iter = iter + 1;
    xvec = [xvec; xnew];
    scarti = [scarti; dif];
    xold = xnew;
end

% Avviso se mi sono fermato per il numero massimo di iterazioni
if (iter == itmax) && (abs(dif) > tol)
    disp('Attenzione: raggiunto il numero massimo di iterazioni senza convergenza');
end
end