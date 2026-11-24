function [x, iter, scarti] = secvariabile(f, x0, x1, tol, itmax)
% SECVARIABILE: Calcolo uno zero di f(x) con il metodo delle secanti (secante variabile).
%
% Input:
%   f      funzione di cui cerco lo zero (function handle)
%   x0     primo punto iniziale
%   x1     secondo punto iniziale
%   tol    tolleranza sullo scarto |x_(k+1) - x_k|
%   itmax  numero massimo di iterazioni
%
% Output:
%   x       vettore delle approssimazioni (x(1) = x0, x(2) = x1, x(k+2) = x_(k+1))
%   iter    numero di iterazioni eseguite (nuovi punti calcolati)
%   scarti  vettore degli scarti x_k - x_(k-1) (con segno), il primo è x1 - x0

% Inizializzo le variabili
iter = 0;                 % Contatore delle iterazioni
xoldold = x0;             % x_(k-1)
xold = x1;                % x_k
foldold = feval(f, x0);   % f(x_(k-1)): la salvo per non ricalcolarla
x = [x0; x1];             % Vettore delle approssimazioni: i primi due elementi sono x0 e x1
dif = x1 - x0;            % Primo scarto (tra i due punti iniziali)
scarti = dif;             % Vettore degli scarti: il primo è x1 - x0 (slide 30)

while (abs(dif) > tol) && (iter < itmax)
    % 1. Calcolo f nel punto corrente
    fold = feval(f, xold);

    % 2. Se f(xold) = 0 ho trovato lo zero esatto: mi fermo
    if fold == 0
        return;
    end

    % 3. Calcolo la pendenza della secante e controllo che non sia nulla (divisione per zero)
    h = (fold - foldold) / (xold - xoldold);
    if h == 0
        disp('Errore: secante orizzontale, il metodo delle secanti non può proseguire');
        return;
    end

    % 4. Calcolo lo scarto e la nuova approssimazione
    dif = -fold / h;
    xnew = xold + dif;

    % 5. Aggiorno il contatore e salvo i risultati
    iter = iter + 1;
    x = [x; xnew];
    scarti = [scarti; dif];

    % 6. Faccio scorrere le variabili per il passo successivo (slide 29: MOLTO IMPORTANTE)
    xoldold = xold;   foldold = fold;   % x_k diventa x_(k-1)
    xold = xnew;                        % x_(k+1) diventa x_k
end

% Avviso se mi sono fermato per il numero massimo di iterazioni
if (iter == itmax) && (abs(dif) > tol)
    disp('Attenzione: raggiunto il numero massimo di iterazioni senza convergenza');
end
end