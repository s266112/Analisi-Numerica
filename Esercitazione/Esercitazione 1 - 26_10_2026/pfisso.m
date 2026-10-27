function [xvec, iter, scarti] = pfisso(g, x0, toll, maxit)

% PFISSO: Calcolo un punto fisso di g(x) usando il metodo iterativo.

% INPUT:
%   g     : funzione di iterazione (function handle)
%   x0    : punto iniziale
%   toll  : tolleranza
%   maxit : numero massimo di iterazioni

% OUTPUT:
%   xvec   : vettore delle approssimazioni
%   iter   : numero di iterazioni effettuate
%   scarti : vettore degli scarti
% ------------------------------------------------------------------------

    % Inizializzo le variabili
    xold = x0;       % Iterata corrente
    xvec = x0;       % Vettore delle soluzioni
    scarti = [];     % Vettore Scarti
    dif = toll + 1;  % Trucco per far partire il while
    iter = 0;        % Contatore iterazioni
    
    % Ciclo iterativo
    while (abs(dif) > toll) && (iter < maxit)
        
        % 1. Calcolo il nuovo punto applicando la funzione di iterazione
        xnew = feval(g, xold);   
        
        % 2. Calcolo lo scarto
        dif = xnew - xold;
        
        % 3. Aggiorno il contatore e salvo i risultati
        iter = iter + 1;
        xvec = [xvec; xnew];
        scarti = [scarti; dif];
        
        % 4. Aggiorno xold per il prossimo giro
        xold = xnew;
    end
    
    %  Avviso se non ho raggiunto la convergenza (controllo anche lo scarto)
    if (iter >= maxit) && (abs(dif) > toll)
        disp('Raggiunto il numero massimo di iterazioni senza convergenza.');
    end
end



