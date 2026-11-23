% RUNGE: Interpolo la funzione di Runge f(x) = 1/(1+x^2) in [-5, 5] su nodi
%        equispaziati e di Chebyshev-Gauss-Lobatto (CGL): grafico del grado 12
%        e tabella degli errori in norma infinito per i gradi 2, ..., 14.
% ------------------------------------------------------------------------

clear; clc;

% --- Parametri di input ---
f    = @(x) 1 ./ (1 + x.^2);    % Funzione di Runge
a    = -5;                      % Estremo sinistro dell'intervallo
b    =  5;                      % Estremo destro dell'intervallo
s    = linspace(a, b, 1000)';   % Griglia fine su cui valuto f e le interpolanti
deg  = 12;                      % Grado del polinomio per i grafici
degvec = 2:14;                  % Gradi per la tabella (come nella slide 14)

% Apro il file di output
fid = fopen('runge.txt', 'w');


% --- Punto e1: interpolante di grado 12 ---

% 1. Calcolo i nodi (grado n => n+1 nodi)
xeq  = linspace(a, b, deg + 1)';
xcgl = chebgausslob(a, b, deg + 1);

% 2. Calcolo le interpolanti sulla griglia fine
peq  = interpol(xeq,  f(xeq),  s);
pcgl = interpol(xcgl, f(xcgl), s);

% 3. Calcolo gli errori puntuali
erreq  = abs(f(s) - peq);
errcgl = abs(f(s) - pcgl);

% Grafico della funzione e delle interpolanti di grado 12
figure(6);
    % 1. Disegno la funzione di Runge e le due interpolanti
    plot(s, f(s), 'k-',  'LineWidth', 1.5); hold on;
    plot(s, peq,  'r--', 'LineWidth', 1.5);
    plot(s, pcgl, 'b-.', 'LineWidth', 1.5);

    % 2. Disegno i nodi di interpolazione
    plot(xeq,  f(xeq),  'rs', 'LineWidth', 1.5, 'MarkerSize', 7);
    plot(xcgl, f(xcgl), 'bo', 'LineWidth', 1.5, 'MarkerSize', 7);

    % 3. Disegno l'asse x
    plot([a b], [0 0], 'k-', 'LineWidth', 0.5);

    % 4. Aggiungo titolo, etichette, legenda e griglia
    title(sprintf('Funzione di Runge e interpolanti di grado %d', deg));
    xlabel('x');
    ylabel('y');
    legend('f(x) = 1/(1+x^2)', 'Interpolante equisp.', 'Interpolante CGL', ...
           'Nodi equisp.', 'Nodi CGL', 'Location', 'south');
    xlim([a b]);
    ylim([min([peq; pcgl]) - 0.3, 1.3]);
    grid on;
    hold off;

% Grafico dell'errore puntuale di grado 12
figure(7);
    % 1. Disegno gli errori puntuali delle due interpolanti
    plot(s, erreq,  'r-', 'LineWidth', 1.5); hold on;
    plot(s, errcgl, 'b-', 'LineWidth', 1.5);

    % 2. Aggiungo titolo, etichette, legenda e griglia
    title(sprintf('Errore |f(x) - p_{%d}(x)| per la funzione di Runge', deg));
    xlabel('x');
    ylabel('errore');
    legend('Equisp.', 'CGL', 'Location', 'north');
    xlim([a b]);
    ylim([0, 1.1 * max(erreq)]);
    grid on;
    hold off;


% --- Punto e2: tabella degli errori per i gradi 2, ..., 14 ---

% Inizializzo i vettori degli errori
Eeq  = [];                      % Errori in norma infinito, nodi equispaziati
Ecgl = [];                      % Errori in norma infinito, nodi CGL

for n = degvec
    % 1. Calcolo i nodi equispaziati e CGL (n+1 nodi)
    xeq  = linspace(a, b, n + 1)';
    xcgl = chebgausslob(a, b, n + 1);

    % 2. Calcolo le interpolanti sulla griglia fine
    peq  = interpol(xeq,  f(xeq),  s);
    pcgl = interpol(xcgl, f(xcgl), s);

    % 3. Calcolo l'errore in norma infinito e lo salvo
    Eeq  = [Eeq;  max(abs(f(s) - peq))];
    Ecgl = [Ecgl; max(abs(f(s) - pcgl))];
end

% Stampo la tabella (a video e su file)
for out = [1 fid]
    fprintf(out, '\nPUNTO E2: ERRORI ||f - p_n||_inf PER LA FUNZIONE DI RUNGE\n');
    fprintf(out, '%s\n', repmat('-', 1, 40));
    fprintf(out, '%-6s %15s %15s\n', 'Grado', 'Err. Equisp.', 'Err. CGL');
    fprintf(out, '%s\n', repmat('-', 1, 40));
    for i = 1:length(degvec)
        fprintf(out, '%-6d %15.4e %15.4e\n', degvec(i), Eeq(i), Ecgl(i));
    end
    fprintf(out, '%s\n', repmat('-', 1, 40));
end


% --- Chiusura file ---
fclose(fid);