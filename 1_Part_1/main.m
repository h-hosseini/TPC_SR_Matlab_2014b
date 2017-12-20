% Amir kabir University of Technology (Tehran Polytechnic)
% Computer & Information Technology Engineering Department
% Resource Allocation in Wireless Networks
% TPC-SR Simulation using MATLAB
% Programmer: SeyedHedayat Hosseini
% Date: December, 2015
% Matlab Version: R2014b
% ************* MAIN SCRIPT ************* %

clc;
clear all ;
show=1;
dontshow=0;

BG_Noise = 10^(-12);

Outage_Probability=zeros(2,7);
Aggregate_Power=zeros(2,7); 

for NU=1:7
    P_bar=ones(1,NU*4)*10^-3;
    Gamma_hat=ones(1,NU*4)*0.2;

    D=Distance_Generator(NU,dontshow);
    H=PathGain_Generator(D,0.09,-3);

    initial_power=ones(1,NU*4).*(rand(1,NU*4)*10^-3);


    [P_TPC_SR,SINR_TPC_SR,TPC_SR_Outage_probability,TPC_SR_Aggregate_power]= TPC_SR (P_bar,Gamma_hat,BG_Noise,initial_power,H,dontshow);
    [P_TPC,SINR_TPC,TPC_Outage_probability,TPC_Aggregate_power]= Constrained_TPC(P_bar,Gamma_hat,BG_Noise,initial_power,H,dontshow);
     
    Outage_Probability(1,NU)=TPC_SR_Outage_probability;
    Outage_Probability(2,NU)=TPC_Outage_probability;
    
    Aggregate_Power(1,NU)=TPC_SR_Aggregate_power; 
    Aggregate_Power(2,NU)=TPC_Aggregate_power;

    
end

figure(6);

 plot(4:4:NU*4,Outage_Probability(1,1:NU),'B-o'),grid on,grid minor;
 hold on;
 plot(4:4:NU*4,Outage_Probability(2,1:NU),'R-^'),grid on,grid minor;
 legend('TPC-SR','TPC');
 title('Plot of Outage probability');
 xlabel('Number of Users');
 ylabel('Outage probability');

 
 figure(7);

 plot(4:4:NU*4,Aggregate_Power(1,1:NU),'B-o'),grid on,grid minor;
 hold on;
 plot(4:4:NU*4,Aggregate_Power(2,1:NU),'R-^'),grid on,grid minor;
 legend('TPC-SR','TPC');
 title('Plot of Aggregate Power');
 xlabel('Number of Users');
 ylabel('Aggregate Power(W)');
