
% --- Parametri di input (caso test) ---
e = 1e-2;           % Scabrezza del tubo 
d = 0.20;           % Diametro del tubo 
NR = 1e4;           % Numero di Reynolds

TOL = 1e-7;         % Tolleranza del test di arresto
nmax = 100;         % Numero massimo di iterazioni consentite

% 1. Calcolo i termini costanti per semplificare l'equazione
A = e / (3.51 * d);
B = 2.52 / NR;

% --- Punto a: Grafico di localizzazione dello zero ---

% Definisco la funzione f(x) = 0
f = @(x) 1./sqrt(x) + 2*log10 (A + B./sqrt(x));

figure (1);
    
    % 1. Disegno la funzione f(x) nell'intervallo [0.01, 0.2]
    fplot (f, [0.01, 0.2], 'b-', 'LineWidth',1.5);
    hold on;

    % 2. Disegno l'asse x
    plot ([0.01, 0.2], [0 0], 'k-');
    hold off;

    % 3. Aggiungo titolo, etichette e griglia
    title ('Localizzazione dello zero per Colebrook-White');
    xlabel ('x (fattore di frizione)');
    ylabel ('f(x)');
    grid on;


% --- Punto b: Grafico di convergenza del punto fisso ---

% Definisco la funzione di iterazione g(x)
g = @(x) 1./ (4 * (log10 (A + B./sqrt(x))).^2);

