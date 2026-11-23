function xc = chebgauss(a, b, m)

% CHEBGAUSS: Calcolo gli m nodi di Chebyshev-Gauss scalati nell'intervallo [a, b].

% INPUT:
%   a     : estremo sinistro dell'intervallo
%   b     : estremo destro dell'intervallo
%   m     : numero di nodi da generare

% OUTPUT:
%   xc    : vettore colonna dei nodi di Chebyshev-Gauss (in ordine crescente)
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

% Calcolo i nodi
for k = 1:m

    % 1. Calcolo il nodo di Chebyshev in [-1, 1]
    tk = -cos((2*k -1) / (2*m) * pi);

    % 2. Lo scalo nell'intervallo [a, b] e lo salvo
    xk = (a + b)/2 + ((b - a)/2) * tk;
    xc = [xc; xk];
end

end