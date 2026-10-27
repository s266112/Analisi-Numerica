% ---- Definizione della funzione e della derivata ----

f = @(x) x.^2 - 2;  % Funzione
df = @(x) 2*x;      % Derivata prima
a = -2;             % Intervalli
b = 2;


% --- Parametri di input ---
tol = 1e-8;
itmax = 50;
x0 = 1.5;       % Punto iniziale


% --- Grafico della funzione ---
figure(1);
fplot(f, [a b], 'b-'); 
hold on;
plot([a b], [0 0], 'k-');
hold off;
title('Funzione f(x) = x^2 - 2');


% --- Chiamata alla function newton ---
[xN, iterN, scartiN] = newton(f, df, x0, tol, itmax);


% --- Stampa a video dei risultati ---
fprintf('\n [k]: %2.0f \t [xk]: %10.15f \t [dif]: \n', 1, xN(1));
for k = 2:iterN+1
    fprintf(' [k]: %2.0f \t [xk]: %10.15f \t [dif]: %10.2e\n', k, xN(k), scartiN(k-1));
end
fprintf('\n');


% --- Creazione del profilo di convergenza ---
figure(2);
semilogy(1:iterN, abs(scartiN), 'm-*', 'LineWidth', 1.5);
title('Profilo di convergenza del metodo di Newton');
xlabel('Iterazioni');
ylabel('Scarto');
legend('Newton');
grid on; % Aggiunge la griglia, utile per leggere i grafici


% --- Salvataggio del grafico ---
print -dpng profilo_newton.png; % Salva la figura corrente come immagine PNG

