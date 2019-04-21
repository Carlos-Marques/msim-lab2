%% Modela��o e Simula��o - Laborat�rio 2
%
% Carlos Silva - 81323 
%
% Ricardo Espadinha - 84178
%
% Grupo 33 - Segunda-feira, 10:00h LSDC1
%
% 2018/2019 - 2� Semestre

%% Exerc�cio 2 - Teste da Gera��o do Impulso Prot�tipo
%Reset do ambiente de trabalho
clear;
close all;

testebeta = [0.2 0.6 1];
testetempo = linspace(-1,1, 1000);

for i=1:length(testebeta)
    pb = ImpulsoPrototipo(testetempo, testebeta(i));
    
    plot(testetempo, pb, 'DisplayName', sprintf('\\beta=%.1f', testebeta(i)));
    hold on;
end

legend('Location','northeastoutside');

grid on;
xlabel('Tempo');
ylabel('Impulso Prot�tipo')
title(sprintf('Fig.1 - Fun��o de Gera��o do Impulso Prot�tipo p_\\beta(t)'));

%%
% *Coment�rios:* Verifica-se que quanto maior for o valor de beta, menor � o tempo que o
% sinal permanece a 1 (�rea total do tri�ngulo). Analisando, por exemplo, o
% caso em que $\beta=1$, numa convolu��o entre o sinal triangular e rectangular
% descritos no enunciado, o sinal triangular apenas se encontra todo
% "coberto" pelo rectangular num instante (t=0).
% Aplicando a l�gica inversa, no sinal em que $\beta=0.2$, o impulso gerado
% aproxima-se mais do rectangular.

%% Exerc�cio 3 - Teste da Gera��o do Sinal u(t)
%Reset do ambiente de trabalho
 clear;
 close all;

 T = 6;

%Fixar beta=1 (Impulso Prot�tipo aproximadamente tri�ngular) para observar o efeito de alfa
beta = 1;
U1 = -1;
U2 = 1;
n1 = 1000;
n2 = 1000;
 
testealpha = [0.5 1 2];

for i=1:length(testealpha)
    
    
    [u, ut] = sinalu(T, testealpha(i), beta, U1, U2, n1, n2);
    
    plot(ut, u, 'DisplayName', sprintf('\\alpha=%.1f', testealpha(i)));
    hold on;
end

legend('Location','northeastoutside');

grid on;
xlabel('Tempo');
ylabel('Sinal de Controlo u(t)')
title(sprintf('Fig.2 - Sinal de Controlo u(t) a partir de p_\\beta(t) (\\beta=1)'));

%%
% *Coment�rios:* Como podemos observar, a fun��o gera u(t) atrav�s do Impulso Prot�tipo.
% Fixaram-se todos os valores � excep��o do alpha, de modo a ver o impacto
% deste. Verifica-se o esperado, tendo em conta a rela��o entre T1 e T2. Por
% exemplo, para alpha=1 => T1=T2.


%% Exerc�cio 7 - Simula��o do Sistema para diversos valores de alpha e beta
%Reset do ambiente de trabalho
 clear;
 close all;

%Condi��es Iniciais
y0 = 1;
dy0 = 0;
n1 = 100;
n2 = 100;

%Testes iniciais para b=0 (Sistema n�o Perturbado)
b = 0;

%Testes fixando alpha=1 e variando beta=0.1 / beta=0.5 / beta=1
alpha = 1; %T minimo
beta = [0.1 0.5 1]; 

ydy_a = figure;
planoFase_a = figure;
sinaisU_a = figure;