figure (2);

    % 1. Disegno la funzione di iterazione g(x)
    fplot (g, [0.01, 0.2], 'm-', 'LineWidth', 1.5);
    hold on;

    % 2. Disegno la bisettrice y = x
    fplot (@(x) x, [0.01, 0.2], 'k-', 'LineWidth', 1.5);
    hold off;

    % 3. Aggiungo titolo, etichette e griglia
    title ('Convergenza punto fisso: g(x) vs y = x');
    xlabel ('x');
    ylabel ('g(x)');
    legend ('g(x)', 'bisettrice y = x', 'Location', 'best');
    grid on;


    % --- Punto c: Risoluzione con i tre metodi ---

    % 1. Scelgo un punto iniziale opportuno (vicino alla radice vista nel grafico)
    x0 = 0.07;

    % Steffensen è molto sensibile: uso un punto ancora più vicino alla radice
    x0_steff = 0.0755;

    % 2. Chiamo le tre function (attenzione all'ordine degli output!)
    [x_pf, iter_pf, scarti_pf] = pfisso (g, x0, TOL, nmax);
    [x_sec, scarti_sec, iter_sec] = secvariabile (f, x0, TOL, nmax);
    [x_steff, scarti_steff, iter_steff] = steffensen (f, x0_steff, TOL, nmax);


    % --- Punto d: Grafico semilogaritmico dei profili di convergenza ---
    figure (3);

    % 1. Disegno gli scarti in valore assoluto per i tre metodi
    semilogy (1:iter_pf, abs(scarti_pf), 'b-*', 'LineWidth', 1.5);
    hold on;

    semilogy (1:iter_sec, abs(scarti_sec), 'r-o', 'LineWidth', 1.5);

    semilogy (1:iter_steff, abs(scarti_steff), 'm-s', 'LineWidth', 1.5);
    hold off;

    % 2. Aggiungo titolo, etichette, legenda e griglia
    title ('Profilo di convergenza: Punto Fisso vs Secanti vs Steffensen');
    xlabel ('Numero di iterazioni');
    ylabel ('Scarto (valore assoluto)');
    legend ('Punto Fisso', 'Secanti', 'Steffensen', 'Location', 'best');
    grid on;

% --- Punto e: Stampa dei risultati a video e su file ---

    % 1. Apro il file in modalità scrittura
    fid = fopen ('risultati_colebrook.txt', 'w');

    % 2. Stampo l'intestazione a video
    fprintf ('\n--- RISULTATI COLEBROOK-WHITE ---\n');
    fprintf ('%-15s %-18s %-10s %-15s\n', 'Metodo', 'Radice', 'Iterazioni', 'Ultimo scarto');
    fprintf ('---------------------------------------------------------------\n');

    % 3. Stampo i risultati a video
    fprintf ('%-15s %18.14f %10d %15.4e\n', 'Punto Fisso', x_pf(end), iter_pf, abs(scarti_pf(end)));
    fprintf ('%-15s %18.14f %10d %15.4e\n', 'Secanti', x_sec(end), iter_sec, abs(scarti_sec(end)));
    fprintf ('%-15s %18.14f %10d %15.4e\n', 'Steffensen', x_steff(end), iter_steff, abs(scarti_steff(end)));
    fprintf ('---------------------------------------------------------------\n\n');

    % 4. Scrivo i risultati sul file
    fprintf (fid, '--- RISULTATI COLEBROOK-WHITE ---\n');
    fprintf (fid, '%-15s %-18s %-10s %-15s\n', 'Metodo', 'Radice', 'Iterazioni', 'Ultimo scarto');
    fprintf (fid, '---------------------------------------------------------------\n');
    fprintf (fid, '%-15s %18.14f %10d %15.4e\n', 'Punto Fisso', x_pf(end), iter_pf, abs(scarti_pf(end)));
    fprintf (fid, '%-15s %18.14f %10d %15.4e\n', 'Secanti', x_sec(end), iter_sec, abs(scarti_sec(end)));
    fprintf (fid, '%-15s %18.14f %10d %15.4e\n', 'Steffensen', x_steff(end), iter_steff, abs(scarti_steff(end)));
    fprintf (fid, '---------------------------------------------------------------\n');

    % 5. Chiudo il file
    fclose (fid);

    fprintf ('Risultati salvati nel file risultati_colebrook.txt\n\n');

% --- Stima di p e C per la relazione (Punto 3b) ---

    % 1. Prendo come radice di riferimento l'ultima iterata di Steffensen (la più precisa)
    alpha = fzero(f, x0);

    % 2. Calcolo gli errori veri per i tre metodi
    e_pf = abs(x_pf - alpha);
    e_sec = abs(x_sec - alpha);
    e_steff = abs(x_steff - alpha);

    % 3. Apro un secondo file per i dati della relazione
    fid2 = fopen ('stima_convergenza.txt', 'w');

    fprintf (fid2, '--- STIMA ORDINE DI CONVERGENZA E COSTANTE ASINTOTICA ---\n');
    fprintf (fid2, '%-15s %-10s %-15s %-15s\n', 'Metodo', 'p', 'C', 'Errore finale');
    fprintf (fid2, '---------------------------------------------------------------\n');

    % 4. Stima p e C per il Punto Fisso
    if iter_pf >= 3
        p_pf = log(e_pf(end) / e_pf(end-1)) / log(e_pf(end-1) / e_pf(end-2));
        C_pf = e_pf(end) / (e_pf(end-1) ^ p_pf);
        fprintf (fid2, '%-15s %10.4f %15.4f %15.4e\n', 'Punto Fisso', p_pf, C_pf, e_pf(end));
        fprintf ('Punto Fisso -> p = %.4f, C = %.4f, err = %.4e\n', p_pf, C_pf, e_pf(end));
    end

    % 5. Stima p e C per le Secanti
    if iter_sec >= 3
        p_sec = log(e_sec(end) / e_sec(end-1)) / log(e_sec(end-1) / e_sec(end-2));
        C_sec = e_sec(end) / (e_sec(end-1) ^ p_sec);
        fprintf (fid2, '%-15s %10.4f %15.4f %15.4e\n', 'Secanti', p_sec, C_sec, e_sec(end));
        fprintf ('Secanti     -> p = %.4f, C = %.4f, err = %.4e\n', p_sec, C_sec, e_sec(end));
    end

    % 6. Stima p e C per Steffensen (uso le prime iterazioni, prima della precisione di macchina)
    if iter_steff >= 3
        % Uso gli errori intermedi, non gli ultimi (che sono a precisione di macchina)
        p_steff = log(e_steff(3) / e_steff(2)) / log(e_steff(2) / e_steff(1));
        C_steff = e_steff(3) / (e_steff(2) ^ p_steff);
        fprintf (fid2, '%-15s %10.4f %15.4f %15.4e\n', 'Steffensen', p_steff, C_steff, e_steff(end));
        fprintf ('Steffensen  -> p = %.4f, C = %.4f, err = %.4e\n', p_steff, C_steff, e_steff(end));
    end

    fprintf (fid2, '---------------------------------------------------------------\n');

    % 7. Chiudo il secondo file
    fclose (fid2);

    fprintf ('\nStime salvate nel file stima_convergenza.txt\n\n');