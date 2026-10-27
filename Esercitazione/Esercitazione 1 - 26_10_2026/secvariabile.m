function [xvec, scarti, iter] = secvariabile(f, x0, toll, itmax)

% SECVARIABILE: Calcolo una radice di f(x)=0 usando il metodo delle secanti.

% INPUT:
%   f     : funzione di cui si cerca la radice
%   x0    : punto iniziale (se scalare, il secondo punto viene generato internamente)
%   toll  : tolleranza
%   itmax : numero massimo di iterazioni

% OUTPUT:
%   xvec   : vettore delle approssimazioni
%   scarti : vettore degli scarti
%   iter   : numero di iterazioni effettuate
% -----------------------------------------------------------------------

    % Inizializzo le variabili
    if length(x0) == 1
        x_prec = x0;            % x_{k-1}: Punto precedente (inizialmente x0)
        x_corr = x0 + 0.01;     % x_k: Punto corrente (generato internamente) 
    else
        x_prec = x0(1);         % Prende il primo elemento del vettore
        x_corr = x0(2);         % Prende il secondo elemento del vettore
    end
    
    xvec = [x_prec; x_corr];    % Vettore delle soluzioni
    scarti = [];                % Vettore scarti
    dif = toll + 1;             % Trucco per far partire il while
    iter = 0;                   % Contatore iterazioni
    
    
    % Ciclo iterativo
    while (abs(dif) > toll) && (iter < itmax)
        
        % 1. Calcolo la funzione nei due punti precedenti
        fx = f(x_corr);
        fx_prec = f(x_prec);    
        
        % 2. Calcolo il denominatore 
        den = fx - fx_prec;     
        
        % Controllo per evitare divisioni per zero
        if den == 0
            disp('Errore: divisione per zero nel calcolo della secante');
            return;
        end
        
        % 3. Calcolo lo scarto e il nuovo punto
        dif = - fx * (x_corr - x_prec) / den;
        x_new = x_corr + dif;
        
        % 4. Aggiorno il contatore e salvo i risultati
        iter = iter + 1;
        xvec = [xvec; x_new];
        scarti = [scarti; dif];
        
        % 5. Aggiorno le variabili per il prossimo giro
        x_prec = x_corr;
        x_corr = x_new;
    end
    
    % Avviso se non ho raggiunto la convergenza
    if (iter >= itmax) && (abs(dif) > toll)
        disp('Raggiunto il numero massimo di iterazioni senza convergenza.');
    end
end