for i=1:length(beta)
    
    %Fun��o que calcula U1, U2 e T de acordo com as condi��es que se
    %concluiram pela an�lise te�rica
    [U1, U2, T] = GetUsT(alpha, beta(i));
    
    %Gerar sinal u(t) e correr a simula��o
    [u, ut] = sinalu(T, alpha, beta(i), U1, U2, n1, n2);
    u_t = [ut', u'];
    sim('Q7');
    
    figure(sinaisU_a);
    plot(ut, u, 'DisplayName', sprintf('\\beta=%.1f', beta(i)));
    hold on;
    
    figure(ydy_a);
    plot(tout, dy, 'DisplayName', sprintf('dy, \\beta=%.1f', beta(i)));
    hold on;
    plot(tout, y,'DisplayName', sprintf('y, \\beta=%.1f', beta(i)));
    
    figure(planoFase_a);
    plot(y, dy, 'DisplayName', sprintf('\\beta=%.1f', beta(i)));
    hold on;
end

%Informa��o de cada plot
figure(sinaisU_a);
legend('Location','northeast');
grid on;
xlabel('Tempo');
ylabel('Sinal de Controlo u(t)')
title(sprintf('Fig.3 - Sinais de Controlo u(t) para \\alpha=1'));

figure(ydy_a);
legend('Location','northeast');
grid on;
xlabel('Tempo');
ylabel('y e dy')
title(sprintf('Fig.4 - Posi��o e Velocidade da Cabe�a Magn�tica para \\alpha=1'));

figure(planoFase_a);
legend('Location','northeast');
grid on;
xlabel('y');
ylabel('dy')
title(sprintf('Fig.5 - Plano de Fase para \\alpha=1'));

%%
% *Coment�rios:* Verifica-se que o valor de $\beta$ tem influencia em
% T (maior $\beta$ leva a um maior T).Isto � de esperar pela forma como �
% gerado o impulso Prototipo. Da mesmo forma, tamb�m � possivel observar
% que, para valores muito pequenos de $\beta$, u(t) aproxima-se de um sinal
% rect�ngular e que, pela l�gica contr�ria. para valores de $\beta$ muito
% pr�ximos de 1, u(t) aproxima-se de um sinal tri�ngular.
% Em rela��o � Posi��o e Velocidade da Cabe�a, pode-se verificar que para
% todos os casos, o sistema possui os valores finais desejados, no entanto demora
% mais tempo a atingir os mesmos quanto maior for o valor de $\beta$.


%Testes fixando beta=0.2 e variando alpha=1 / alpha=2 / alpha=4
beta = 0.1; %u(t) aproximandamente rect�ngular
alpha = [0.7 1 2]; 

ydy_b = figure;
planoFase_b = figure;
sinaisU_b = figure;


for i=1:length(alpha)
    
    %Fun��o que calcula U1, U2 e T de acordo com as condi��es que se
    %concluiram pela an�lise te�rica
    [U1, U2, T] = GetUsT(alpha(i), beta);
    
    %Gerar sinal u(t) e correr a simula��o
    [u, ut] = sinalu(T, alpha(i), beta, U1, U2, n1, n2);
    u_t = [ut', u'];
    sim('Q7');
    
    figure(sinaisU_b);
    plot(ut, u, 'DisplayName', sprintf('\\alpha=%.1f', alpha(i)));
    hold on;
    
    figure(ydy_b);
    plot(tout, dy, 'DisplayName', sprintf('dy, \\alpha=%.1f', alpha(i)));
    hold on;
    plot(tout, y,'DisplayName', sprintf('y, \\alpha=%.1f', alpha(i)));
    
    figure(planoFase_b);
    plot(y, dy, 'DisplayName', sprintf('\\alpha=%.1f', alpha(i)));
    hold on;
end

%Informa��o de cada plot
figure(sinaisU_b);
legend('Location','northeast');
grid on;
xlabel('Tempo');
ylabel('Sinal de Controlo u(t)')
title(sprintf('Fig.6 - Sinais de Controlo u(t) para \\beta=0.2'));

figure(ydy_b);
legend('Location','northeast');
grid on;
xlabel('Tempo');
ylabel('y e dy')
title(sprintf('Fig.7 - Posi��o e Velocidade da Cabe�a Magn�tica para \\beta=0.2'));

