% Amir kabir University of Technology (Tehran Polytechnic)
% Computer & Information Technology Engineering Department
% Resource Allocation in Wireless Networks
% TPC-SR Simulation using MATLAB
% Programmer: SeyedHedayat Hosseini
% Date: December, 2015
% Matlab Version: R2014b
% ******************************************************** %

function [P,Gamma,Outage_probability,Aggregate_power]= TPC_SR(P_bar,Gamma_hat,Noise,initial_power,H,show_plot)
%This function simulate Costrained TPC algorithm



iteration=100;
L1=length(H(:,1));
L2=length(H(1,:));

%memory allocation
P=zeros(iteration,L2);
Gamma=zeros(iteration,L2);

R_i_th=zeros(1,L2);
Eta_vector=zeros(1,L2);
R_i=zeros(1,L2);

P(1,:)=initial_power;
Gamma(1,:)=SINR(H,initial_power,Noise);

R_i_th=P_bar./Gamma_hat;
Eta_vector=R_i_th.^2.*Gamma_hat; % Or equal to: Eta_vector=P_bar.^2./Gamma_hat




%Approach #1
for i=2:iteration
    R_i=P(i-1,:)./Gamma(i-1,:);
   for j=1:L2
       if(R_i(1,j)<=R_i_th(1,j))   % TPC-SR Uses TPC Algorithm
          P(i,j)=Gamma_hat(1,j)/Gamma(i-1,j)*P(i-1,j); 
       else               %TPC-SR Uses OPC Algorithm
          P(i,j)=Eta_vector(1,j)*Gamma(i-1,j)/P(i-1,j);
       end  
   end
        
   Gamma(i,:)=SINR(H,P(i,:),Noise);
 %  if(abs(P(i,:) - P(i-1,:))<=0.000001)
 %  break     


end

%Approach #2 ==>  TPC-SR chooses minimum of OPC Algorithm & TPC Algorithm
%for i = 2 : iteration
%    % for j = 1 : L2  
%          p(i,:) = min((Gamma_hat(1,:)./Gamma(i-1,:).*P(i-1,:)),(Eta_vector(1,:).*Gamma(i-1,:)./P(i-1,:)));
%     %end
%     Gamma(i,:)=SINR(H,P(i,:),Noise);
%    % if(abs(p(i,:) - p(i-1,:))<=0.000001)
%     %break
%end


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
    
    figure(2);

    for i=1:L2
    

   
        plot(1:iteration,P(:,i)),grid on,grid minor;
        title('Plot of TPC-SR Power');
        xlabel('Iterations');
        ylabel('Powers');
        hold on;
    end

    figure(3);

    for i=1:L2
    

   
        plot(1:iteration,Gamma(:,i)),grid on,grid minor;
        title('Plot of TPC-SR SINR');
        xlabel('Iterations');
        ylabel('SINR');
        hold on;
    end

end
end



