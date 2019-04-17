function u = cont_10(yl, y, dy)
%Inicializa��o de u com zeros em todos os indexes
u = zeros(size(y));

%Calculo dos k's
k1 = 1/yl;
k2 = sqrt(2*k1);

%Subsys por ramos
for n = 1:length(y)
    if abs(y(n)) <= yl
        u(n) = (k1/k2)*-y(n);
    else
        u(n) = sign( -y(n) )*(sqrt(2*abs( -y(n) ))-(1/k2));
    end
end

%Subtrac��o de dy
u = u - dy;

%Aplica��o do ganho k2
u = u * k2;

%Filtro de satura��o
idx = u > 1;
u(idx) = 1;

idx = u < -1;
u(idx) = -1;
end