figure(planoFase_b);
legend('Location','northeast');
grid on;
xlabel('y');
ylabel('dy')
title(sprintf('Fig.8 - Plano de Fase para \\beta=0.2'));

%%
% *Coment�rios:* Fixou-se $\beta=0.2$ de forma a que u(t) fosse,
% aproximadamente, um conjunto de dois sinais rect�ngulares, como se pode
% verificar. Ainda no sinal de controlo, pode-se verificar que o $\alpha$
% possui dois tipos de influencias distintas no sinal: Para
% valores de $\alpha<1$ T1>T2 e para valores de $\alpha>1$ T1<T2; O valor de T
% � minimo para $\alpha=1$, como comprovado na parte te�rica.
% Em rela��o � Posi��o e Velocidade da Cabe�a, pode-se verificar que para
% todos os casos, o sistema possui os valores finais desejados, no entanto demora
% menos tempo a atingir os mesmos para $\alpha=1$.


%Compara��o com uma ves�o perturbada do sistema (b=0 e b=0.025)

perturbacao = [0 0.025];

%Testes fixando alpha=1 e variando beta=0.1 / beta=0.5 / beta=1
alpha = 1; %T minimo
beta = 0.1; %u(t) aproximadamente rect�ngular

ydy_pert = figure;
planoFase_pert = figure;
sinaisU_pert = figure;

%Fun��o que calcula U1, U2 e T de acordo com as condi��es que se
%concluiram pela an�lise te�rica
[U1, U2, T] = GetUsT(alpha, beta);

%Gerar u(t)
[u, ut] = sinalu(T, alpha, beta, U1, U2, n1, n2);
u_t = [ut', u'];
plot(ut, u);
grid on;
xlabel('Tempo');
ylabel('Sinal de Controlo u(t)');
title(sprintf('Fig.9 - Sinal de Controlo u(t) para \\alpha=1 e \\beta=0.1'));

for i=1:length(perturbacao)
    
    b = perturbacao(i);
    
    %Correr Simula��o
    sim('Q7');
    hold on;
    
    figure(ydy_pert);
    plot(tout, dy, 'DisplayName', sprintf('dy, b=%.3f', b));
    hold on;
    plot(tout, y,'DisplayName', sprintf('y, b=%.3f', b));
    
    figure(planoFase_pert);
    plot(y, dy, 'DisplayName', sprintf('b=%.3f', b));
    hold on;
end

%Desenhar uma linha para y, dy = 0.025
figure(ydy_pert);
plot(tout,0.025*ones(size(tout)), 'DisplayName', 'y, dy = 0.025');

%Informa��o de cada plot
legend('Location','northeast');
grid on;
xlabel('Tempo');
ylabel('y e dy');
title(sprintf('Fig.10 - Posi��o e Velocidade da Cabe�a Magn�tica para b=0 e b=0.025'));

figure(planoFase_pert);
legend('Location','northeast');
grid on;
xlabel('y');
ylabel('dy');
title(sprintf('Fig.11 - Plano de Fase para b=0 e b=0.025'));

%%
% *Coment�rios:* De acordo com os resultados anteriores, fixou-se
% $\alpha=1$
% (para que T fosse m�nimo) e $\beta=0.1$ (para que u(t) se aproxime de um
% conjunto de dois sinais rect�ngulares). Assim, obteve-se o u(t) discrito 
% anteriormente e, de forma a observar a influencia
% da perturba��o b, simulou-se esse sistema para b=0 (s/ perturba��o) e para
% b=0.0250 (c/ perturba��o). Assim, observa-se que existe uma perturba��o no
% valor final da Posi��o e da Velocidade em rela��o a valor desejado (0), 
% correspondente a b.
%
% Tamb�m � importante de notar que, para todos os casos observados,
% verifica-se a condi��o das amplitudes serem sempre <=1.


%% Exerc�cio 8 - Representa��o da fun��o de gera��o da entrada u(y, dy)

