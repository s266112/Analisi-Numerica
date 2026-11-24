function [x, iter, scarti] = newtonmod(f, df, x0, tol, itmax, r)
% NEWTONMOD: Calcolo uno zero di molteplicità r di f(x) con il metodo di Newton modificato.
%
% Input:
%   f      funzione di cui cerco lo zero (function handle)
%   df     derivata prima di f (function handle)
%   x0     punto iniziale
%   tol    tolleranza sullo scarto |x_(k+1) - x_k|
%   itmax  numero massimo di iterazioni
%   r      molteplicità della radice (r = 1: metodo di Newton classico)
%
% Output:
%   x       vettore delle approssimazioni (x(1) = x0, x(k+1) = x_k)
%   iter    numero di iterazioni eseguite
%   scarti  vettore degli scarti x_(k+1) - x_k (con segno)

% Inizializzo le variabili
dif = tol + 1;   % Trucco per far partire il while
iter = 0;        % Contatore delle iterazioni
xold = x0;       % Approssimazione corrente
x = x0;          % Vettore delle approssimazioni: il primo elemento è x0
scarti = [];     % Vettore degli scarti (vuoto all'inizio)

while (abs(dif) > tol) && (iter < itmax)
    % 1. Calcolo f e la sua derivata nel punto corrente
    fx = feval(f, xold);
    dfx = feval(df, xold);

    % 2. Controllo che la derivata non sia nulla (divisione per zero)
    if dfx == 0
        disp('Errore: derivata nulla, il metodo di Newton modificato non può proseguire');
        return;
    end

    % 3. Calcolo lo scarto (moltiplicato per la molteplicità r) e la nuova approssimazione
    dif = -r * fx / dfx;
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