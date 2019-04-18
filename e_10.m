%% Exerc�cio 10
%Reset do ambiente de trabalho
clear;
close all;

%Valores do intervalo +-yl no qual a comuta��o se torna linear para testar
yl = [0, 0.2, 0.4];

%Vector de posi��es e velocidades para criar meshgrid de teste do
%controlador
y = linspace (-2, 2);
dy = linspace (-2, 2);

[Y, dY] = meshgrid(y, dy);

for n = 1:length(yl)
    %Inicializa��o de u com zeros em todos os indexes
    U = zeros(size(Y));

    %Calculo dos k's
    k1 = 1/yl(n);
    k2 = sqrt(2*k1);

    %Subsys por ramos com entrada de -y
    idx = find(abs(Y) <= yl(n));
    U(idx) = (k1/k2)*-Y(idx);

    idx = find(abs(Y) > yl(n));
    U(idx) = sign( -Y(idx) ).*(sqrt(2.*abs( -Y(idx) ))-(1/k2));

    %Subtrac��o de dy
    U = U - dY;

    %Aplica��o do ganho k2
    U = U * k2;

    %Filtro de satura��o
    U(U > 1) = 1;
    U(U < -1) = -1;

    figure;
    surf(y, dy, U);
    view(70, 40);
    grid on;
    title(sprintf('Varia��o do Sinal de Controlo (u) para y_l=%.1f', yl(n)));
    xlabel('Posi��o (y)');
    ylabel('Velocidade ($\dot{y}$)', 'Interpreter', 'latex');
    zlabel('Sinal de Controlo (u)');
end

%%
% *Coment�rios:* 
% 
% Pela an�lise do diagrama de blocos da Fig.5 do relat�rio
% verificou-se que o sistema consistia do Subsys dado pela equa��o de dois
% ramos:
%
% $u(y, \dot{y}) =  \frac{k1}{k2}*x$, $|x| \leq y_l$
%
% $u(y, \dot{y}) =  sgn(x)[\sqrt(2|x|)-\frac{1}{k2}]$, $|x| > y_l$
%
% Alimentado pela subtra��o entre o sinal de Refer�ncia e y que neste caso
% � dado por:
%
% $x = Ref-y = 0 - y = -y$
%
% De seguida � sa�da do Subsys � subtra�do $\dot{y}$ gerando um sinal ao �
% aplicado um ganho k2 que por sua vez � filtrado limitando os valores
% superiores a 1 e inferiores a -1.
% 
% Este sistema tem um princ�pio de funcionamento semelhante ao da quest�o
% anterior diferindo nos pontos dentro do intervalo de yl no qual a
% derivada da fun��o do Subsys n�o tende para infinito, ou seja, n�o existe
% a mesma discrepancia entre valores perto da origem, logo em vez da cabe�a 
% do disco oscilar constantemente � volta da orgirem (caso da Fig.1) temos uma
% desacelara��o mais suave � medida que se aproxima do valor de refer�ncia 
% evitando assim o comportamento de chattering. Tamb�m podemos concluir da
% Fig.2 e Fig.3 que quanto maior for esse intervalo, yl, mais sauve � a
% desacelara��o. Por isso deve se escolher yl de maneira a n�o prejudicar
% muito o tempo que a cabe�a leva a chegar a posi��o de refer�ncia, ou
% seja, o mais pequeno poss�vel que evite o comportamento de chattering.
%
% Este � um melhor sistema que o anterior.