%Reset do ambiente de trabalho
 clear;
 close all;


%Vector de posi��es e velocidades para criar meshgrid de teste do
%controlador
y = linspace (-2, 2);
dy = linspace (-2, 2);

[Y, dY] = meshgrid(y, dy);

%=== Regi�o tracejada do Diagrama de Blocos ===
%s1: Sinal que entra no bloco subsys
s1 = 0 - Y;

%s2: Sinal que sai do bloco subsys
s2 = sign(s1).*sqrt(2*abs(s1));

%s3: Sinal que entra no bloco sign, composto por s2 e -dY
s3 = s2 - dY;

%U: Sinal que sai da regi�o tracejada
U = sign(s3);
%==============================================

figure;
surf(Y, dY, U);
view(45, 45);
grid on;
title('Fig.12 - u(y, $\dot{y}$)', 'Interpreter', 'latex');
xlabel('Posi��o (y)');
ylabel('Velocidade ($\dot{y}$)', 'Interpreter', 'latex');
zlabel('Sinal de Controlo (u)');
title('\textbf{Fig.13 - Fun\c{c}\~ao de gera\c{c}\~ao da entrada u(y, $\dot{y}$)}', 'Interpreter', 'latex');

figure;
contour(Y, dY, U);
grid on;
xlabel('y');
ylabel('$\dot y$','Interpreter','LaTex')
zlabel('u');
title('Fig.14 - Curva de Comuta��o');

%%
% Foi calculado que U = sign( ((sign(-Y))*(sqrt(2*abs(-Y)))) - dY). � de
% notar que, de forma a que a multiplica��o das matrizes seja feita
% elemento a elemento, em vez da multiplica��o normal de matrizes, �
% necess�rio colocar um '.' antes do '*'.
%
% Este novo sistema em cadeia fechada, comporta-se de maneira diferente do
% anterior (em malha aberta): Este sistema, procura ajustar a sua posi��o
% dinamicamente atrav�s da altera��o de valores da velocidade. Esta rela��o
% � conseguida atrav�s de trajet�rias parab�licas que, dependendo do valor
% do impulso numa dada posi��o, tendem para + ou - infinito, de forma a
% tentar sempre aproximar-se da posi��o de equil�brio.
% Isto consegue-se verificar bastante bem atrav�s da Curva de Comuta��o representada.  
 

%% Exerc�cio 9
%
%Reset do ambiente de trabalho
 clear;
 close all;

 %Simula��o do sistema em malha aberta para impulsos aproximadamente rectangulares
 
 beta = 0.1;   %Impulso aproximadamente rect�ngular
 alpha = 1;  %T minimo
 b = 0;
 n1 = 100;
 n2 = 100;
 y0 = 1;
 dy0 = 0;
 
 [U1, U2, T] = GetUsT(alpha, beta);
    
 [u, ut] = sinalu(T, alpha, beta, U1, U2, n1, n2);
 u_t = [ut', u'];
 sim('Q7');
 
 pos = figure;
 vel = figure;
 fase = figure;
 Us = figure;
 
figure(pos);
plot(tout, y, 'DisplayName', 'Malha Aberta');
title('Fig.15 - Posi��o da Cabe�a Magn�tica');
grid on;
xlabel('Tempo');
ylabel('y');
hold on;

figure(vel);
plot(tout, dy, 'DisplayName', 'Malha Aberta');
title('Fig.16 - Velocidadeo da Cabe�a Magn�tica');
grid on;
xlabel('Tempo');
ylabel('dy');
hold on;

figure(fase);
plot(y, dy, 'DisplayName', 'Malha Aberta');
title('Fig.17 - Plano de Fase');
grid on;
xlabel('Posi��o');
ylabel('Velocidade');
hold on;

figure(Us);
plot(ut, u, 'DisplayName', 'Malha Aberta');
title('Fig.18 - Sinal de Controlo u(t)');
grid on;
xlabel('Tempo');
ylabel('u');
hold on;

