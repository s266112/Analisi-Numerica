% NODI: Calcolo e disegno i nodi di Chebyshev-Gauss (CG) e di
%       Chebyshev-Gauss-Lobatto (CGL) nell'intervallo [-1, 1].
% ------------------------------------------------------------------------

clear; clc; close all;

% --- Parametri di input ---
a = -1;                         % Estremo sinistro dell'intervallo
b =  1;                         % Estremo destro dell'intervallo
mvec = [10 20];                 % Numeri di nodi da confrontare

% Apro il file di output
fid = fopen('nodi.txt', 'w');


% --- Punto a: nodi di Chebyshev-Gauss ---

% Calcolo i nodi CG per m = 10 e m = 20
xcg10 = chebgauss(a, b, mvec(1));
xcg20 = chebgauss(a, b, mvec(2));

% Calcolo le distanze tra nodi consecutivi
dcg10 = diff(xcg10);
dcg20 = diff(xcg20);

% Stampo la tabella dei nodi CG con m = 10 (a video e su file)
for out = [1 fid]
    fprintf(out, '\nPUNTO A: NODI DI CHEBYSHEV-GAUSS (m = %d)\n', mvec(1));
    fprintf(out, '%s\n', repmat('-', 1, 45));
    fprintf(out, '%-6s %18s %18s\n', 'k', 'x_k', 'x_{k+1} - x_k');
    fprintf(out, '%s\n', repmat('-', 1, 45));
    for k = 1:mvec(1)
        if k < mvec(1)
            fprintf(out,'%-6d %18.14f %18.14f\n', k, xcg10(k), dcg10(k));
        else
            fprintf(out, '%-6d %18.14f %18s\n', k, xcg10(k), '-');
        end
    end
    fprintf(out, '%s\n', repmat('-', 1, 45));
end

% Stampo il confronto tra distanza agli estremi e al centro
for out = [1 fid]
    fprintf(out, '\nPUNTO A: DISTANZE TRA NODI CG CONSECUTIVI\n');
    fprintf(out, '%s\n', repmat('-', 1, 58));
    fprintf(out, '%-6s %15s %15s %18s\n', 'm', 'dist. estremi', 'dist. centro', 'centro / estremi');
    fprintf(out, '%s\n', repmat('-', 1, 58));
    fprintf(out, '%-6d %15.4e %15.4e %18.4f\n', mvec(1), min(dcg10), max(dcg10), max(dcg10)/min(dcg10));
    fprintf(out, '%-6d %15.4e %15.4e %18.4f\n', mvec(2), min(dcg20), max(dcg20), max(dcg20)/min(dcg20));
    fprintf(out, '%s\n', repmat('-', 1, 58));
end

% Grafico dei nodi CG
figure(1);
    % 1. Disegno i nodi con m = 10 (sopra) e m = 20 (sotto)
    plot(xcg10, ones(mvec(1), 1), 'rs', 'LineWidth', 1.5, 'MarkerSize', 8); hold on;
    plot(xcg20, zeros(mvec(2), 1), 'bo', 'LineWidth', 1.5, 'MarkerSize', 6);

    % 2. Disegno gli estremi dell'intervallo come linee verticali tratteggiate
    xline(a, 'k--', 'LineWidth', 1.5);
    xline(b, 'k--', 'LineWidth', 1.5);

    % 3. Aggiungo titolo, etichette, legenda e griglia
    title('Nodi di Chebyshev-Gauss in [-1, 1]');
    xlabel('x');
    ylabel('m');
    yticks([0 1]);
    yticklabels({'m = 20', 'm = 10'});
    legend('CG, m = 10', 'CG, m = 20', 'Estremi a, b', 'Location', 'southoutside', 'Orientation', 'horizontal');
    xlim([a - 0.1, b + 0.1]);
    ylim([-0.5 1.5]);
    grid on;
    hold off;

% --- Punto b: nodi di Chebyshev-Gauss-Lobatto ---

% Calcolo i nodi CGL per m = 10 e m = 20
xcgl10 = chebgausslob(a, b, mvec(1));
xcgl20 = chebgausslob(a, b, mvec(2));

% Calcolo le distanze tra nodi consecutivi
dcgl10 = diff(xcgl10);
dcgl20 = diff(xcgl20);

% Stampo la tabella dei nodi CGL con m = 10 (a video e su file)
for out = [1 fid]
    fprintf(out, '\nPUNTO B: NODI DI CHEBYSHEV-GAUSS-LOBATTO (m = %d)\n', mvec(1));
    fprintf(out, '%s\n', repmat('-', 1, 45));
    fprintf(out, '%-6s %18s %18s\n', 'k', 'x_k', 'x_{k+1} - x_k');
    fprintf(out, '%s\n', repmat('-', 1, 45));
    for k = 1:mvec(1)
        if k < mvec(1)
            fprintf(out, '%-6d %18.14f %18.14f\n', k, xcgl10(k), dcgl10(k));
        else
            fprintf(out, '%-6d %18.14f %18s\n', k, xcgl10(k), '-');
        end
    end
    fprintf(out, '%s\n', repmat('-', 1, 45));
