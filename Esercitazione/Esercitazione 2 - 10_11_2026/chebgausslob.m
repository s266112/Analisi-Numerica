function xc = chebgausslob(a, b, m)
% CHEBGAUSSLOB: Calcolo gli m nodi di Chebyshev-Gauss-Lobatto scalati
%               nell'intervallo [a, b] (estremi a e b compresi).

% INPUT:
%   a     : estremo sinistro dell'intervallo
%   b     : estremo destro dell'intervallo
%   m     : numero di nodi da generare (almeno 2)

% OUTPUT:
%   xc    : vettore colonna dei nodi di Chebyshev-Gauss-Lobatto (in ordine crescente)
% ------------------------------------------------------------------------

    % Inizializzo le variabili
    xc = [];                    % Vettore dei nodi (vuoto in caso di errore)

    % Controllo che l'intervallo sia valido
    if a >= b
        disp('Errore: deve essere a < b');
        return
    end

    % Controllo che m sia un intero positivo
    if (m < 1) || (m ~= round(m))
        disp('Errore: m deve essere un intero positivo');
        return
    end

    % Controllo la divisione per zero (con m = 1 si divide per m - 1 = 0)
    if m == 1
        disp('Errore: servono almeno m = 2 nodi (divisione per m - 1 = 0)');
        return
    end

    % Calcolo i nodi
    for k = 1:m
        % 1. Calcolo il nodo di Chebyshev-Lobatto in [-1, 1]
        tk = -cos(pi * (k - 1) / (m - 1));

        % 2. Lo scalo nell'intervallo [a, b] e lo salvo
        xk = (a + b)/2 + ((b - a)/2) * tk;
        xc = [xc; xk];
    end

end