%Simula��o em malha fechada
t_paragem = 7;
y0 = 1;
dy0 = 0;

sim('Q9');

figure(pos);
plot(tout, y, 'DisplayName', 'Malha Fechada');
legend('Location','northeast');

figure(vel);
plot(tout, dy, 'DisplayName', 'Malha Fechada');
legend('Location','northeast');

figure(fase);
plot(y, dy, 'DisplayName', 'Malha Fechada');
legend('Location','northeast');

figure(Us);
plot(tout, u, 'DisplayName', 'Malha Fechada');
legend('Location','northeast');

%%
% *Coment�rio:*
%
% Observa-se que o sistema comporta-se de forma semelhante 
% aos anteriores, tendendo  para 0. No entanto, neste caso, o sistema nunca 
% ficar� est�vel neste ponto de equil�brio, oscilando entre valores pr�ximos 
% deste, no caso da Posi��o e Velocidade, ou encurvando em torno de (0, 0) , 
% no caso do Plano de Fase. Tamb�m se verifica uma altera��o (com uma 
% frequ�ncia cada vez maior) entre o m�ximo e o m�nimo (1 e -1).
%
% Isto � explicado, pelo facto de que na origem a derivada � infinita, 
% ou seja, o sistema n�o consegue atingir o valor de referencia, oscilando 
% � volta do mesmo. Este comportamento � o chamado chattering. Logicamente,  
% que isto � problem�tico, pois o facto do sistema nunca ficar est�vel, 
% significa fisicamente que a cabe�a nunca para, resultando numa leitura 
% incorreta dos dados no disco,  consumindo energia e componentes 
% indefinidamente.

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

%Figure counter
fc = 0;

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
    fc = fc + 1;
    surf(y, dy, U);
    view(70, 40);
    grid on;
    title(sprintf('Fig.%d - Varia��o do Sinal de Controlo (u) para y_l=%.1f', 18+fc, yl(n)));
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
% do disco oscilar constantemente � volta da orgirem (caso da Fig.19) temos uma
% desacelara��o mais suave � medida que se aproxima do valor de refer�ncia 
% evitando assim o comportamento de chattering. Tamb�m podemos concluir da
% Fig.20 e Fig.21 que quanto maior for esse intervalo, yl, mais sauve � a
% desacelara��o. Por isso deve se escolher yl de maneira a n�o prejudicar
% muito o tempo que a cabe�a leva a chegar a posi��o de refer�ncia, ou
% seja, o mais pequeno poss�vel que evite o comportamento de chattering.
%
% Este � um melhor sistema que o anterior.

%% Exerc�cio 11
% <html><h3>Controlador completo</h3></html>
%Reset do ambiente de trabalho
clear;
close all;

%Subsys com ambos os ramos
f = 1;

%Tempo de Simula��o
ttotal = 7;

%Refer�ncia escolhida
Ref = 0;

%Sem perturba��o
b = 0;

%Intervalo escolhido do exerc�cio anterior
yl = 0.2;

%Calculo dos k's
k1 = 1/yl;
k2 = sqrt(2*k1);

sim('modified_controller');

figure;
plot(tout, y);
grid on;
title('Fig.22 - Evolu��o temporal da posi��o radial da cabe�a (y)');
xlabel('Tempo');
ylabel('Posi��o (y)');

figure;
plot(tout, dy);
grid on;
title('\textbf{Fig.23 - Evolu\c{c}\~ao temporal da velocidade radial da cabe\c{c}a ($\dot{y}$)}', 'Interpreter', 'latex');
xlabel('Tempo');
ylabel('Velocidade ($\dot{y}$)','Interpreter','latex');