end

% Stampo il confronto tra distanza agli estremi e al centro
for out = [1 fid]
    fprintf(out, '\nPUNTO B: DISTANZE TRA NODI CGL CONSECUTIVI\n');
    fprintf(out, '%s\n', repmat('-', 1, 58));
    fprintf(out, '%-6s %15s %15s %18s\n', 'm', 'dist. estremi', 'dist. centro', 'centro / estremi');
    fprintf(out, '%s\n', repmat('-', 1, 58));
    fprintf(out, '%-6d %15.4e %15.4e %18.4f\n', mvec(1), min(dcgl10), max(dcgl10), max(dcgl10)/min(dcgl10));
    fprintf(out, '%-6d %15.4e %15.4e %18.4f\n', mvec(2), min(dcgl20), max(dcgl20), max(dcgl20)/min(dcgl20));
    fprintf(out, '%s\n', repmat('-', 1, 58));
end

% Grafico dei nodi CGL
figure(2);
    % 1. Disegno i nodi con m = 10 (sopra) e m = 20 (sotto)
    plot(xcgl10, ones(mvec(1), 1), 'rs', 'LineWidth', 1.5, 'MarkerSize', 8); hold on;
    plot(xcgl20, zeros(mvec(2), 1), 'bo', 'LineWidth', 1.5, 'MarkerSize', 6);

    % 2. Disegno gli estremi dell'intervallo come linee verticali tratteggiate
    xline(a, 'k--', 'LineWidth', 1.5);
    xline(b, 'k--', 'LineWidth', 1.5);

    % 3. Aggiungo titolo, etichette, legenda e griglia
    title('Nodi di Chebyshev-Gauss-Lobatto in [-1, 1]');
    xlabel('x');
    ylabel('m');
    yticks([0 1]);
    yticklabels({'m = 20', 'm = 10'});
    legend('CGL, m = 10', 'CGL, m = 20', 'Estremi a, b', 'Location', 'southoutside', 'Orientation', 'horizontal');
    xlim([a - 0.1, b + 0.1]);
    ylim([-0.5 1.5]);
    grid on;
    hold off;

% --- Punto c: interpretazione geometrica dei nodi CGL ---

% Calcolo gli angoli equispaziati e i punti sulla semicirconferenza
m     = mvec(1);                % Numero di punti (uso m = 10)
theta = pi * (0:m-1)' / (m-1);  % Angoli equispaziati theta_k = k*pi/(m-1)
xp    = cos(theta);             % Ascisse dei punti sulla semicirconferenza
yp    = sin(theta);             % Ordinate dei punti sulla semicirconferenza

% Verifico che le proiezioni coincidano con i nodi CGL
errgeo = max(abs(sort(xp) - xcgl10));

% Stampo il risultato della verifica (a video e su file)
for out = [1 fid]
    fprintf(out, '\nPUNTO C: VERIFICA INTERPRETAZIONE GEOMETRICA (m = %d)\n', m);
    fprintf(out, '%s\n', repmat('-', 1, 58));
    fprintf(out, '%-40s %15.4e\n', 'max |proiezioni - nodi CGL|', errgeo);
    fprintf(out, '%s\n', repmat('-', 1, 58));
end

% Grafico dell'interpretazione geometrica
figure(3);
    % 1. Disegno la semicirconferenza di raggio 1
    tt = linspace(0, pi, 500);
    plot(cos(tt), sin(tt), 'k-', 'LineWidth', 1.5); hold on;

    % 2. Disegno i punti equispaziati sulla semicirconferenza
    plot(xp, yp, 'bo', 'LineWidth', 1.5, 'MarkerSize', 7);

    % 3. Disegno le proiezioni verticali sull'asse x
    for k = 1:m
        plot([xp(k) xp(k)], [0 yp(k)], 'b--', 'LineWidth', 1);
    end

    % 4. Disegno l'asse x e i nodi CGL proiettati
    plot([-1.1 1.1], [0 0], 'k-', 'LineWidth', 1);
    plot(xcgl10, zeros(m, 1), 'rs', 'LineWidth', 1.5, 'MarkerSize', 8);

    % 5. Aggiungo titolo, etichette, legenda e griglia
    title('Interpretazione geometrica dei nodi di Chebyshev-Gauss-Lobatto (m = 10)');
    xlabel('x');
    ylabel('y');
    legend('Semicirconferenza', 'Punti equispaziati', 'Proiezioni', 'Location', 'northeast');
    axis equal;
    xlim([-1.2 1.2]);
    ylim([-0.2 1.2]);
    grid on;
    hold off;


% --- Chiusura file ---
fclose(fid);