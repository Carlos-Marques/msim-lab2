function [U1, U2, T] = GetUsT(alpha, beta)

%Escolher o T mínimo de acordo com as condições calculadas Teóricamente
T = max(sqrt(2*(1+beta)*(1+alpha)), (1/sqrt(alpha))*sqrt(2*(1+beta)*(1+alpha)));

T1 = T/(1+alpha);

U1 = -(2/(T1^2))*((1+beta)/(1+alpha));
U2 = -(U1/alpha);
end

