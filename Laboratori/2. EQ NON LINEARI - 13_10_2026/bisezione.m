function [vc, k, semilunghezza, residuopesato] = bisezione(a, b, tolintv, tolres, maxit, f)
% BISEZIONE: Calcolo uno zero di f(x) in [a, b] con il metodo di bisezione.
%
% Input:
%   a, b     estremi dell'intervallo iniziale (con f(a)*f(b) < 0)
%   tolintv  tolleranza sulla semilunghezza dell'intervallo
%   tolres   tolleranza sul residuo pesato
%   maxit    numero massimo di iterazioni
%   f        funzione di cui cerco lo zero (function handle)
%
% Output:
%   vc             vettore dei punti medi calcolati
%   k              numero di iterazioni eseguite
%   semilunghezza  vettore delle semilunghezze degli intervalli
%   residuopesato  vettore dei residui pesati |f(c) * w|

% Inizializzo le variabili
vc = [];              % Vettore dei punti medi (vuoto all'inizio)
semilunghezza = [];   % Vettore delle semilunghezze
residuopesato = [];   % Vettore dei residui pesati
k = 0;                % Contatore delle iterazioni

% Se gli estremi sono invertiti li scambio
if b < a
    s = b; b = a; a = s;
end

fa = feval(f, a);   % Valore di f nell'estremo sinistro
fb = feval(f, b);   % Valore di f nell'estremo destro

% Se uno degli estremi è già uno zero, ho finito
if fa == 0
    vc = a; semilunghezza = (b - a)/2; residuopesato = 0;
    return;
end
if fb == 0
    vc = b; semilunghezza = (b - a)/2; residuopesato = 0;
    return;
end

% Controllo che f cambi segno agli estremi (ipotesi del metodo)
if sign(fa) == sign(fb)
    disp('Errore: f(a) e f(b) hanno lo stesso segno, la bisezione non è applicabile');
    return;
end

for index = 1:maxit
    % 1. Calcolo il punto medio e il valore di f in esso
    c = (a + b)/2;
    fc = feval(f, c);

    % 2. Calcolo la semilunghezza dell'intervallo corrente
    semilun = (b - a)/2;

    % 3. Calcolo il residuo pesato |f(c) * w|, con w = (b - a) / (f(b) - f(a))
    den = fb - fa;
    if den == 0
        disp('Errore: f(b) - f(a) = 0, divisione per zero nel residuo pesato');
        return;
    end
    w = (b - a)/den;
    wres = abs(fc * w);

    % 4. Aggiorno il contatore e salvo i risultati
    k = index;
    vc = [vc; c];
    semilunghezza = [semilunghezza; semilun];
    residuopesato = [residuopesato; wres];

    % 5. Test di arresto: residuo pesato, semilunghezza oppure zero esatto
    if (wres < tolres) || (semilun < tolintv) || (fc == 0)
        return;
    end

    % 6. Scelgo la metà dell'intervallo in cui f cambia segno
    if sign(fc) == sign(fa)
        a = c; fa = fc;
    else
        b = c; fb = fc;
    end
end

% Avviso se mi sono fermato per il numero massimo di iterazioni
disp('Attenzione: raggiunto il numero massimo di iterazioni senza convergenza');
end