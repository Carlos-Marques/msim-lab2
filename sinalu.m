function [u, uT] = sinalu(T, alfa, beta, U1, U2, n1, n2)

        T1 = T/(1+alfa);
        T2 = alfa*T1;
        
        %para imp prot 1
        lim = (1+beta)/2;
        t = linspace(-lim,lim, n1);
        
        ip1 = U1*ImpulsoPrototipo(t, beta);
        
        %para imp prot 2
        lim = (1+beta)/2;
        t = linspace(-lim,lim, n2);
        
        ip2 = U2*ImpulsoPrototipo(t, beta);

        u = [ip1 ip2(2:end)]; %concatenar os dois sinais e retirar o ponto e que se interseptam
        
        %vector de instantes
        uT1 = linspace(0,T1, n1);
        uT2 = linspace(T1,T, n2);
        uT = [uT1 uT2(2:end)];
end