figure;
plot(y, dy);
grid on;
title('\textbf{Fig.24 - Velocidade em fun\c{c}\~ao da posi\c{c}\~ao da cabe\c{c}a (y, $\dot{y}$)}', 'Interpreter', 'latex');
xlabel('Posi��o (y)');
ylabel('Velocidade ($\dot{y}$)','Interpreter','latex');

figure;
plot(tout, u);
grid on;
title('\textbf{Fig.25 - Evolu\c{c}\~ao temporal do Sinal de Controlo (u(y, $\dot{y}$))}', 'Interpreter', 'latex');
xlabel('Tempo');
ylabel('Sinal de Controlo (u(y, $\dot{y}$))','Interpreter','latex');

%% 
% *Coment�rios:*
%
% Da an�lise da Fig.22, Fig.23, Fig.24 e Fig.25 podemos verificar que o
% comportamento
% de chattering desapareceu tal como foi previsto no exerc�cio anterior.
% Tamb�m podemos ver o efeito do intervalo $y_l$ que eliminou o efeito de
% chattering a custo da velocidade de resposta do sistema. Esta degrada��o
% temporal � maior quanto maior for $y_l$ que para $y_l = 0.2$ corresponde
% a um atraso de resposta de aproximadamente 1.5 unidades temporais em
% rela��o ao sistema b�sico em cadeia fechada.

%%
% <html><h3>Controlador com apenas ramo superior da fun��o f(x)</h3></html>
%Valores do controlador completo
y0 = y;
dy0 = dy;
u0 = u;

%Subsys com apenas o ramo superior
f = 0;

%Tempo de Simula��o
ttotal = 7;

%Refer�ncia escolhida
Ref = 0;

%Sem perturba��o
b = 0;

%Intervalo escolhido do exerc�cio anterior 
yl = 0.2;

%Calculo dos k's
k1 = 1/yl;
k2 = sqrt(2*k1);

sim('modified_controller');

figure;
plot(tout, y0, "DisplayName", "completo");
hold on;
plot(tout, y, "DisplayName", "ramo superior");
grid on;
title('Fig.26 - Evolu��o temporal da posi��o radial da cabe�a (y)');
xlabel('Tempo');
ylabel('Posi��o (y)');
legend();

figure;
plot(tout, dy0, "DisplayName", "completo");
hold on;
plot(tout, dy, "DisplayName", "ramo superior");
grid on;
title('\textbf{Fig.27 - Evolu\c{c}\~ao temporal da velocidade radial da cabe\c{c}a ($\dot{y}$)}', 'Interpreter', 'latex');
xlabel('Tempo');
ylabel('Velocidade ($\dot{y}$)','Interpreter','latex');
legend('Location', 'NorthWest');

figure;
plot(y0, dy0, "DisplayName", "completo");
hold on;
plot(y, dy, "DisplayName", "ramo superior");
grid on;
title('\textbf{Fig.28 - Velocidade em fun\c{c}\~ao da posi\c{c}\~ao da cabe\c{c}a (y, $\dot{y}$)}', 'Interpreter', 'latex');
xlabel('Posi��o (y)');
ylabel('Velocidade ($\dot{y}$)','Interpreter','latex');
legend();

figure;
plot(tout, u0, "DisplayName", "completo");
hold on;
plot(tout, u, "DisplayName", "ramo superior");
grid on;
title('\textbf{Fig.29 - Evolu\c{c}\~ao temporal do Sinal de Controlo (u(y, $\dot{y}$))}', 'Interpreter', 'latex');
xlabel('Tempo');
ylabel('Sinal de Controlo (u(y, $\dot{y}$))','Interpreter','latex');
legend();

%%
% *Coment�rios:*
%
% Apartir da an�lise da Fig.26, Fig.27, Fig.28 e Fig.29 podemos concluir que o
% controlador com o Subsys descrito apenas pelo ramo superior tem um maior
% overshot no Sinal de Controlo o que por sua vez corresponde a uma
% velocidade m�xima maior e uma acelara��o m�xima superior, desnecess�rias 
% pois nada contribuem para a velocidade de resposta do sistema sendo o
% controlador completo de superior qualidade nestas condi��es pois evita
% consumo e desgaste desnecess�rio no motor e nas pe�as constituintes do
% sistema.

