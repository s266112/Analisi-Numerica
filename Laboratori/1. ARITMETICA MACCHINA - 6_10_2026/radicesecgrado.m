%------------------------------------------
% ESERCIZIO: Calcolo della radice dell'equzione : x^2 + 2px - q = 0
%------------------------------------------

clear; clc; % Pulisco sempre workspace e command window prima di iniziare

% Caso test 1 (Definiamo i parametri p, q e la soluzione esatta per confronto)
p = 1000; 
q = 0.018000000081; 
sol = 0.9 * 10^(-5);

% ALGORITMO 1 (Formula classica: y = -p + sqrt(p^2 + q))
s = p^2;
t = s + q; % Questo è l'argomento della nostra radice (il "delta" in un certo senso)

% Controllo che t sia maggiore o uguale a zero per garantire radici reali
if t >= 0
    u = sqrt(t);
else
    % Se t è negativo, stampo un avviso a schermo e non calcolo la radice
    fprintf('\n \t [RADICI COMPLESSE]');
end

% Calcolo della radice usando la sottrazione (Qui si nasconde l'instabilità!)
s1 = -p + u;

% Vado a capo per staccare i risultati dal metodo successivo
fprintf('\n');

% ALGORITMO 2 (Formula razionalizzata per evitare la cancellazione)
s = p^2;
t = s + q;

if t >= 0
    u = sqrt(t);
else
    fprintf('\n \t [RADICI COMPLESSE]');
end

% Invece di sottrarre, sommiamo p alla radice e facciamo la divisione
v = p + u;
t1 = q / v;

% STAMPA RISULTATI
fprintf('\n \t [ALG.1]: %10.16f', s1);
fprintf('\n \t [ALG.2]: %10.16f', t1);

if (sol ~= 0)
    rerr1 = abs(s1 - sol) / abs(sol);
    rerr2 = abs(t1 - sol) / abs(sol);

    % Aggiungiamo un andata a capo vuota e magari un separatore per "staccare"
    fprintf('\n'); 
    fprintf('\n \t --- ERRORI RELATIVI ---');

    fprintf('\n \t [REL.ERR.ALG.1]: %2.2e', rerr1);
    fprintf('\n \t [REL.ERR.ALG.2]: %2.2e', rerr2);
end
fprintf('\n\n'); % Doppio a capo finale per staccare dal prompt di MATLAB

