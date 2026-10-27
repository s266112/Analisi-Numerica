function [x, iter, scarti] = newtonmod(f, df, x0, tol, itmax, r)

% NEWTONMOD: calcola una radice multipla della funzione f
% usando il metodo di Newton modificato con molteplicità r
% test di arresto sullo scarto

% parametri di input:
%   f      : funzione di cui si cerca una radice
%   df     : derivata prima di f
%   x0     : approssimazione iniziale
%   tol    : tolleranza
%   itmax  : numero massimo di iterazioni
%   r      : molteplicità della radice

% parametri di output:
%   x      : vettore delle approssimazioni
%   iter   : numero di iterazioni effettuate
%   scarti : vettore degli scarti successivi
%----------------------------------------------------------------



    % Inizializzazione delle variabili
    xold = x0;       % Iterata corrente
    x = [x0];        % Vettore delle soluzioni
    scarti = [];     % Vettore degli scarti
    dif = tol + 1;   % Trucco: parte > tol per far entrare nel while
    iter = 0;        % Contatore iterazioni

    % Ciclo iterativo
    while (abs(dif) > tol) && (iter < itmax)

        % Calcolo della funzione nel punto corrente
        fx = feval(f, xold);

        % Se la funzione è esattamente zero, abbiamo finito
        if fx == 0
            return;
        end

        % Calcolo della derivata prima
        dfx = feval(df, xold);

        % Controllo per evitare la divisione per zero
        if dfx == 0
            disp('ERRORE: derivata nulla.');
            return;
        end

        % Passo di Newton modificato (nota il fattore r)
        iter = iter + 1;
        dif = -r * fx / dfx; 
        xnew = xold + dif;

        % Salvataggio dei risultati nei vettori
        x = [x; xnew];
        scarti = [scarti; dif];

        % Aggiornamento per il prossimo passo
        xold = xnew;
    end

    % Avviso se non si è raggiunta la convergenza
    if iter >= itmax
        disp('Raggiunto il numero massimo di iterazioni.');
    end

end