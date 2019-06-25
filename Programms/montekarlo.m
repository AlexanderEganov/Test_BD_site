clc;clear;
close all;
% hold on;
% grid on;

t1 = pi;
dt = 1e-2;
i = 1;

n=1e3;
Y = zeros(n,2);
for j = 1:n
    
    x0 = -1 +2*rand;
    v0 = rand;
    y = [x0 v0];
    
    for t=0:dt:t1
        x = y(1);v = y(2);
        y = y + [v t-x]*dt;
%         if mod(round(t/dt),5) ==0
%             plot(t,x,'.b');
%             pause(1e-3);
%         end
        
    end
    Y(i,:) = [x v];
    i = i+1;
end

i = 1;
n = round(max(9*std(Y).^2/(0.01)^2));
max(9*std(Y).^2/(0.01)^2)
Y = zeros(n,2);
for j = 1:n
    
    x0 = -1 +2*rand;
    v0 = rand;
    y = [x0 v0];
    
    for t=0:dt:t1
        x = y(1);v = y(2);
        y = y + [v t-x]*dt;
%         if mod(round(t/dt),5) ==0
%             plot(t,x,'.b');
%             pause(1e-3);
%         end
        
    end
    Y(i,:) = [x v];
    i = i+1;
end
3*std(Y)/sqrt(n)
% mean(Y)
% hold off;