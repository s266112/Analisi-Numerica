%------------------------------------------
% ESERCIZIO: Calcolo errore relativo della funzione: (1+x)-1
%-------------------------------------

% Definisco l'intervallo degli esponenti (Vettore riga da 1 a 15)
esp=1:15;

% Genero i valori di test per x (Calcolo le potenze)
x=10.^-esp;

% Calcolo il risultato
ris=(1+x)-1;

% Calcolo dell'errore relativo rispetto alla soluzione esatta
errrel=abs(x-ris)./abs(x);  % Uso "./" per dividere elemento per elemento

% Preparo i dati per stamparli a schermo
A=[x' ris' errrel'];        % Uso (') per trasporre i vettorri da riga a colonna

% Stampo le intestazioni della tabella
% (s = stringa, il numero indica lo spazio riservato per allineare il testo)
fprintf('%14s %20s %17s \n','x','(1+x)-1', 'Err-rel');

% Stampo i valori veri e propri
% NB: Passo "A'" (la trasposta di A) perché la funzione fprintf di MATLAB legge le matrici scendendo per le colonne, non per le righe!
fprintf('%17.3e %24.15e %10.2e \n',A');

% Grafico degli errori relativi
loglog(x,errrel,'b-*');
title('Errore relativo su (1+x)-1')
xlabel('x')
ylabel('Errore relativo')