%------------------------------------------
% ESERCIZIO: Calcolo errore relativo della funzione: (1+x)-1
%-------------------------------------

clear; clc;  % Pulisco workspace e command window

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
fprintf('%17s %24s %10s \n','x','(1+x)-1', 'Err-rel');  % Stesse larghezze dei dati (17, 24, 10)

% Stampo i valori veri e propri
% NB: Passo "A'" (la trasposta di A) perché la funzione fprintf di MATLAB legge le matrici scendendo per le colonne, non per le righe!
fprintf('%17.3e %24.15e %10.2e \n',A');

% --- Grafico degli errori relativi ---
figure;
% 1. Disegno l'errore relativo in scala bilogaritmica
loglog(x, errrel, 'b-*', 'LineWidth', 1.5);
hold on;  % Mantengo la figura per la retta di riferimento

% 2. Disegno la stima teorica dell'errore: eps/x
loglog(x, eps ./ x, 'r--', 'LineWidth', 1.5);
hold off;

% 3. Aggiungo titolo, etichette, legenda e griglia
title('Errore relativo su (1+x)-1');
xlabel('x');
ylabel('Errore relativo');
legend('Errore relativo calcolato', 'Stima eps/x', 'Location', 'northeast');
grid on;

% --- Salvataggio del grafico per il README ---
if ~exist('img', 'dir'), mkdir('img'); end                     % Creo la cartella img se non esiste
exportgraphics(gcf, 'img/errori.png', 'Resolution', 150);      % Salvo la figura corrente in PNG