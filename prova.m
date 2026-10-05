% Test di collegamento MATLAB - GitHub
clear; clc;

disp('Ciao GitHub! MATLAB è collegato con successo.');

% Facciamo un piccolo calcolo numerico di prova
x = linspace(0, 2*pi, 100);
y = sin(x);

plot(x, y, 'LineWidth', 2);
grid on;
title('Grafico di prova - Analisi Numerica');


