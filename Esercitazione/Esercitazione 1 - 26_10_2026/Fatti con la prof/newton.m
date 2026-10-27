function [x,iter,scarti]=newton(f,df,x0,tol,itmax)

% NEWTON:  calcola una radice della funzione fun definita 
% nell'intervallo [a,b] usando il metodo iterativo di Newton
% test di arresto sullo scarto (step = residuo pesato)


% parametri di input: 
%        f: funzione della quale si cerca una radice in [a,b]
%        d: derivata prima di f
%        x0 = approssimazione iniziale
%        toll: tolleranza  
%        itmax: numero massimo di iterazioni 

% parametri di output: 
%        x: vettore delle approssimazione della radice 
%        iter:  numero di iterazioni effettuate
%        scarti: vettore degli scarti successivi
%----------------------------------------------------------------



    % Inizializzazione delle variabili
    xold = x0;       % Iterata Corrente
    x = [x0];        % Vettore delle soluzioni
    scarti = [];     % Vettore degli scarti
    dif = tol + 1;   % Trucco: parte > tot per far entrare nel while
    iter = 0;        % contatore iterazioni

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
         
         % Aggiornamento del passo e della nuova iterata
         iter = iter + 1;
         dif = -fx / dfx;
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