% CONFRONTO: Calcolo e confronto i nodi di Chebyshev-Gauss (CG) e di
%            Chebyshev-Gauss-Lobatto (CGL) in [-1, 1] per n = 5 e n = 35.
% ------------------------------------------------------------------------

clear; clc;

% --- Parametri di input ---
a = -1;                         % Estremo sinistro dell'intervallo
b =  1;                         % Estremo destro dell'intervallo
nvec = [5 35];                  % Numeri di nodi richiesti dalla consegna
nfig = [4 5];                   % Numeri di figura (diversi da script_nodi)

% Apro il file di output
fid = fopen('confronto.txt', 'w');


% --- Punto d: confronto tra nodi CG e CGL ---

% Stampo l'intestazione della tabella riassuntiva (a video e su file)
for out = [1 fid]
    fprintf(out, '\nPUNTO D: CONFRONTO TRA NODI CG E CGL\n');
    fprintf(out, '%s\n', repmat('-', 1, 62));
    fprintf(out, '%-6s %18s %18s %16s\n', 'n', 'CG: x_1 - a', 'CGL: x_1 - a', 'CGL estremi?');
    fprintf(out, '%s\n', repmat('-', 1, 62));
end

for i = 1:length(nvec)

    % 1. Calcolo i nodi CG e CGL
    n    = nvec(i);
    xgc  = chebgauss(a, b, n);
    xgcl = chebgausslob(a, b, n);

    % 2. Calcolo la distanza del primo nodo dall'estremo a
    dcg  = xgc(1)  - a;
    dcgl = xgcl(1) - a;

    % 3. Controllo se i CGL contengono entrambi gli estremi
    if (xgcl(1) == a) && (xgcl(end) == b)
        estremi = 'si';
    else
        estremi = 'no';
    end

    % 4. Stampo la riga della tabella
    for out = [1 fid]
        fprintf(out, '%-6d %18.14f %18.14f %16s\n', n, dcg, dcgl, estremi);
    end

    % 5. Grafico dei nodi CG e CGL
    figure(nfig(i));
    % 1. Disegno i nodi CG (sopra) e CGL (sotto)
    plot(xgc,  ones(n, 1),  'rs', 'LineWidth', 1.5, 'MarkerSize', 8); hold on;
    plot(xgcl, zeros(n, 1), 'b*', 'LineWidth', 1.5, 'MarkerSize', 8);

    % 2. Disegno gli estremi dell'intervallo come linee verticali tratteggiate
    xline(a, 'k--', 'LineWidth', 1.5);
    xline(b, 'k--', 'LineWidth', 1.5);

    % 3. Aggiungo titolo, etichette, legenda e griglia
    title(sprintf('Confronto tra nodi CG e CGL in [-1, 1] (n = %d)', n));
    xlabel('x');
    yticks([0 1]);
    yticklabels({'CGL', 'CG'});
    legend('Nodi CG', 'Nodi CGL', 'Estremi a, b', 'Location', 'southoutside', 'Orientation', 'horizontal');
    xlim([a - 0.1, b + 0.1]);
    ylim([-0.5 1.5]);
    grid on;
    hold off;

end

for out = [1 fid]
    fprintf(out, '%s\n', repmat('-', 1, 62));
end

% Stampo i nodi CG e CGL affiancati per n = 5
n    = nvec(1);
xgc  = chebgauss(a, b, n);
xgcl = chebgausslob(a, b, n);
for out = [1 fid]
    fprintf(out, '\nPUNTO D: NODI CG E CGL AFFIANCATI (n = %d)\n', n);
    fprintf(out, '%s\n', repmat('-', 1, 45));
    fprintf(out, '%-6s %18s %18s\n', 'k', 'x_k (CG)', 'x_k (CGL)');
    fprintf(out, '%s\n', repmat('-', 1, 45));
    for k = 1:n
        fprintf(out, '%-6d %18.14f %18.14f\n', k, xgc(k), xgcl(k));
    end
    fprintf(out, '%s\n', repmat('-', 1, 45));
end


% --- Chiusura file ---
fclose(fid);