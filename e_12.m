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
title('Evolu��o temporal da posi��o radial da cabe�a (y)');
xlabel('Tempo');
ylabel('Posi��o (y)');

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
% 
% Podemos verificar atrav�s da Fig.x, Fig.x, Fig.x e Fig.x que mesmo com uma
% perturba��o de $b=0.025$ o sistema ainda converge para os valores
% pretendidos. Tal n�o se verifica no caso do sistema em cadeia aberta do 
% Exerc�cio 7. Conclui-se portanto que este sistema � muito mais robusto a
% perturba��es externas que o sistema em cadeia aberto anterior.