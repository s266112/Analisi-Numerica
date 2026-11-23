% CONVERGENZA: Confronto l'errore ||f - p_k||_inf nell'interpolare la
%              funzione di Runge f(x) = 1/(1+x^2) in [-5, 5] su nodi
%              equispaziati, CGL e CG, con gradi k = 1, 3, 5, ..., 31.
% ------------------------------------------------------------------------

clear; clc;

% --- Parametri di input ---
f    = @(x) 1 ./ (1 + x.^2);    % Funzione di Runge
a    = -5;                      % Estremo sinistro dell'intervallo
b    =  5;                      % Estremo destro dell'intervallo
s    = linspace(a, b, 1000)';   % Griglia fine su cui calcolo l'errore
kvec = (1:2:31)';               % Gradi richiesti dalla consegna

% Spengo il warning di polyfit sul cattivo condizionamento (gradi alti)
warning('off', 'MATLAB:polyfit:RepeatedPointsOrRescale');

% Apro il file di output
fid = fopen('convergenza.txt', 'w');


% --- Punto f: errori al variare del grado ---

% Inizializzo i vettori degli errori
Eeq  = [];                      % Errori in norma infinito, nodi equispaziati
Ecgl = [];                      % Errori in norma infinito, nodi CGL
Ecg  = [];                      % Errori in norma infinito, nodi CG

for k = kvec'
    % 1. Calcolo i nodi (grado k => k+1 nodi)
    xeq  = linspace(a, b, k + 1)';
    xcgl = chebgausslob(a, b, k + 1);
    xcg  = chebgauss(a, b, k + 1);

    % 2. Calcolo le interpolanti sulla griglia fine
    peq  = interpol(xeq,  f(xeq),  s);
    pcgl = interpol(xcgl, f(xcgl), s);
    pcg  = interpol(xcg,  f(xcg),  s);

    % 3. Calcolo l'errore in norma infinito e lo salvo
    Eeq  = [Eeq;  max(abs(f(s) - peq))];
    Ecgl = [Ecgl; max(abs(f(s) - pcgl))];
    Ecg  = [Ecg;  max(abs(f(s) - pcg))];
end

% Riaccendo il warning
warning('on', 'MATLAB:polyfit:RepeatedPointsOrRescale');

% Stampo la tabella degli errori (a video e su file)
for out = [1 fid]
    fprintf(out, '\nPUNTO F: ERRORI ||f - p_k||_inf PER LA FUNZIONE DI RUNGE\n');
    fprintf(out, '%s\n', repmat('-', 1, 56));
    fprintf(out, '%-6s %15s %15s %15s\n', 'Grado', 'Err. Equisp.', 'Err. CGL', 'Err. CG');
    fprintf(out, '%s\n', repmat('-', 1, 56));
    for i = 1:length(kvec)
        fprintf(out, '%-6d %15.4e %15.4e %15.4e\n', kvec(i), Eeq(i), Ecgl(i), Ecg(i));
    end
    fprintf(out, '%s\n', repmat('-', 1, 56));
end

% Grafico degli errori in scala semilogaritmica
figure(8);
% 1. Disegno gli errori per i tre tipi di nodi
semilogy(kvec, Eeq,  'rs-', 'LineWidth', 1.5, 'MarkerSize', 7); hold on;
semilogy(kvec, Ecgl, 'bo-', 'LineWidth', 1.5, 'MarkerSize', 7);
semilogy(kvec, Ecg,  'g^-', 'LineWidth', 1.5, 'MarkerSize', 7);

% 2. Aggiungo titolo, etichette, legenda e griglia
title('Errore di interpolazione per la funzione di Runge al variare del grado');
xlabel('grado k');
ylabel('||f - p_k||_\infty');
legend('Equisp.', 'CGL', 'CG', 'Location', 'northwest');
xlim([0 32]);
ylim([1e-3, 1e3]);
grid on;
hold off;


% --- Chiusura file ---
fclose(fid);