%% Exerc�cio 12
%Reset do ambiente de trabalho
clear;
close all;

%Subsys com ambos os ramos
f = 1;

%Tempo de Simula��o
ttotal = 7;

%Refer�ncia escolhida
Ref = 0;

%Com perturba��o
b = 0.025;

%Intervalo escolhido do exerc�cio anterior
yl = 0.2;

%Calculo dos k's
k1 = 1/yl;
k2 = sqrt(2*k1);

sim('modified_controller');

figure;
plot(tout, y);
grid on;
title('Fig.30 - Evolu��o temporal da posi��o radial da cabe�a (y)');
xlabel('Tempo');
ylabel('Posi��o (y)');

figure;
plot(tout, dy);
grid on;
title('\textbf{Fig.31 - Evolu\c{c}\~ao temporal da velocidade radial da cabe\c{c}a ($\dot{y}$)}', 'Interpreter', 'latex');
xlabel('Tempo');
ylabel('Velocidade ($\dot{y}$)','Interpreter','latex');

figure;
plot(y, dy);
grid on;
title('\textbf{Fig.32 - Velocidade em fun\c{c}\~ao da posi\c{c}\~ao da cabe\c{c}a (y, $\dot{y}$)}', 'Interpreter', 'latex');
xlabel('Posi��o (y)');
ylabel('Velocidade ($\dot{y}$)','Interpreter','latex');

figure;
plot(tout, u);
grid on;
title('\textbf{Fig.33 - Evolu\c{c}\~ao temporal do Sinal de Controlo (u(y, $\dot{y}$))}', 'Interpreter', 'latex');
xlabel('Tempo');
ylabel('Sinal de Controlo (u(y, $\dot{y}$))','Interpreter','latex');

%%
% *Coment�rios:*
% 
% Podemos verificar atrav�s da Fig.30, Fig.31, Fig.32 e Fig.33 que mesmo com uma
% perturba��o de $b=0.025$ o sistema ainda converge para os valores
% pretendidos. Tal n�o se verifica no caso do sistema em cadeia aberta do 
% Exerc�cio 7. Conclui-se portanto que este sistema � muito mais robusto a
% perturba��es externas que o sistema em cadeia aberto anterior.

%% Exerc�cio 13
% <html><h3>Exerc�cio 13.1 - Refer�ncia por steps</h3></html>
%Reset do ambiente de trabalho
clear;
close all;

%Subsys com ambos os ramos
f = 1;

%Tempo de Simula��o
ttotal = 20;

%Com perturba��o
b = 0;

%Intervalo escolhido do exerc�cio anterior
yl = 0.2;

%Calculo dos k's
k1 = 1/yl;
k2 = sqrt(2*k1);

sim('steps');

figure;
plot(tout, steps);
grid on;
title('Fig.34 - Refer�ncia por steps');
xlabel('Tempo');
ylabel('Valor Refer�ncia');

sim('e_131');

figure;
plot(tout, steps, "DisplayName", "Ref");
hold on;
plot(tout, y, "DisplayName", "y");
grid on;
title('Fig.35 - Evolu��o temporal da posi��o radial da cabe�a (y)');
xlabel('Tempo');
ylabel('Posi��o (y)');
legend();

figure;
plot(tout, dy);
grid on;
title('\textbf{Fig.36 - Evolu\c{c}\~ao temporal da velocidade radial da cabe\c{c}a ($\dot{y}$)}', 'Interpreter', 'latex');
xlabel('Tempo');
ylabel('Velocidade ($\dot{y}$)','Interpreter','latex');

