function pb = ImpulsoPrototipo(t, beta)

pb = zeros(size(t));

for i=1:length(t)
   if t(i)>=(-(beta+1)/2) && t(i)<-0.5
       
       d = (beta/2) - abs(t(i)+0.5);
       h = (4/(beta^2))*(t(i)+0.5)+(2/beta);
       
       pb(i) = (d*h)/2;
       
   elseif t(i)>=-0.5 && t(i)<((beta-1)/2)
       
       d = (beta/2) - abs(t(i)+0.5);
       h = (-4/(beta^2))*(t(i)+0.5)+(2/beta);
       
       pb(i) = 1-((d*h)/2);
   
   elseif t(i)>=((beta-1)/2) && t(i)<(-(beta-1)/2)
       
       pb(i) = 1;
   
   elseif t(i)>=(-(beta-1)/2) && t(i)<0.5
       
       d = (beta/2) - abs(t(i)-0.5);
       h = (4/(beta^2))*(t(i)-0.5)+(2/beta);
       
       pb(i) = 1-((d*h)/2);
   
   elseif t(i)>=0.5 && t(i)<((beta+1)/2);
       
       d = (beta/2) - abs(t(i)-0.5);
       h = (-4/(beta^2))*(t(i)-0.5)+(2/beta);
       
       pb(i) = (d*h)/2;
   
   else
       
       pb(i) = 0;
       
   end
end
end