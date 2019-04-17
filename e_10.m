% <html><h3>Exercício 10</h3></html>
%Reset do ambiente de trabalho
clear;
close all;

%Tempo da simulação
ttotal = 10;

%Escolha do intervalo +-yl no qual a comutação se torna linear
yl = 0;

%Vector de posições e velocidades para criar meshgrid de teste do
%controlador
y = linspace (-2, 2);
dy = linspace (-2, 2);

[Y, dY] = meshgrid(y, dy);

%Inicialização de u com zeros em todos os indexes
U = zeros(size(Y));

%Calculo dos k's
k1 = 1/yl;
k2 = sqrt(2*k1);

%Subsys por ramos com entrada de -y
idx = find(abs(Y) <= yl);
U(idx) = (k1/k2)*-Y(idx);

idx = find(abs(Y) > yl);
U(idx) = sign( -Y(idx) ).*(sqrt(2.*abs( -Y(idx) ))-(1/k2));

%Subtracção de dy
U = U - dY;

%Aplicação do ganho k2
U = U * k2;

%Filtro de saturação
U(U > 1) = 1;
U(U < -1) = -1;

surf(y, dy, U);
view(70, 40);
grid on;