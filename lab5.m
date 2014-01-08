% Paramerty symulacji 
T=25; % czas trwania symulacji 
dt=0.01; % krok czasowy rozwi?zywania rowna? ro?niczkowych 
 
% Paramerty ruchu pod?o?a 
A=0.05; % amplituda 
f=2*pi*5; % cz?sto?? 
Td=5; % opó?nienie pojawienia sie drga? pod?o?a 
 
g=9.81; % warto?? przyspieszenia grawitacyjnego 
 
% Parametry modelu 
m1=400; 
m2=50; 
k1=20000; 
b=2000; 
k2=200000; 
 
% Uruchomienie symulacji 
sim('model5.mdl'); 
 
% Prezentacja wynikow 
figure 
set(gcf,'Color',[1 1 1]); 
set(gca,'FontSize',24); 
subplot(3,1,1); plot(t,x1,'LineWidth',2); 
set(gca,'FontSize',24); 
title('Polozenie karoserii'); 
grid on; 
subplot(3,1,2); 
plot(t,x2,'LineWidth',2); 
set(gca,'FontSize',24); 
title('Polozenie kola'); 
grid on; 
subplot(3,1,3); 
plot(t,xp,'LineWidth',2); 
set(gca,'FontSize',24); 
title('Nawierzchnia'); 
grid on;