figure;
plot(y, dy);
grid on;
title('\textbf{Fig.37 - Velocidade em fun\c{c}\~ao da posi\c{c}\~ao da cabe\c{c}a (y, $\dot{y}$)}', 'Interpreter', 'latex');
xlabel('Posi��o (y)');
ylabel('Velocidade ($\dot{y}$)','Interpreter','latex');

figure;
plot(tout, u);
grid on;
title('\textbf{Fig.38 - Evolu\c{c}\~ao temporal do Sinal de Controlo (u(y, $\dot{y}$))}', 'Interpreter', 'latex');
xlabel('Tempo');
ylabel('Sinal de Controlo (u(y, $\dot{y}$))','Interpreter','latex');

%%
% *Coment�rios:*
% Podemos observar apartir na Fig.35 que a posi��o da cabe�a de leitura
% tenta seguir o sinal de refer�ncia por steps mas como podemos ver no
% �nicio do gr�fico, como o sistema n�o � inst�ntaneo quando o intervalo de
% tempo � pequeno o sistema pode n�o conseguir atingir o valor de
% refer�ncia. Tamb�m se pode verificar o atraso de resposta nos instantes
% posteriores, caso existam muitas varia��es de per�odo pequeno o sistema
% pode tornar-se oscilat�rio sem nunca chegar ao sinal de refer�ncia.

%%
% <html><h3>Exerc�cio 13.2 - Refer�ncia por rampas</h3></html>
%Reset do ambiente de trabalho
clear;
close all;

%Subsys com ambos os ramos
f = 1;

%Tempo de Simula��o
ttotal = 20;

%Com perturba��o
b = 0;

%Intervalo escolhido do exerc�cio anterior
yl = 0.2;

%Calculo dos k's
k1 = 1/yl;
k2 = sqrt(2*k1);

sim('ramps');

figure;
plot(tout, ramps);
grid on;
title('Fig.39 - Refer�ncia por rampas');
xlabel('Tempo');
ylabel('Valor Refer�ncia');

sim('e_132');

figure;
plot(tout, ramps, "DisplayName", "Ref");
hold on;
plot(tout, y, "DisplayName", "y");
grid on;
title('Fig.40 - Evolu��o temporal da posi��o radial da cabe�a (y)');
xlabel('Tempo');
ylabel('Posi��o (y)');
legend('Location', 'NorthWest');

figure;
plot(tout, dy);
grid on;
title('\textbf{Fig.41 - Evolu\c{c}\~ao temporal da velocidade radial da cabe\c{c}a ($\dot{y}$)}', 'Interpreter', 'latex');
xlabel('Tempo');
ylabel('Velocidade ($\dot{y}$)','Interpreter','latex');

figure;
plot(y, dy);
grid on;
title('\textbf{Fig.42 - Velocidade em fun\c{c}\~ao da posi\c{c}\~ao da cabe\c{c}a (y, $\dot{y}$)}', 'Interpreter', 'latex');
xlabel('Posi��o (y)');
ylabel('Velocidade ($\dot{y}$)','Interpreter','latex');

%%
% *Coment�rios:*
% No caso em que a refer�ncia � dada por uma sequ�ncia de rampas podemos 
% verificar que o sinal t�m dificuldade a seguir as mesmas porque tem um
% atraso de resposta e limites f�sicos de velocidade o que impede o sistema
% de conseguir responder � refer�ncia antes desta voltar a zero como
% podemos observar na Fig.40. Tamb�m podemos concluir da Fig.41, apartir dos 
% picos de velocidade temporalmente coincidentes com as rampas de refer�ncia
% que o sistema tenta seguir o sinal de refer�ncia sem grande sucesso. No caso
% da ultima rampa que tende para infinito podemos verificar que o sistema 
% tenta seguir a mesma mantendo um erro constante, isto � devido a existir
% uma limita��o de satura��o do Sinal de Controlo que corresponde aos
% limites f�sicos do sistema, ou seja, o limite de velocidade e acelara��o
% da cabe�a do mesmo.

%Reset do ambiente de trabalho
clear;
close all;