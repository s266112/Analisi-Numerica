% ---- Definizione della funzione e della derivata ----

f = @(x) x.^2 - 5*x + 6;    % Funzione (radici in x=2 e x=3)
df = @(x) 2*x - 5;          % Derivata prima
a = 1;                      % Intervalli
b = 4;


% --- Parametri di input ---
toll = 1e-8;
itmax = 100;
x0 = 3.5;       % Punto iniziale (vicino alla radice maggiore, x=3)


% --- Grafico della funzione ---
figure(1);
fplot(f, [a b], 'b-'); 
hold on;
plot([a b], [0 0], 'k-');
hold off;
title('Funzione f(x) = x^2 - 5x + 6');


% --- Chiamata alla function newton ---
[x, iterN, scarti] = newton(f, df, x0, toll, itmax);


% --- Scrittura dei risultati su file di testo ---
fid = fopen('risNewton.txt', 'w'); % Apre il file in scrittura

% Intestazione della tabella sul file
fprintf(fid, '\n [k]: %2.0f \t [xk]: %10.15f \t [dif]: \n', 1, x(1));

% Ciclo per scrivere tutte le iterazioni
for k = 2:iterN+1
    fprintf(fid, ' [k]: %2.0f \t [xk]: %10.15f \t [dif]: %10.2e\n', k, x(k), scarti(k-1));
end
fprintf(fid, '\n');

fclose(fid); % Chiude il file (FONDAMENTALE!)


% --- Creazione del profilo di convergenza ---
figure(2);
semilogy(1:iterN, abs(scarti), 'g-o', 'LineWidth', 2); % Linea verde con cerchi
title('Profilo di convergenza');
xlabel('N. iterazioni');
ylabel('Scarto');
legend('Newton');
grid on;


% --- Salvataggio del grafico ---
print -dpng profilo_newton_file.png;