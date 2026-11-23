function t = interpol(x, y, s)

% INTERPOL: Calcolo il polinomio interpolatore di grado n-1 che passa per
%           le n coppie (x_k, y_k) e lo valuto nei punti s.

% INPUT:
%   x     : vettore delle ascisse dei nodi (n nodi distinti)
%   y     : vettore delle ordinate da interpolare (stessa lunghezza di x)
%   s     : vettore dei punti in cui valutare il polinomio

% OUTPUT:
%   t     : vettore dei valori del polinomio interpolatore nei punti s
% ------------------------------------------------------------------------

    % Inizializzo le variabili
    x = x(:);                   % Trasformo x in vettore colonna
    y = y(:);                   % Trasformo y in vettore colonna
    s = s(:);                   % Trasformo s in vettore colonna
    n = length(x);              % Numero di nodi
    t = [];                     % Vettore dei valori (vuoto in caso di errore)

    % Controllo che x e y abbiano la stessa lunghezza
    if length(y) ~= n
        disp('Errore: i vettori x e y devono avere la stessa lunghezza');
        return
    end

    % Controllo che i nodi siano distinti (altrimenti il problema non ha soluzione)
    if length(unique(x)) < n
        disp('Errore: i nodi x devono essere distinti');
        return
    end

    % 1. Calcolo il grado del polinomio
    grado = n - 1;

    % 2. Calcolo i coefficienti del polinomio interpolatore
    coeff = polyfit(x, y, grado);

    % 3. Valuto il polinomio nei punti s
    t = polyval(coeff, s);

end