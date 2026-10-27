function [xv, scartiv, iter] = steffensen(f, x0, toll, nmax)

% STEFFENSEN: Calcolo una radice di f(x)=0 usando il metodo di Steffensen.

% INPUT:
%   f     : funzione di cui si cerca la radice
%   x0    : approssimazione iniziale
%   toll  : tolleranza
%   nmax  : numero massimo di iterazioni

% OUTPUT:
%   xv      : vettore delle approssimazioni
%   scartiv : vettore degli scarti
%   iter    : numero di iterazioni effettuate
% ------------------------------------------------------------------------

    % Inizializzo le variabili
    xv = x0;         % Vettore delle soluzioni
    scartiv = [];    % Vettore degli scarti
    dif = toll + 1;  % Trucco per far partire il while
    iter = 0;        % Contatore iterazioni

    % Ciclo iterativo
    while (abs(dif) > toll) && (iter < nmax)

        % 1. Calcolo la funzione nel punto corrente
        fx = f(xv(end));    

        % Se la funzione è esattamente zero, ho finito
        if fx == 0
            return;
        end

        % 2. Calcolo la funzione di iterazione g(xk)
        gx = (f(xv(end) + fx) - fx) / fx;

        % Controllo per evitare la divisione per zero
        if gx == 0
            disp('Errore: g(x) = 0, divisione per zero.');
            return;
        end
        
        % 3. Passo di Steffensen
        iter = iter + 1;
        dif = -fx / gx;
        xnew = xv(end) + dif;

        % 4. Salvo i risultati nei vettori
        xv = [xv; xnew];
        scartiv = [scartiv; dif];
    end

    % Avviso se non ho raggiunto la convergenza
    if (iter >= nmax) && (abs(dif) > toll)
        disp('Raggiunto il numero massimo di iterazioni senza convergenza.');
    end

end


