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
title('Refer�ncia por steps');
xlabel('Tempo');
ylabel('Valor Refer�ncia');

sim('e_131');

figure;
plot(tout, steps, "DisplayName", "Ref");
hold on;
plot(tout, y, "DisplayName", "y");
grid on;
title('Evolu��o temporal da posi��o radial da cabe�a (y)');
xlabel('Tempo');
ylabel('Posi��o (y)');
legend();

figure;
plot(tout, dy);
grid on;
title('\textbf{Evolu\c{c}\~ao temporal da velocidade radial da cabe\c{c}a ($\dot{y}$)}', 'Interpreter', 'latex');
xlabel('Tempo');
ylabel('Velocidade ($\dot{y}$)','Interpreter','latex');

figure;
plot(y, dy);
grid on;
title('\textbf{Velocidade em fun\c{c}\~ao da posi\c{c}\~ao da cabe\c{c}a (y, $\dot{y}$)}', 'Interpreter', 'latex');
xlabel('Posi��o (y)');
ylabel('Velocidade ($\dot{y}$)','Interpreter','latex');

figure;
plot(tout, u);
grid on;
title('\textbf{Evolu\c{c}\~ao temporal do Sinal de Controlo (u(y, $\dot{y}$))}', 'Interpreter', 'latex');
xlabel('Tempo');
ylabel('Sinal de Controlo (u(y, $\dot{y}$))','Interpreter','latex');

%%
% *Coment�rios:*
% Podemos observar apartir na Fig.x que a posi��o da cabe�a de leitura
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
title('Refer�ncia por rampas');
xlabel('Tempo');
ylabel('Valor Refer�ncia');

sim('e_132');

figure;
plot(tout, ramps, "DisplayName", "Ref");
hold on;
plot(tout, y, "DisplayName", "y");
grid on;
title('Evolu��o temporal da posi��o radial da cabe�a (y)');
xlabel('Tempo');
ylabel('Posi��o (y)');
legend('Location', 'NorthWest');

figure;
plot(tout, dy);
grid on;
title('\textbf{Evolu\c{c}\~ao temporal da velocidade radial da cabe\c{c}a ($\dot{y}$)}', 'Interpreter', 'latex');
xlabel('Tempo');
ylabel('Velocidade ($\dot{y}$)','Interpreter','latex');

figure;
plot(y, dy);
grid on;
title('\textbf{Velocidade em fun\c{c}\~ao da posi\c{c}\~ao da cabe\c{c}a (y, $\dot{y}$)}', 'Interpreter', 'latex');
xlabel('Posi��o (y)');
ylabel('Velocidade ($\dot{y}$)','Interpreter','latex');

%%
% *Coment�rios:*
% No caso em que a refer�ncia � dada por uma sequ�ncia de rampas podemos 
% verificar que o sinal t�m dificuldade a seguir as mesmas porque tem um
% atraso de resposta e limites f�sicos de velocidade o que impede o sistema
% de conseguir responder � refer�ncia antes desta voltar a zero como
% podemos observar na Fig.x. Tamb�m podemos concluir da Fig.x, apartir dos 
% picos de velocidade temporalmente coincidentes com as rampas de refer�ncia
% que o sistema tenta seguir o sinal de refer�ncia sem grande sucesso. No caso
% da ultima rampa que tende para infinito podemos verificar que o sistema 
% tenta seguir a mesma mantendo um erro constante, isto � devido a existir
% uma limita��o de satura��o do Sinal de Controlo que corresponde aos
% limites f�sicos do sistema.