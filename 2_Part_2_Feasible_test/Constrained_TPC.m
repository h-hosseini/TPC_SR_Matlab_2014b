% Amir kabir University of Technology (Tehran Polytechnic)
% Computer & Information Technology Engineering Department
% Resource Allocation in Wireless Networks
% TPC-SR Simulation using MATLAB
% Programmer: SeyedHedayat Hosseini
% Date: December, 2015
% Matlab Version: R2014b
% ******************************************************** %

function [P,Gamma,Outage_probability,Aggregate_power]= Constrained_TPC(P_bar,Gamma_hat,Noise,initial_power,H,show_plot)
%This function simulate Costrained TPC algorithm

P(1,:)=initial_power;
Gamma(1,:)=SINR(H,initial_power,Noise);

iteration=100;
L1=length(H(:,1));
L2=length(H(1,:));


for i=1:L2

    if P(1,i)>P_bar(1,i)
            P(1,i)= P_bar(1,i);
        end
end

for i=2:iteration
    P(i,:)=Gamma_hat(1,:)./Gamma(i-1,:).*P(i-1,:);
    for j=1:L2
        if P(i,j)>P_bar(1,j)
            P(i,j)= P_bar(1,j);
        end
    end

     Gamma(i,:)=SINR(H,P(i,:),Noise);

%  if(abs(P(i,:) - P(i-1,:))<=0.000001)
 %  break     
 
end



Aggregate_power=0;
Sum_Outage=0;
for j=1:L2
    if ((Gamma_hat(1,j)-Gamma(i,j))>10^-5)
        Sum_Outage=Sum_Outage+1;
    end
    Aggregate_power=Aggregate_power+P(i,j);
end
Outage_probability=Sum_Outage/L2;

if (show_plot)
    figure(5);

    for i=1:L2
    

   
        plot(1:iteration,P(:,i)),grid on,grid minor;
        title('Plot of TPC Power');
        xlabel('iterations');
        ylabel('Powers');
        hold on;
    end

    figure(6);

    for i=1:L2
    

   
        plot(1:iteration,Gamma(:,i)),grid on,grid minor;
        title('Plot of TPC SINR');
        xlabel('Iterations');
        ylabel('SINR');
        hold on;
    end
end

end



