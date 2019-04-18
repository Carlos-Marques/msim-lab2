%% Exercício 12
%Reset do ambiente de trabalho
clear;
close all;

%Subsys com ambos os ramos
f = 1;

%Tempo de Simulação
ttotal = 7;

%Referência escolhida
Ref = 0;

%Com perturbação
b = 0.025;

%Intervalo escolhido do exercício anterior
yl = 0.2;

%Calculo dos k's
k1 = 1/yl;
k2 = sqrt(2*k1);

sim('modified_controller');

figure;
plot(tout, y);
grid on;
title('Evolução temporal da posição radial da cabeça (y)');
xlabel('Tempo');
ylabel('Posição (y)');

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
xlabel('Posição (y)');
ylabel('Velocidade ($\dot{y}$)','Interpreter','latex');

figure;
plot(tout, u);
grid on;
title('\textbf{Evolu\c{c}\~ao temporal do Sinal de Controlo (u(y, $\dot{y}$))}', 'Interpreter', 'latex');
xlabel('Tempo');
ylabel('Sinal de Controlo (u(y, $\dot{y}$))','Interpreter','latex');

%%
% *Comentários:*
% 
% Podemos verificar através da Fig.x, Fig.x, Fig.x e Fig.x que mesmo com uma
% perturbação de $b=0.025$ o sistema ainda converge para os valores
% pretendidos. Tal não se verifica no caso do sistema em cadeia aberta do 
% Exercício 7. Conclui-se portanto que este sistema é muito mais robusto a
% perturbações externas que o sistema em cadeia aberto anterior.