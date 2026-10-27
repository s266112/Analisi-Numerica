function [x, iter, scarti] = newtonmod(f, df, x0, tol, itmax, r)
%----------------------------------------------------------------
% NEWTONMOD: calcola una radice multipla della funzione f
% usando il metodo di Newton modificato con molteplicità r
% test di arresto sullo scarto
%----------------------------------------------------------------
% [x, iter, scarti] = newtonmod(f, df, x0, tol, itmax, r)
%----------------------------------------------------------------
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

xold = x0;
x = x0;
scarti = [];
dif = tol + 1;
iter = 0;

while abs(dif) > tol && iter < itmax
    fx = feval(f, xold);
    if fx == 0
        return
    end

    dfx = feval(df, xold);
    if dfx == 0
        disp('ERRORE: derivata nulla.');
        return
    end

    iter = iter + 1;
    dif = -r * fx / dfx;
    xnew = xold + dif;

    x = [x, xnew];
    scarti = [scarti, dif];
    xold = xnew;
end

if iter >= itmax
    disp('raggiunto il numero massimo di iterazioni')
end
end